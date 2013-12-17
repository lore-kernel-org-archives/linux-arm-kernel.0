From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:51:51 +0900
Subject: [PATCH 02/11] ARM: EXYNOS: remove inclusion <mach/regs-pmu.h> into
 another headers
Message-ID: <116001cefb1e$600fec50$202fc4f0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This is needed to remove dependency of headers.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/include/mach/pm-core.h    |    5 ++++-
 arch/arm/mach-exynos/include/mach/regs-clock.h |    2 --
 arch/arm/mach-exynos/include/mach/regs-pmu.h   |    2 --
 arch/arm/mach-exynos/pmu.c                     |    1 +
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h
b/arch/arm/mach-exynos/include/mach/pm-core.h
index 2b00833..dc0697c 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -19,7 +19,10 @@
 #define __ASM_ARCH_PM_CORE_H __FILE__
 
 #include <linux/of.h>
-#include <mach/regs-pmu.h>
+#include <mach/map.h>
+
+#define S5P_EINT_WAKEUP_MASK			(S5P_VA_PMU + 0x0604)
+#define S5P_WAKEUP_MASK				(S5P_VA_PMU +
0x0608)
 
 #ifdef CONFIG_PINCTRL_EXYNOS
 extern u32 exynos_get_eint_wake_mask(void);
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h
b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..93dcf7f 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -365,8 +365,6 @@
 
 /* Compatibility defines and inclusion */
 
-#include <mach/regs-pmu.h>
-
 #define S5P_EPLL_CON				EXYNOS4_EPLL_CON0
 
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 2c15a8f..7c029ce 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -31,8 +31,6 @@
 #define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
 
 #define S5P_WAKEUP_STAT				S5P_PMUREG(0x0600)
-#define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
-#define S5P_WAKEUP_MASK				S5P_PMUREG(0x0608)
 
 #define S5P_INFORM0				S5P_PMUREG(0x0800)
 #define S5P_INFORM1				S5P_PMUREG(0x0804)
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 97d6885..9062b58 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -14,6 +14,7 @@
 #include <linux/bug.h>
 
 #include <mach/regs-clock.h>
+#include <mach/regs-pmu.h>
 
 #include "common.h"
 
-- 
1.7.10.4
