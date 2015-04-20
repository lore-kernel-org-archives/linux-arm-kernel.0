From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 20 Apr 2015 16:14:45 -0700
Subject: [PATCH v3 4/8] selftests/kdbus: install kdbus-test
Message-ID: <1429571685-26643-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set TEST_PROGS so that kdbus-test is installed.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/kdbus/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kdbus/Makefile b/tools/testing/selftests/kdbus/Makefile
index de8242f..94ea75b 100644
--- a/tools/testing/selftests/kdbus/Makefile
+++ b/tools/testing/selftests/kdbus/Makefile
@@ -41,6 +41,8 @@ include ../lib.mk
 kdbus-test: $(OBJS)
 	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@
 
+TEST_PROGS := kdbus-test
+
 run_tests:
 	./kdbus-test --tap
 
-- 
2.1.4
