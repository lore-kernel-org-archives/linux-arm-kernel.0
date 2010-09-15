From: jc.lee@samsung.com (Jaecheol Lee)
Date: Wed, 15 Sep 2010 16:52:40 +0900
Subject: [PATCH 3/5] ARM: S5PV210: Add Register definition for CMU
In-Reply-To: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
References: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
Message-ID: <1284537162-3129-4-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some CMU(Clock Management Unit) registers for
supporting CPUFREQ and some drivers.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |   31 ++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 499aef7..336b1cf 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -67,11 +67,28 @@
 #define S5P_CLKGATE_BUS1	S5P_CLKREG(0x488)
 #define S5P_CLK_OUT		S5P_CLKREG(0x500)
 
+/* DIV/MUX STATUS */
+#define S5P_CLKDIV_STAT0	S5P_CLKREG(0x1000)
+#define S5P_CLKDIV_STAT1	S5P_CLKREG(0x1004)
+#define S5P_CLKMUX_STAT0	S5P_CLKREG(0x1100)
+#define S5P_CLKMUX_STAT1	S5P_CLKREG(0x1104)
+
 /* CLKSRC0 */
-#define S5P_CLKSRC0_MUX200_MASK		(0x1<<16)
+#define S5P_CLKSRC0_MUX200_SHIFT	(16)
+#define S5P_CLKSRC0_MUX200_MASK		(0x1 << S5P_CLKSRC0_MUX200_SHIFT)
 #define S5P_CLKSRC0_MUX166_MASK		(0x1<<20)
 #define S5P_CLKSRC0_MUX133_MASK		(0x1<<24)
 
+/* CLKSRC2 */
+#define S5P_CLKSRC2_G3D_SHIFT           (0)
+#define S5P_CLKSRC2_G3D_MASK            (0x3 << S5P_CLKSRC2_G3D_SHIFT)
+#define S5P_CLKSRC2_MFC_SHIFT           (4)
+#define S5P_CLKSRC2_MFC_MASK            (0x3 << S5P_CLKSRC2_MFC_SHIFT)
+
+/* CLKSRC6*/
+#define S5P_CLKSRC6_ONEDRAM_SHIFT       (24)
+#define S5P_CLKSRC6_ONEDRAM_MASK        (0x3 << S5P_CLKSRC6_ONEDRAM_SHIFT)
+
 /* CLKDIV0 */
 #define S5P_CLKDIV0_APLL_SHIFT		(0)
 #define S5P_CLKDIV0_APLL_MASK		(0x7 << S5P_CLKDIV0_APLL_SHIFT)
@@ -90,8 +107,20 @@
 #define S5P_CLKDIV0_PCLK66_SHIFT	(28)
 #define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
 
+/* CLKDIV2 */
+#define S5P_CLKDIV2_G3D_SHIFT           (0)
+#define S5P_CLKDIV2_G3D_MASK            (0xF << S5P_CLKDIV2_G3D_SHIFT)
+#define S5P_CLKDIV2_MFC_SHIFT           (4)
+#define S5P_CLKDIV2_MFC_MASK            (0xF << S5P_CLKDIV2_MFC_SHIFT)
+
+/* CLKDIV6 */
+#define S5P_CLKDIV6_ONEDRAM_SHIFT       (28)
+#define S5P_CLKDIV6_ONEDRAM_MASK        (0xF << S5P_CLKDIV6_ONEDRAM_SHIFT)
+
 #define S5P_SWRESET		S5P_CLKREG(0x2000)
 
+#define S5P_ARM_MCS_CON		S5P_CLKREG(0x6100)
+
 /* Registers related to power management */
 #define S5P_PWR_CFG		S5P_CLKREG(0xC000)
 #define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
-- 
1.6.2.5
