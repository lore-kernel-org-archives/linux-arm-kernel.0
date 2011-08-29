From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 13:33:59 +0100
Subject: [PATCH 00/10] ARM: kprobes: Test code
Message-ID: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds test code for ARM kprobes.

The top level function run_all_tests() executes tests for all of the
supported instruction sets: ARM, 16-bit Thumb, and 32-bit Thumb. These
tests fall into two categories; run_api_tests() checks basic
functionality of the kprobes API, and run_test_cases() is a
comprehensive test for kprobes instruction decoding and simulation.

run_test_cases() first checks the kprobes decoding table for self
consistency (using table_test()) then executes a series of test cases
for each of the CPU instruction forms. coverage_start(), and
coverage_end() are used to verify that these test cases cover all of the
possible combinations of instructions described by the kprobes decoding
tables.

The individual test cases are in kprobes-test-arm.c and
kprobes-test-thumb.c which use the macros defined in kprobes-test.h

Contents:
[PATCH 01/10] ARM: kprobes: Add config option for selecting the ARM kprobes tests
[PATCH 02/10] ARM: kprobes: Add basic API tests
[PATCH 03/10] ARM: kprobes: Framework for instruction set test cases
[PATCH 04/10] ARM: kprobes: Add Thumb instruction simulation test cases
[PATCH 05/10] ARM: kprobes: Add ARM instruction simulation test cases
[PATCH 06/10] ARM: kprobes: Add exports for test code
[PATCH 07/10] ARM: kprobes: Add decoding table self-consistency tests
[PATCH 08/10] ARM: kprobes: Add decoding table test coverage analysis
[PATCH 09/10] ARM: kprobes: Add some benchmarking to test module
[PATCH 10/10] ARM: kprobes: Add introductory comment to test code

---
 arch/arm/Kconfig.debug               |   10 +
 arch/arm/kernel/Makefile             |    7 +
 arch/arm/kernel/kprobes-arm.c        |    2 +
 arch/arm/kernel/kprobes-test-arm.c   | 1323 +++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test-thumb.c | 1187 +++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.c       | 1756 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.h       |  392 ++++++++
 arch/arm/kernel/kprobes-thumb.c      |    3 +
 arch/arm/kernel/kprobes.h            |   21 +
 9 files changed, 4701 insertions(+), 0 deletions(-)
