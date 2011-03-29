From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 29 Mar 2011 15:49:02 +0900
Subject: [PATCH] Exynos4: Fix cpuinit section mismatches
Message-ID: <20110329064902.GA32621@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Fix cpuinit section mismatch(es).

WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/headsmp.S b/arch/arm/mach-exynos4/headsmp.S
index 6c6cfc5..3cdeb36 100644
--- a/arch/arm/mach-exynos4/headsmp.S
+++ b/arch/arm/mach-exynos4/headsmp.S
@@ -13,7 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
+	__CPUINIT
 
 /*
  * exynos4 specific entry point for secondary CPUs.  This provides
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 6d35878..f77e66a 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -35,7 +35,7 @@ extern void exynos4_secondary_startup(void);
  * boot "holding pen"
  */
 
-volatile int __cpuinitdata pen_release = -1;
+volatile int pen_release = -1;
 
 /*
  * Write pen_release in a way that is guaranteed to be visible to all
