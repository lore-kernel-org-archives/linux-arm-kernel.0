From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Mar 2014 18:16:02 +0100
Subject: [PATCH v2 4/6] ARM: SAMSUNG: Fix rebase error in pm-debug.c
In-Reply-To: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
References: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
Message-ID: <1395162964-5916-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Samsung header clean-up series did heavy reorganization of
various Samsung-specific headers, unfortunately causing a conflict with
Samsung PM consolidation series part 2 - multiplatform) and resulting
with a merge error that caused a build failure, due to a missing header
being included.

This patch fixes this by removing incorrect header inclusion.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/plat-samsung/pm-debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index 602998b..88bb4cf 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -20,7 +20,6 @@
 
 #include <plat/cpu.h>
 #include <plat/pm-common.h>
-#include <plat/regs-serial.h>
 
 #ifdef CONFIG_SAMSUNG_ATAGS
 #include <mach/pm-core.h>
-- 
1.9.0
