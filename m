From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:14:09 -0700
Subject: [PATCH v3 2/8] selftests/ftrace: install test.d
Message-ID: <1429571649-26089-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ftrace test requires the directory test.d and all of it's contents to be
present during execution. Use TEST_DIRS to ensure this is copied to the
INSTALL_PATH.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/ftrace/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index 3467206..0acbeca 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -1,6 +1,7 @@
 all:
 
 TEST_PROGS := ftracetest
+TEST_DIRS := test.d/
 
 include ../lib.mk
 
-- 
2.1.4
