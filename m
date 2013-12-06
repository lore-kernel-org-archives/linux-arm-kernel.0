From: arun.kk@samsung.com (Arun Kumar K)
Date: Fri,  6 Dec 2013 15:18:02 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: Add exynos5 CPU clock divider offsets
In-Reply-To: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
Message-ID: <1386323284-15646-2-git-send-email-arun.kk@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the CPU clock divider shifts and masks for Exynos5 SoC.
These defines will be used in cpufreq driver.

Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-clock.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..d0186d3 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -347,6 +347,30 @@
 
 #define EXYNOS5_EPLLCON0_LOCKED_SHIFT		(29)
 
+/* CLK_DIV_CPU0 */
+#define EXYNOS5_CLKDIV_CPU0_CORE_SHIFT		0
+#define EXYNOS5_CLKDIV_CPU0_CORE_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_CORE_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_CPUD_SHIFT		4
+#define EXYNOS5_CLKDIV_CPU0_CPUD_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_CPUD_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_ACP_SHIFT		8
+#define EXYNOS5_CLKDIV_CPU0_ACP_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_ACP_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_ATB_SHIFT		16
+#define EXYNOS5_CLKDIV_CPU0_ATB_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_ATB_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_PCLKDBG_SHIFT	20
+#define EXYNOS5_CLKDIV_CPU0_PCLKDBG_MASK	(0x7 << EXYNOS5_CLKDIV_CPU0_PCLKDBG_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_APLL_SHIFT		24
+#define EXYNOS5_CLKDIV_CPU0_APLL_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_APLL_SHIFT)
+#define EXYNOS5_CLKDIV_CPU0_CORE2_SHIFT		28
+#define EXYNOS5_CLKDIV_CPU0_CORE2_MASK		(0x7 << EXYNOS5_CLKDIV_CPU0_CORE2_SHIFT)
+
+/* CLK_DIV_CPU1 */
+#define EXYNOS5_CLKDIV_CPU1_COPY_SHIFT		0
+#define EXYNOS5_CLKDIV_CPU1_COPY_MASK		(0x7 << EXYNOS5_CLKDIV_CPU1_COPY_SHIFT)
+#define EXYNOS5_CLKDIV_CPU1_HPM_SHIFT		4
+#define EXYNOS5_CLKDIV_CPU1_HPM_MASK		(0x7 << EXYNOS5_CLKDIV_CPU1_HPM_SHIFT)
+#define EXYNOS5_CLKSRC_CPU_MUXCORE_SHIFT	16
+#define EXYNOS5_CLKMUX_STATCPU_MUXCORE_MASK	(0x7 << EXYNOS5_CLKSRC_CPU_MUXCORE_SHIFT)
+
 #define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
 #define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
 #define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
-- 
1.7.9.5
