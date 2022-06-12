import Foundation
// collections
let text = "It's hard to come up with fresh exercises.\nOver and over again.\nAnd again."
let lines = text.reduce(0) { (acc: Int, char: Character) in if char == "\n" {
    return acc + 1
} else {
    return acc
}
}

print(lines)
func create_random_array(lower _: Int, higher _: Int) {}

extension RangeExpression where Bound: FixedWidthInteger {
    func random_list(n: Int) -> [Bound] {
        precondition(n > 0)
        switch self {
        case let range as Range<Bound>: return (0 ..< n).map { _ in .random(in: range) }
        case let range as ClosedRange<Bound>: return (0 ... n).map { _ in .random(in: range) }
        default: return []
        }
    }
}

var grades = (0 ... 100).random_list(n: 100)

let res = grades.reduce(into: [:]) { (results: inout [Character: Int], grade: Int) in
    switch grade {
    case 0 ..< 60: results["D", default: 0] += 1
    case 60 ..< 75: results["C", default: 0] += 1
    case 75 ..< 90: results["B", default: 0] += 1
    case 90 ... 100: results["A", default: 0] += 1
    default: break
    }
}

print(res)
// print(zip(["a","b","c"], 1..<10))
let range = 0 ..< Int16.max

/// define a number is a square number
func isSquare(_ n: Int) -> Bool {
    let x = Int(sqrt(Swift.Double(n)))
    let seq = [x, x + 1]
    for i in seq {
        if i * i == n {
            return true
        }
    }
    return false
}

let filtered = range.filter { x in isSquare(Int(x)) }
let last_three = filtered.suffix(3)
print(last_three)
print(isSquare(25))

class Squares: Sequence, IteratorProtocol {
    var state = 1
    var end: Int
    private var store: [Int] = []
    init(length: Int) {
        end = length
    }

    func next() -> Int? {
        if state > end { return nil }
        else {
            let res = state * state
            state += 1
            return res
        }
    }
}

extension Squares: CustomStringConvertible {
    public var description: String {
        var desc = String()
        for (index, value) in store.enumerated() {
            if index == 0 {
                desc.append("square number: [\(value), ")
            } else if index == store.count - 1 {
                desc.append("\(value)]\n")
            } else {
                desc.append("\(value), ")
            }
        }
        return desc
    }
}

print(Array(Squares(length: 20)))
class Fib1: IteratorProtocol {
    var tuple = (0, 1)
    var stop: Int
    var iter = 0
    init(length: Int) {
        stop = length
    }

    func next() -> Int? {
        guard iter < stop else { return nil }
        iter += 1
        let next = tuple.0
        tuple = (tuple.1, tuple.0 + tuple.1)
        return next
    }
}

class Fib2: Sequence {
    var state = (0, 1)
    var end: Int
    var iteration_count = 0

    init(iterator_length: Int) {
        end = iterator_length
    }

    func makeIterator() -> AnyIterator<Int> {
        return Iterator { [self] in
            guard iteration_count < end else { return nil }
            iteration_count += 1
            let res = state.0
            state = (state.1, state.0 + state.1)
            return res
        }
    }
}

print(Array(Fib2(iterator_length: 15)))
func lucas(n: Int) -> AnyIterator<Int> {
    var next_values = (2, 1)
    var iter = 0
    return AnyIterator {
        guard iter < n else { return nil }
        iter += 1
        let next = next_values.0
        next_values = (next_values.1, next_values.0 + next_values.1)
        return next
    }
}

print(Array(lucas(n: 10)))

// get random number in range without x
func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
    if range.contains(x) {
        let arr1 = Array(ClosedRange(uncheckedBounds: (range.lowerBound, x)))
        let arr2 = Array((x + 1) ... range.upperBound)
        let arr = arr1 + arr2
        let r = arr.randomElement()!
        return r
    } else {
        return Int.random(in: range)
    }
}

print(random(in: 1 ... 10, excluding: 2))

// infinite sequence
struct Double: Sequence, IteratorProtocol {
    var state = 1
    mutating func next() -> Int? {
        defer {
            state *= 2
        }
        return state
    }
}

print(Array(Double().prefix(10)))
