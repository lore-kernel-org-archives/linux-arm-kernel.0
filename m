From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:04:56 +0100
Subject: [PATCH v2 00/10] ARM: kprobes: Add test code to kernel tree
Message-ID: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is pretty much an essential tool for anyone debugging or extending
the kprobes instruction simulation code and is a good regression test
for kprobes on ARM.

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

Changes since v1:
 - Changed KConfig configuration options to only use a single symbol.

Contents:
[PATCH v2 01/10] ARM: kprobes: Add config option for selecting the ARM kprobes tests
[PATCH v2 02/10] ARM: kprobes: Add basic API tests
[PATCH v2 03/10] ARM: kprobes: Framework for instruction set test cases
[PATCH v2 04/10] ARM: kprobes: Add Thumb instruction simulation test cases
[PATCH v2 05/10] ARM: kprobes: Add ARM instruction simulation test cases
[PATCH v2 06/10] ARM: kprobes: Add exports for test code
[PATCH v2 07/10] ARM: kprobes: Add decoding table self-consistency tests
[PATCH v2 08/10] ARM: kprobes: Add decoding table test coverage analysis
[PATCH v2 09/10] ARM: kprobes: Add some benchmarking to test module
[PATCH v2 10/10] ARM: kprobes: Add introductory comment to test code

---
 arch/arm/Kconfig.debug               |    6 +
 arch/arm/kernel/Makefile             |    7 +
 arch/arm/kernel/kprobes-arm.c        |    4 +
 arch/arm/kernel/kprobes-test-arm.c   | 1323 +++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test-thumb.c | 1187 +++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.c       | 1756 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.h       |  392 ++++++++
 arch/arm/kernel/kprobes-thumb.c      |    7 +
 arch/arm/kernel/kprobes.h            |    8 +
 9 files changed, 4690 insertions(+), 0 deletions(-)
