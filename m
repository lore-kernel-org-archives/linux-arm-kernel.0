From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 16 Jul 2010 17:01:15 +0900
Subject: [PATCH v2 3/5] ARM: S5PV210: macros for clock registers at
	regs-clock.h
In-Reply-To: <1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279267277-6804-4-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, most of CLK_DIV/SRC register accessing mask and shift
values were used at arch/arm/mach-s5pv210/clock.c only; thus we
had not been using macros for these. However, as CPUFREQ uses
those shift and mask values as well, we'd better define them at a single
location, whose proper location would be regs-clock.h.

Note that only the information about registers used by CPUFREQ are
defined. However, we may need to define other registers later if we add
other parts.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |   45 +++++++++++++++++++++--
 1 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 2a25ab4..a117ecc 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -66,11 +66,30 @@
 #define S5P_CLKGATE_BUS0	S5P_CLKREG(0x484)
 #define S5P_CLKGATE_BUS1	S5P_CLKREG(0x488)
 #define S5P_CLK_OUT		S5P_CLKREG(0x500)
+#define S5P_CLK_DIV_STAT0   S5P_CLKREG(0x1000)
+#define S5P_CLK_DIV_STAT1   S5P_CLKREG(0x1004)
+#define S5P_CLK_MUX_STAT0   S5P_CLKREG(0x1100)
+#define S5P_CLK_MUX_STAT1   S5P_CLKREG(0x1104)
+
+#define S5P_ARM_MCS_CON		S5P_CLKREG(0x6100)
 
 /* CLKSRC0 */
-#define S5P_CLKSRC0_MUX200_MASK		(0x1<<16)
-#define S5P_CLKSRC0_MUX166_MASK		(0x1<<20)
-#define S5P_CLKSRC0_MUX133_MASK		(0x1<<24)
+#define S5P_CLKSRC0_APLL_MASK		(0x1 << 0)
+#define S5P_CLKSRC0_APLL_SHIFT		(0)
+#define S5P_CLKSRC0_MPLL_MASK		(0x1 << 4)
+#define S5P_CLKSRC0_MPLL_SHIFT		(4)
+#define S5P_CLKSRC0_EPLL_MASK		(0x1 << 8)
+#define S5P_CLKSRC0_EPLL_SHIFT		(8)
+#define S5P_CLKSRC0_VPLL_MASK		(0x1 << 12)
+#define S5P_CLKSRC0_VPLL_SHIFT		(12)
+#define S5P_CLKSRC0_MUX200_MASK		(0x1 << 16)
+#define S5P_CLKSRC0_MUX200_SHIFT	(16)
+#define S5P_CLKSRC0_MUX166_MASK		(0x1 << 20)
+#define S5P_CLKSRC0_MUX166_SHIFT	(20)
+#define S5P_CLKSRC0_MUX133_MASK		(0x1 << 24)
+#define S5P_CLKSRC0_MUX133_SHIFT	(24)
+#define S5P_CLKSRC0_ONENAND_MASK	(0x1 << 28)
+#define S5P_CLKSRC0_ONENAND_SHIFT	(28)
 
 /* CLKDIV0 */
 #define S5P_CLKDIV0_APLL_SHIFT		(0)
@@ -90,6 +109,26 @@
 #define S5P_CLKDIV0_PCLK66_SHIFT	(28)
 #define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
 
+/* CLKSRC2 */
+#define S5P_CLKSRC2_G3D_MASK		(0x3 << 0)
+#define S5P_CLKSRC2_G3D_SHIFT		(0)
+#define S5P_CLKSRC2_MFC_MASK		(0x3 << 4)
+#define S5P_CLKSRC2_MFC_SHIFT		(4)
+#define S5P_CLKSRC2_G2D_MASK		(0x3 << 8)
+#define S5P_CLKSRC2_G2D_SHIFT		(8)
+
+/* CLKDIV2 */
+#define S5P_CLKDIV2_G3D_MASK		(0xF << 0)
+#define S5P_CLKDIV2_G3D_SHIFT		(0)
+#define S5P_CLKDIV2_MFC_MASK		(0xF << 4)
+#define S5P_CLKDIV2_MFC_SHIFT		(4)
+#define S5P_CLKDIV2_G2D_MASK		(0xF << 8)
+#define S5P_CLKDIV2_G2D_SHIFT		(8)
+
+/* CLKDIV6 */
+#define S5P_CLKDIV6_ONEDRAM_MASK	(0xf<<28)
+#define S5P_CLKDIV6_ONEDRAM_SHIFT	(28)
+
 /* Registers related to power management */
 #define S5P_PWR_CFG		S5P_CLKREG(0xC000)
 #define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
-- 
1.6.3.3
