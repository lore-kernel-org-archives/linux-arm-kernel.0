From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:52:52 +0900
Subject: [PATCH 08/11] cpufreq: exynos: move definitions for exynos-cpufreq
 into drivers/cpufreq/
Message-ID: <116601cefb1e$84396e30$8cac4a90$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This moves regarding exynos-cpufreq definitions into drivers/cpufreq/
exynos-cpufreq.h because they are used only for the cpufreq driver.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-clock.h |   21 ---------------------
 drivers/cpufreq/exynos-cpufreq.h               |   22
++++++++++++++++++++++
 drivers/cpufreq/exynos4210-cpufreq.c           |    2 --
 drivers/cpufreq/exynos4x12-cpufreq.c           |    2 --
 drivers/cpufreq/exynos5250-cpufreq.c           |    1 -
 5 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h
b/arch/arm/mach-exynos/include/mach/regs-clock.h
index 5acc06e..22afe63 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -18,27 +18,6 @@
 
 #define EXYNOS_CLKREG(x)			(S5P_VA_CMU + (x))
 
-#define EXYNOS4_CLKSRC_CPU			EXYNOS_CLKREG(0x14200)
-#define EXYNOS4_CLKMUX_STATCPU			EXYNOS_CLKREG(0x14400)
-
-#define EXYNOS4_CLKDIV_CPU			EXYNOS_CLKREG(0x14500)
-#define EXYNOS4_CLKDIV_CPU1			EXYNOS_CLKREG(0x14504)
-#define EXYNOS4_CLKDIV_STATCPU			EXYNOS_CLKREG(0x14600)
-#define EXYNOS4_CLKDIV_STATCPU1
EXYNOS_CLKREG(0x14604)
-
-#define EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT	(16)
-#define EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 <<
EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)
-
-/* For EXYNOS5250 */
-
-#define EXYNOS5_APLL_LOCK			EXYNOS_CLKREG(0x00000)
-#define EXYNOS5_APLL_CON0			EXYNOS_CLKREG(0x00100)
-#define EXYNOS5_CLKMUX_STATCPU			EXYNOS_CLKREG(0x00400)
-#define EXYNOS5_CLKDIV_CPU0			EXYNOS_CLKREG(0x00500)
-#define EXYNOS5_CLKDIV_CPU1			EXYNOS_CLKREG(0x00504)
-#define EXYNOS5_CLKDIV_STATCPU0
EXYNOS_CLKREG(0x00600)
-#define EXYNOS5_CLKDIV_STATCPU1
EXYNOS_CLKREG(0x00604)
-
 #define EXYNOS5_PWR_CTRL1			EXYNOS_CLKREG(0x01020)
 #define EXYNOS5_PWR_CTRL2			EXYNOS_CLKREG(0x01024)
 
diff --git a/drivers/cpufreq/exynos-cpufreq.h
b/drivers/cpufreq/exynos-cpufreq.h
index 7f25cee..3ddade8 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -67,3 +67,25 @@ static inline int exynos5250_cpufreq_init(struct
exynos_dvfs_info *info)
 	return -EOPNOTSUPP;
 }
 #endif
+
+#include <plat/cpu.h>
+#include <mach/map.h>
+
+#define EXYNOS4_CLKSRC_CPU			(S5P_VA_CMU + 0x14200)
+#define EXYNOS4_CLKMUX_STATCPU			(S5P_VA_CMU + 0x14400)
+
+#define EXYNOS4_CLKDIV_CPU			(S5P_VA_CMU + 0x14500)
+#define EXYNOS4_CLKDIV_CPU1			(S5P_VA_CMU + 0x14504)
+#define EXYNOS4_CLKDIV_STATCPU			(S5P_VA_CMU + 0x14600)
+#define EXYNOS4_CLKDIV_STATCPU1			(S5P_VA_CMU +
0x14604)
+
+#define EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT	(16)
+#define EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 <<
EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)
+
+#define EXYNOS5_APLL_LOCK			(S5P_VA_CMU + 0x00000)
+#define EXYNOS5_APLL_CON0			(S5P_VA_CMU + 0x00100)
+#define EXYNOS5_CLKMUX_STATCPU			(S5P_VA_CMU + 0x00400)
+#define EXYNOS5_CLKDIV_CPU0			(S5P_VA_CMU + 0x00500)
+#define EXYNOS5_CLKDIV_CPU1			(S5P_VA_CMU + 0x00504)
+#define EXYNOS5_CLKDIV_STATCPU0			(S5P_VA_CMU +
0x00600)
+#define EXYNOS5_CLKDIV_STATCPU1			(S5P_VA_CMU +
0x00604)
diff --git a/drivers/cpufreq/exynos4210-cpufreq.c
b/drivers/cpufreq/exynos4210-cpufreq.c
index dfd1643..40d84c4 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
 
-#include <mach/regs-clock.h>
-
 #include "exynos-cpufreq.h"
 
 static struct clk *cpu_clk;
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c
b/drivers/cpufreq/exynos4x12-cpufreq.c
index efad5e6..869e482 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
 
-#include <mach/regs-clock.h>
-
 #include "exynos-cpufreq.h"
 
 static struct clk *cpu_clk;
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c
b/drivers/cpufreq/exynos5250-cpufreq.c
index 8feda86..5ee2ce1 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -18,7 +18,6 @@
 #include <linux/cpufreq.h>
 
 #include <mach/map.h>
-#include <mach/regs-clock.h>
 
 #include "exynos-cpufreq.h"
 
-- 
1.7.10.4
