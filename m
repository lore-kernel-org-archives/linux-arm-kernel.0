From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:57 +0100
Subject: [PATCH 20/21] clk: samsung: exynos4: Add missing registers to suspend
 save list
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-21-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing clock control registers to the list of registers
that should be saved across system suspend.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 571b7e3..279c435 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -22,7 +22,11 @@
 
 /* Exynos4 clock controller register offsets */
 #define SRC_LEFTBUS		0x4200
+#define DIV_LEFTBUS		0x4500
+#define GATE_IP_LEFTBUS		0x4800
 #define E4X12_GATE_IP_IMAGE	0x4930
+#define SRC_RIGHTBUS		0x8200
+#define DIV_RIGHTBUS		0x8500
 #define GATE_IP_RIGHTBUS	0x8800
 #define E4X12_GATE_IP_PERIR	0x8960
 #define EPLL_LOCK		0xc010
@@ -48,6 +52,7 @@
 #define SRC_PERIL0		0xc250
 #define SRC_PERIL1		0xc254
 #define E4X12_SRC_CAM1		0xc258
+#define SRC_MASK_TOP		0xc310
 #define SRC_MASK_CAM		0xc320
 #define SRC_MASK_TV		0xc324
 #define SRC_MASK_LCD0		0xc334
@@ -92,12 +97,20 @@
 #define GATE_IP_GPS		0xc94c
 #define GATE_IP_PERIL		0xc950
 #define E4210_GATE_IP_PERIR	0xc960
+#define GATE_BLOCK		0xc970
 #define E4X12_MPLL_CON0		0x10108
 #define SRC_DMC			0x10200
+#define SRC_MASK_DMC		0x10300
+#define DIV_DMC0		0x10500
+#define DIV_DMC1		0x10504
+#define GATE_IP_DMC		0x10900
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
 #define DIV_CPU0		0x14500
+#define DIV_CPU1		0x14504
+#define GATE_SCLK_CPU		0x14800
+#define GATE_IP_CPU		0x14900
 #define E4X12_DIV_ISP0		0x18300
 #define E4X12_DIV_ISP1		0x18304
 #define E4X12_GATE_ISP0		0x18800
@@ -172,7 +185,17 @@ enum exynos4_clks {
  */
 static __initdata unsigned long exynos4_clk_regs[] = {
 	SRC_LEFTBUS,
+	DIV_LEFTBUS,
+	GATE_IP_LEFTBUS,
+	SRC_RIGHTBUS,
+	DIV_RIGHTBUS,
 	GATE_IP_RIGHTBUS,
+	EPLL_CON0,
+	EPLL_CON1,
+	EPLL_CON2,
+	VPLL_CON0,
+	VPLL_CON1,
+	VPLL_CON2,
 	SRC_TOP0,
 	SRC_TOP1,
 	SRC_CAM,
@@ -184,6 +207,7 @@ static __initdata unsigned long exynos4_clk_regs[] = {
 	SRC_FSYS,
 	SRC_PERIL0,
 	SRC_PERIL1,
+	SRC_MASK_TOP,
 	SRC_MASK_CAM,
 	SRC_MASK_TV,
 	SRC_MASK_LCD0,
@@ -218,9 +242,18 @@ static __initdata unsigned long exynos4_clk_regs[] = {
 	GATE_IP_FSYS,
 	GATE_IP_GPS,
 	GATE_IP_PERIL,
+	GATE_BLOCK,
+	SRC_MASK_DMC,
+	SRC_DMC,
+	DIV_DMC0,
+	DIV_DMC1,
+	GATE_IP_DMC,
 	APLL_CON0,
 	SRC_CPU,
 	DIV_CPU0,
+	DIV_CPU1,
+	GATE_SCLK_CPU,
+	GATE_IP_CPU,
 };
 
 /* list of all parent clock list */
-- 
1.8.1.5
