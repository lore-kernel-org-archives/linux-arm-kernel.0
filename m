From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:19 -0700
Subject: [PATCH 5/6] selftest/ipc: enable cross compilation
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-6-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CC variable instead of hard coding gcc.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/ipc/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index 3b6013d..25d2e70 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -12,11 +12,7 @@ endif
 CFLAGS += -I../../../../usr/include/
 
 all:
-ifeq ($(ARCH),x86)
-	gcc $(CFLAGS) msgque.c -o msgque_test
-else
-	echo "Not an x86 target, can't build msgque selftest"
-endif
+	$(CC) $(CFLAGS) msgque.c -o msgque_test
 
 TEST_PROGS := msgque_test
 
-- 
2.1.4
