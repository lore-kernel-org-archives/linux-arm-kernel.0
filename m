From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:00:10 +0200
Subject: [PATCH] ARM: davinci: da850: add clocks for mcbsp0 and 1
Message-ID: <1462802410-25164-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock definitions "davinci-mcbsp.0" and "davinci-mcbsp.1" in order
to make McBSP driver work on the DA850 platform.

The McBSP 0 and 1 interfaces were not defined for the DA850 platform.
Neither were the related clocks. In order to make the use of McBSP via
devicetree the clocks need to be defined.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/mach-davinci/da850.c | 16 ++++++++++++++++
 arch/arm/mach-davinci/psc.h   |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 239886299968..0d046accb35b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -326,6 +326,20 @@ static struct clk mcasp_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk mcbsp0_clk = {
+	.name		= "mcbsp0",
+	.parent		= &async3_clk,
+	.lpsc		= DA850_LPSC1_McBSP0,
+	.gpsc		= 1,
+};
+
+static struct clk mcbsp1_clk = {
+	.name		= "mcbsp1",
+	.parent		= &async3_clk,
+	.lpsc		= DA850_LPSC1_McBSP1,
+	.gpsc		= 1,
+};
+
 static struct clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
@@ -482,6 +496,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
 	CLK("davinci_mdio.0",	"fck",		&emac_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
+	CLK("davinci-mcbsp.0",	NULL,		&mcbsp0_clk),
+	CLK("davinci-mcbsp.1",	NULL,		&mcbsp1_clk),
 	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index 99d47cfa301f..8af9f09fc10c 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -171,6 +171,8 @@
 #define DA8XX_LPSC1_I2C			11
 #define DA8XX_LPSC1_UART1		12
 #define DA8XX_LPSC1_UART2		13
+#define DA850_LPSC1_McBSP0		14
+#define DA850_LPSC1_McBSP1		15
 #define DA8XX_LPSC1_LCDC		16
 #define DA8XX_LPSC1_PWM			17
 #define DA850_LPSC1_MMC_SD1		18
-- 
1.9.1
