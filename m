From: tyler.baker@linaro.org (tyler.baker at linaro.org)
Date: Tue, 12 May 2015 14:59:07 -0700
Subject: [PATCH 2/2] selftests/breakpoints: only set TEST_PROGS when built
In-Reply-To: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
References: <1431467947-29847-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1431467947-29847-3-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler.baker@linaro.org>

Set TEST_PROGS only when a build has occurred.

Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
---
 tools/testing/selftests/breakpoints/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
index 1822356..54cc3e7 100644
--- a/tools/testing/selftests/breakpoints/Makefile
+++ b/tools/testing/selftests/breakpoints/Makefile
@@ -12,12 +12,11 @@ endif
 all:
 ifeq ($(ARCH),x86)
 	gcc breakpoint_test.c -o breakpoint_test
+	TEST_PROGS := breakpoint_test
 else
 	echo "Not an x86 target, can't build breakpoints selftests"
 endif
 
-TEST_PROGS := breakpoint_test
-
 include ../lib.mk
 
 clean:
-- 
2.1.4
