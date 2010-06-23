From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 07:31:57 +0900
Subject: [PATCH 3/3] ARM: S5P: Add Support common arch_reset() for S5P SoCs
In-Reply-To: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
References: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277332317-30192-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds support common arch_reset() for
S5P6440, S5P6442, S5PC100 and S5PV210/S5PC110.
Now perform reset using Watchdog reset, SWRESET
support with s5p_reset_hook() will be added later.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/system.h |    7 ++-----
 arch/arm/mach-s5p6442/include/mach/system.h |    7 ++-----
 arch/arm/mach-s5pc100/include/mach/system.h |    9 +--------
 arch/arm/mach-s5pv210/include/mach/system.h |    7 ++-----
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-s5p6440/include/mach/system.h b/arch/arm/mach-s5p6440/include/mach/system.h
index d2dd817..a359ee3 100644
--- a/arch/arm/mach-s5p6440/include/mach/system.h
+++ b/arch/arm/mach-s5p6440/include/mach/system.h
@@ -13,12 +13,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-static void arch_idle(void)
-{
-	/* nothing here yet */
-}
+#include <plat/system-reset.h>
 
-static void arch_reset(char mode, const char *cmd)
+static void arch_idle(void)
 {
 	/* nothing here yet */
 }
diff --git a/arch/arm/mach-s5p6442/include/mach/system.h b/arch/arm/mach-s5p6442/include/mach/system.h
index 8bcd8ed..c30c1cc 100644
--- a/arch/arm/mach-s5p6442/include/mach/system.h
+++ b/arch/arm/mach-s5p6442/include/mach/system.h
@@ -13,12 +13,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-static void arch_idle(void)
-{
-	/* nothing here yet */
-}
+#include <plat/system-reset.h>
 
-static void arch_reset(char mode, const char *cmd)
+static void arch_idle(void)
 {
 	/* nothing here yet */
 }
diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
index 681f626..a9ea57c 100644
--- a/arch/arm/mach-s5pc100/include/mach/system.h
+++ b/arch/arm/mach-s5pc100/include/mach/system.h
@@ -11,18 +11,11 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <linux/io.h>
-#include <mach/map.h>
-#include <mach/regs-clock.h>
+#include <plat/system-reset.h>
 
 static void arch_idle(void)
 {
 	/* nothing here yet */
 }
 
-static void arch_reset(char mode, const char *cmd)
-{
-	__raw_writel(S5PC100_SWRESET_RESETVAL, S5PC100_SWRESET);
-	return;
-}
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
index 1ca04d5..af8a200 100644
--- a/arch/arm/mach-s5pv210/include/mach/system.h
+++ b/arch/arm/mach-s5pv210/include/mach/system.h
@@ -13,12 +13,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-static void arch_idle(void)
-{
-	/* nothing here yet */
-}
+#include <plat/system-reset.h>
 
-static void arch_reset(char mode, const char *cmd)
+static void arch_idle(void)
 {
 	/* nothing here yet */
 }
-- 
1.6.2.5
