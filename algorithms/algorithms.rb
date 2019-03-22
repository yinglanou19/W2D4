def my_min(array)
  # O(n^2)
  #   (0...array.length).each do |i|
  #     found_min = true
  #     (0...array.length).each do |j|
  #       found_min = false if array[i] > array[j]
  #     end
  #     return array[i] if found_min
  #   end
  # O(n)
  min = array.first
  (1...array.length).each do |i|
    min = array[i] if min > array[i]
  end
  return min
end

def largest_contiguous_subsum(array)
  #   O(n^3)
  #   sum = nil
  #   (0..array.length - 1).each do |i|
  #     (i...array.length).each do |j|
  #       sub = array[i..j]
  #       sum = sub.sum if sum.nil? || sub.sum > sum
  #     end
  #   end
  #   sum

  # O(n)
  max_sum = array.first
  curr_sum = array.first
  (1...array.length).each do |i|
    if curr_sum + array[i] > array[i]
      curr_sum += array[i]
    else
      curr_sum = array[i]
    end
    max_sum = curr_sum if curr_sum > max_sum
  end
  max_sum
end

###################################################

# phase 1
# total:  O(n * n!)
def first_anagram?(str1, str2)
  array = str1.split("")
  perms = permutation(array)
  return perms.include?(str2.split(""))
end

# O(n!)
# space O(n^n)
def permutation(array)
  return [array] if array.length <= 1
  el = array.first
  permutations = permutation(array[1..-1])
  res = []
  permutations.each do |perm|
    (0..perm.length).each do |i|
      res << (perm[0...i] + [el] + perm[i..-1])
    end
  end
  res
end

# phase 2
# O(n^2)   iterate through str1, find and delete each char on str2
def second_anagram?(str1, str2)
  str1.each_char do |char| #O(n)
    idx = str2.index(char) # O(n)
    return false if idx.nil?
    str2.delete!(char)     #O(n)
  end
  return str2.empty?
end

#phase 3
# O(n log n)   sort both strings and compare
def third_anagram?(str1, str2)
  array1 = str1.split("").sort
  array2 = str2.split("").sort
  return array1 == array2
end

# phase 4  use two hashes
#O(n)
def fourth_anagram?(str1, str2)
  return false if str1.length != str2.length
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  str1.each_char do |char|
    hash1[char] += 1
  end
  str2.each_char do |char|
    hash2[char] += 1
  end
  return hash1 == hash2
end

# phase 5   use one hash
def fifth_anagram?(str1, str2)
  return false if str1.length != str2.length
  hash1 = Hash.new(0)
  str1.each_char do |char|
    hash1[char] += 1
  end
  str2.each_char do |char|
    return false if hash1.has_key?(char) || hash1[char] == 0
    hash1[char] -= 1
  end
  return true
end

###########################################

# O(n^2)
def bad_two_sum?(arr, target_sum)
  (0...arr.length).each do |i|
    (i + 1...arr.length).each do |j|
      sum = arr[i] + arr[j]
      return true if sum == target_sum
    end
  end
  return false
end

def okay_two_sum?(arr, target_sum)
  # sort => nlog n
  # each
  #      bsearch - log n
  # total : n log n    +     n * log n
  arr.sort!
  idx = 0
  while arr[idx] < (target_sum - arr[idx])
    return true if bsearch(arr[idx + 1..-1], target_sum - arr[idx])
    idx += 1
  end
  return false
end

def bsearch(arr, target)
  return false if arr.empty?
  mid = arr.length / 2
  return true if arr[mid] == target
  if arr[mid] > target
    return bsearch(arr.take(mid), target)
  else
    return bsearch(arr.drop(mid + 1), target)
  end
end

# O(n)
def two_sum?(arr, target_sum)
  hash = Hash.new(0)
  (0...arr.length).each do |i|
    return true if hash.has_key?(target_sum - arr[i])
    hash[arr[i]] += 1
  end
  return false
end

def windowed_max_range(array, w)
  current_max_range = nil
  (0..array.length - w).each do |i|
    minmax_array = array[i..i + w - 1].minmax
    curr_range = minmax_array[1] - minmax_array[0]
    current_max_range = curr_range if current_max_range.nil? || curr_range > current_max_range
  end
  return current_max_range
end

class MyQueue
  def initialize
    @array = Array.new
  end

  def enqueue(el)
    @array << el
  end

  def dequeue
    @array.shift
  end

  def peek
    @array.first
  end

  def size
    @array.size
  end

  def empty?
    @array.empty?
  end
end

class MyStack
  def initialize
    @array = []
  end

  def push(el)
    @array << el
  end

  def pop
    @array.pop
  end

  def peek
    @array.last
  end

  def size
    @array.size
  end

  def empty?
    @array.empty?
  end
end

class StackQueue
end
