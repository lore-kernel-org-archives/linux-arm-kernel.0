From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:17 -0700
Subject: [PATCH 3/6] selftest/mount: enable cross compilation
In-Reply-To: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1427930420-4762-4-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the CC variable instead of hard coding gcc. Also clean up the compiler
options by creating a CFLAGS variable.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/mount/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
index a5b367f..95580a9 100644
--- a/tools/testing/selftests/mount/Makefile
+++ b/tools/testing/selftests/mount/Makefile
@@ -1,9 +1,10 @@
 # Makefile for mount selftests.
-
+CFLAGS = -Wall \
+         -O2
 all: unprivileged-remount-test
 
 unprivileged-remount-test: unprivileged-remount-test.c
-	gcc -Wall -O2 unprivileged-remount-test.c -o unprivileged-remount-test
+	$(CC) $(CFLAGS) unprivileged-remount-test.c -o unprivileged-remount-test
 
 include ../lib.mk
 
-- 
2.1.4
