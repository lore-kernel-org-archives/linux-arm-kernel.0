From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:53:01 +0900
Subject: [PATCH 09/11] ARM: EXYNOS: local definitions for cpuidle.c into
 mach-exynos dir
Message-ID: <116701cefb1e$89821f40$9c865dc0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This moves definitions for cpuidle into mach-exynos/cpuidle.c,
because we don't need to keep them in the <mach/regs-clock.h>.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c                 |   23
++++++++++++++++++++++-
 arch/arm/mach-exynos/include/mach/regs-clock.h |   21 ---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 6ba13ea..da65b03 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -22,11 +22,13 @@
 #include <asm/suspend.h>
 #include <asm/unified.h>
 #include <asm/cpuidle.h>
-#include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include <mach/pm-core.h>
+#include <mach/map.h>
+
 #include "common.h"
 #include "regs-pmu.h"
 
@@ -39,6 +41,25 @@
 
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
+#define EXYNOS5_PWR_CTRL1			(S5P_VA_CMU + 0x01020)
+#define EXYNOS5_PWR_CTRL2			(S5P_VA_CMU + 0x01024)
+
+#define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
+#define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
+#define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
+#define PWR_CTRL1_DIV1_DOWN_EN			(1 << 8)
+#define PWR_CTRL1_USE_CORE1_WFE			(1 << 5)
+#define PWR_CTRL1_USE_CORE0_WFE			(1 << 4)
+#define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
+#define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
+
+#define PWR_CTRL2_DIV2_UP_EN			(1 << 25)
+#define PWR_CTRL2_DIV1_UP_EN			(1 << 24)
+#define PWR_CTRL2_DUR_STANDBY2_VAL		(1 << 16)
+#define PWR_CTRL2_DUR_STANDBY1_VAL		(1 << 8)
+#define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
+#define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
+
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h
b/arch/arm/mach-exynos/include/mach/regs-clock.h
index 22afe63..cc121a5 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -16,25 +16,4 @@
 #include <plat/cpu.h>
 #include <mach/map.h>
 
-#define EXYNOS_CLKREG(x)			(S5P_VA_CMU + (x))
-
-#define EXYNOS5_PWR_CTRL1			EXYNOS_CLKREG(0x01020)
-#define EXYNOS5_PWR_CTRL2			EXYNOS_CLKREG(0x01024)
-
-#define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
-#define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
-#define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
-#define PWR_CTRL1_DIV1_DOWN_EN			(1 << 8)
-#define PWR_CTRL1_USE_CORE1_WFE			(1 << 5)
-#define PWR_CTRL1_USE_CORE0_WFE			(1 << 4)
-#define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
-#define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
-
-#define PWR_CTRL2_DIV2_UP_EN			(1 << 25)
-#define PWR_CTRL2_DIV1_UP_EN			(1 << 24)
-#define PWR_CTRL2_DUR_STANDBY2_VAL		(1 << 16)
-#define PWR_CTRL2_DUR_STANDBY1_VAL		(1 << 8)
-#define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
-#define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
-
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
-- 
1.7.10.4
