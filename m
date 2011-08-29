From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 13:34:09 +0100
Subject: [PATCH 10/10] ARM: kprobes: Add introductory comment to test code
In-Reply-To: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314621249-958-11-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index ec41ead..96cf18a 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -9,6 +9,27 @@
  */
 
 /*
+ * This file contains test code for ARM kprobes.
+ *
+ * The top level function run_all_tests() executes tests for all of the
+ * supported instruction sets: ARM, 16-bit Thumb, and 32-bit Thumb. These tests
+ * fall into two categories; run_api_tests() checks basic functionality of the
+ * kprobes API, and run_test_cases() is a comprehensive test for kprobes
+ * instruction decoding and simulation.
+ *
+ * run_test_cases() first checks the kprobes decoding table for self consistency
+ * (using table_test()) then executes a series of test cases for each of the CPU
+ * instruction forms. coverage_start() and coverage_end() are used to verify
+ * that these test cases cover all of the possible combinations of instructions
+ * described by the kprobes decoding tables.
+ *
+ * The individual test cases are in kprobes-test-arm.c and kprobes-test-thumb.c
+ * which use the macros defined in kprobes-test.h. The rest of this
+ * documentation will describe the operation of the framework used by these
+ * test cases.
+ */
+
+/*
  * TESTING METHODOLOGY
  * -------------------
  *
-- 
1.7.2.5
