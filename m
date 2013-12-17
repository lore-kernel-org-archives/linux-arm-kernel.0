From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:52:08 +0900
Subject: [PATCH 03/11] ARM: EXYNOS: local regs-pmu.h header file
Message-ID: <116101cefb1e$69ddfe70$3d99fb50$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This moves regs-pmu.h file into mach-exynos directory.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c                      |    3 ++-
 arch/arm/mach-exynos/cpuidle.c                     |    2 +-
 arch/arm/mach-exynos/hotplug.c                     |    2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    2 +-
 arch/arm/mach-exynos/pm_domains.c                  |    3 ++-
 arch/arm/mach-exynos/pmu.c                         |    2 +-
 arch/arm/mach-exynos/{include/mach => }/regs-pmu.h |    0
 9 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/arm/mach-exynos/{include/mach => }/regs-pmu.h (100%)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 61d2906..1fc0424 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -38,13 +38,14 @@
 #include <asm/cacheflush.h>
 
 #include <mach/regs-irq.h>
-#include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
 
 #include "common.h"
+#include "regs-pmu.h"
+
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
 
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index ddbfe87..6ba13ea 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -23,12 +23,12 @@
 #include <asm/unified.h>
 #include <asm/cpuidle.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ?
\
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index af90cfa..5eead53 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -19,10 +19,10 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-#include <mach/regs-pmu.h>
 #include <plat/cpu.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 static inline void cpu_enter_lowpower_a9(void)
 {
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 1fe075a..65a4646 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,10 +14,10 @@
 #include <linux/io.h>
 
 #include <asm/mach/arch.h>
-#include <mach/regs-pmu.h>
 #include <plat/mfc.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 static void __init exynos5_dt_machine_init(void)
 {
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 58b43e6..b5b34f8 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -28,11 +28,11 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 extern void exynos4_secondary_startup(void);
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c679db5..717c6a6 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -31,10 +31,10 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-pmu.h>
 #include <mach/pm-core.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001,
},
diff --git a/arch/arm/mach-exynos/pm_domains.c
b/arch/arm/mach-exynos/pm_domains.c
index 1703593..ff50836 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -22,9 +22,10 @@
 #include <linux/of_platform.h>
 #include <linux/sched.h>
 
-#include <mach/regs-pmu.h>
 #include <plat/devs.h>
 
+#include "regs-pmu.h"
+
 /*
  * Exynos specific wrapper around the generic power domain
  */
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 9062b58..0116d5b 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -14,9 +14,9 @@
 #include <linux/bug.h>
 
 #include <mach/regs-clock.h>
-#include <mach/regs-pmu.h>
 
 #include "common.h"
+#include "regs-pmu.h"
 
 static struct exynos_pmu_conf *exynos_pmu_config;
 
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
b/arch/arm/mach-exynos/regs-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos/include/mach/regs-pmu.h
rename to arch/arm/mach-exynos/regs-pmu.h
-- 
1.7.10.4
