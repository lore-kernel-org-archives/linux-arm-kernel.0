From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:20 -0700
Subject: [PATCH 6/6] selftest/mqueue: enable cross compilation
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-7-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CC variable instead of hard coding gcc. Also clean up the compiler
options by creating a CFLAGS variable.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/mqueue/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
index 6ca7261..0e3b41e 100644
--- a/tools/testing/selftests/mqueue/Makefile
+++ b/tools/testing/selftests/mqueue/Makefile
@@ -1,6 +1,8 @@
+CFLAGS = -O2
+
 all:
-	gcc -O2 mq_open_tests.c -o mq_open_tests -lrt
-	gcc -O2 -o mq_perf_tests mq_perf_tests.c -lrt -lpthread -lpopt
+	$(CC) $(CFLAGS) mq_open_tests.c -o mq_open_tests -lrt
+	$(CC) $(CFLAGS) -o mq_perf_tests mq_perf_tests.c -lrt -lpthread -lpopt
 
 include ../lib.mk
 
-- 
2.1.4
