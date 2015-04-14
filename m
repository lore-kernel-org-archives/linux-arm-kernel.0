From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 14 Apr 2015 15:52:34 -0700
Subject: [PATCH 4/7] selftests/kdbus: install kdbus-test
Message-ID: <1429051954-14735-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set TEST_PROGS so that kdbus-test is installed.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/kdbus/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kdbus/Makefile b/tools/testing/selftests/kdbus/Makefile
index e21bf1f..62f8d5a 100644
--- a/tools/testing/selftests/kdbus/Makefile
+++ b/tools/testing/selftests/kdbus/Makefile
@@ -42,6 +42,8 @@ include ../lib.mk
 kdbus-test: $(OBJS)
 	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@
 
+TEST_PROGS := kdbus-test
+
 run_tests:
 	./kdbus-test --tap
 
-- 
2.1.0
