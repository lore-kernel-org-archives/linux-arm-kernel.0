From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:16 -0700
Subject: [PATCH 2/6] selftest/kdbus: enable cross compilation
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-3-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CC variable instead of hard coding gcc and include lib.mk.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/kdbus/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kdbus/Makefile b/tools/testing/selftests/kdbus/Makefile
index f6cfab2..de8242f 100644
--- a/tools/testing/selftests/kdbus/Makefile
+++ b/tools/testing/selftests/kdbus/Makefile
@@ -33,11 +33,13 @@ OBJS= \
 
 all: kdbus-test
 
+include ../lib.mk
+
 %.o: %.c
-	gcc $(CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) -c $< -o $@
 
 kdbus-test: $(OBJS)
-	gcc $(CFLAGS) $^ $(LDLIBS) -o $@
+	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@
 
 run_tests:
 	./kdbus-test --tap
-- 
2.1.4
