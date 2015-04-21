From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 21 Apr 2015 15:51:58 -0700
Subject: [PATCH v4 6/7] selftests/x86: install tests
Message-ID: <1429656718-10436-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include lib.mk and set TEST_PROGS where appropriate.

Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index ec7b088..4af1e48 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,9 +14,13 @@ UNAME_M := $(shell uname -m)
 ifeq ($(CROSS_COMPILE),)
 # Always build 32-bit tests
 all: all_32
+# Install 32-bit tests
+TEST_PROGS += $(BINARIES_32) run_x86_tests.sh
 # If we're on a 64-bit host, build 64-bit tests as well
 ifeq ($(UNAME_M),x86_64)
 all: all_64
+# Install 64-bit tests
+TEST_PROGS += $(BINARIES_64)
 endif
 endif
 
@@ -24,6 +28,8 @@ all_32: check_build32 $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
+include ../lib.mk
+
 clean:
 	$(RM) $(BINARIES_32) $(BINARIES_64)
 
-- 
2.1.4
