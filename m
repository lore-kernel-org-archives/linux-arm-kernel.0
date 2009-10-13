From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Oct 2009 10:11:08 +0200
Subject: [PATCH 03/17] ARM: S5PC1XX: clock registers rename
In-Reply-To: <1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PC100 and S5PC110 clock registers differs in many places, rename all
previously defined registers to be S5PC100 specific. Remove all power
management registers. They will be added later to a separate file.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h |  183 ++++++++---------------
 arch/arm/plat-s5pc1xx/s5pc100-clock.c           |   44 +++---
 2 files changed, 84 insertions(+), 143 deletions(-)

diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h b/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
index 75c8390..607d609 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
@@ -13,68 +13,68 @@
 #ifndef __PLAT_REGS_CLOCK_H
 #define __PLAT_REGS_CLOCK_H __FILE__
 
-#define S5PC1XX_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
+#define S5PC100_CLKREG(x)		(S5PC1XX_VA_CLK + (x))
 
-#define S5PC1XX_APLL_LOCK		S5PC1XX_CLKREG(0x00)
-#define S5PC1XX_MPLL_LOCK		S5PC1XX_CLKREG(0x04)
-#define S5PC1XX_EPLL_LOCK		S5PC1XX_CLKREG(0x08)
-#define S5PC100_HPLL_LOCK		S5PC1XX_CLKREG(0x0C)
+/* s5pc100 register for clock */
+#define S5PC100_APLL_LOCK		S5PC100_CLKREG(0x00)
+#define S5PC100_MPLL_LOCK		S5PC100_CLKREG(0x04)
+#define S5PC100_EPLL_LOCK		S5PC100_CLKREG(0x08)
+#define S5PC100_HPLL_LOCK		S5PC100_CLKREG(0x0C)
 
-#define S5PC1XX_APLL_CON		S5PC1XX_CLKREG(0x100)
-#define S5PC1XX_MPLL_CON		S5PC1XX_CLKREG(0x104)
-#define S5PC1XX_EPLL_CON		S5PC1XX_CLKREG(0x108)
-#define S5PC100_HPLL_CON		S5PC1XX_CLKREG(0x10C)
+#define S5PC100_APLL_CON		S5PC100_CLKREG(0x100)
+#define S5PC100_MPLL_CON		S5PC100_CLKREG(0x104)
+#define S5PC100_EPLL_CON		S5PC100_CLKREG(0x108)
+#define S5PC100_HPLL_CON		S5PC100_CLKREG(0x10C)
 
-#define S5PC1XX_CLK_SRC0		S5PC1XX_CLKREG(0x200)
-#define S5PC1XX_CLK_SRC1		S5PC1XX_CLKREG(0x204)
-#define S5PC1XX_CLK_SRC2		S5PC1XX_CLKREG(0x208)
-#define S5PC1XX_CLK_SRC3		S5PC1XX_CLKREG(0x20C)
+#define S5PC100_CLKSRC0			S5PC100_CLKREG(0x200)
+#define S5PC100_CLKSRC1			S5PC100_CLKREG(0x204)
+#define S5PC100_CLKSRC2			S5PC100_CLKREG(0x208)
+#define S5PC100_CLKSRC3			S5PC100_CLKREG(0x20C)
 
-#define S5PC1XX_CLK_DIV0		S5PC1XX_CLKREG(0x300)
-#define S5PC1XX_CLK_DIV1		S5PC1XX_CLKREG(0x304)
-#define S5PC1XX_CLK_DIV2		S5PC1XX_CLKREG(0x308)
-#define S5PC1XX_CLK_DIV3		S5PC1XX_CLKREG(0x30C)
-#define S5PC1XX_CLK_DIV4		S5PC1XX_CLKREG(0x310)
+#define S5PC100_CLKDIV0			S5PC100_CLKREG(0x300)
+#define S5PC100_CLKDIV1			S5PC100_CLKREG(0x304)
+#define S5PC100_CLKDIV2			S5PC100_CLKREG(0x308)
+#define S5PC100_CLKDIV3			S5PC100_CLKREG(0x30C)
+#define S5PC100_CLKDIV4			S5PC100_CLKREG(0x310)
 
-#define S5PC100_CLK_OUT			S5PC1XX_CLKREG(0x400)
+#define S5PC100_CLK_OUT			S5PC100_CLKREG(0x400)
 
-#define S5PC100_CLKGATE_D00		S5PC1XX_CLKREG(0x500)
-#define S5PC100_CLKGATE_D01		S5PC1XX_CLKREG(0x504)
-#define S5PC100_CLKGATE_D02		S5PC1XX_CLKREG(0x508)
+#define S5PC100_CLKGATE_D00		S5PC100_CLKREG(0x500)
+#define S5PC100_CLKGATE_D01		S5PC100_CLKREG(0x504)
+#define S5PC100_CLKGATE_D02		S5PC100_CLKREG(0x508)
 
-#define S5PC100_CLKGATE_D10		S5PC1XX_CLKREG(0x520)
-#define S5PC100_CLKGATE_D11		S5PC1XX_CLKREG(0x524)
-#define S5PC100_CLKGATE_D12		S5PC1XX_CLKREG(0x528)
-#define S5PC100_CLKGATE_D13		S5PC1XX_CLKREG(0x52C)
-#define S5PC100_CLKGATE_D14		S5PC1XX_CLKREG(0x530)
-#define S5PC100_CLKGATE_D15		S5PC1XX_CLKREG(0x534)
+#define S5PC100_CLKGATE_D10		S5PC100_CLKREG(0x520)
+#define S5PC100_CLKGATE_D11		S5PC100_CLKREG(0x524)
+#define S5PC100_CLKGATE_D12		S5PC100_CLKREG(0x528)
+#define S5PC100_CLKGATE_D13		S5PC100_CLKREG(0x52C)
+#define S5PC100_CLKGATE_D14		S5PC100_CLKREG(0x530)
+#define S5PC100_CLKGATE_D15		S5PC100_CLKREG(0x534)
 
-#define S5PC100_CLKGATE_D20		S5PC1XX_CLKREG(0x540)
+#define S5PC100_CLKGATE_D20		S5PC100_CLKREG(0x540)
 
-#define S5PC100_SCLKGATE0		S5PC1XX_CLKREG(0x560)
-#define S5PC100_SCLKGATE1		S5PC1XX_CLKREG(0x564)
+#define S5PC100_SCLKGATE0		S5PC100_CLKREG(0x560)
+#define S5PC100_SCLKGATE1		S5PC100_CLKREG(0x564)
 
-#define S5PC100_OTHERS          S5PC1XX_CLKREG(0x8200)
-
-#define S5PC1XX_EPLL_EN     (1<<31)
-#define S5PC1XX_EPLL_MASK   0xffffffff
-#define S5PC1XX_EPLLVAL(_m, _p, _s)   ((_m) << 16 | ((_p) << 8) | ((_s)))
+/* EPLL_CON */
+#define S5PC100_EPLL_EN			(1<<31)
+#define S5PC100_EPLL_MASK		0xffffffff
+#define S5PC100_EPLLVAL(_m, _p, _s)	((_m) << 16 | ((_p) << 8) | ((_s)))
 
 /* CLKSRC0 */
-#define S5PC1XX_CLKSRC0_APLL_MASK		(0x1<<0)
-#define S5PC1XX_CLKSRC0_APLL_SHIFT		(0)
-#define S5PC1XX_CLKSRC0_MPLL_MASK		(0x1<<4)
-#define S5PC1XX_CLKSRC0_MPLL_SHIFT		(4)
-#define S5PC1XX_CLKSRC0_EPLL_MASK		(0x1<<8)
-#define S5PC1XX_CLKSRC0_EPLL_SHIFT		(8)
+#define S5PC100_CLKSRC0_APLL_MASK		(0x1<<0)
+#define S5PC100_CLKSRC0_APLL_SHIFT		(0)
+#define S5PC100_CLKSRC0_MPLL_MASK		(0x1<<4)
+#define S5PC100_CLKSRC0_MPLL_SHIFT		(4)
+#define S5PC100_CLKSRC0_EPLL_MASK		(0x1<<8)
+#define S5PC100_CLKSRC0_EPLL_SHIFT		(8)
 #define S5PC100_CLKSRC0_HPLL_MASK		(0x1<<12)
 #define S5PC100_CLKSRC0_HPLL_SHIFT		(12)
 #define S5PC100_CLKSRC0_AMMUX_MASK		(0x1<<16)
 #define S5PC100_CLKSRC0_AMMUX_SHIFT		(16)
 #define S5PC100_CLKSRC0_HREF_MASK		(0x1<<20)
 #define S5PC100_CLKSRC0_HREF_SHIFT		(20)
-#define S5PC1XX_CLKSRC0_ONENAND_MASK	(0x1<<24)
-#define S5PC1XX_CLKSRC0_ONENAND_SHIFT	(24)
+#define S5PC100_CLKSRC0_ONENAND_MASK	(0x1<<24)
+#define S5PC100_CLKSRC0_ONENAND_SHIFT	(24)
 
 
 /* CLKSRC1 */
@@ -127,10 +127,9 @@
 #define S5PC100_CLKSRC3_SPDIF_MASK		(0x3<<24)
 #define S5PC100_CLKSRC3_SPDIF_SHIFT		(24)
 
-
 /* CLKDIV0 */
-#define S5PC1XX_CLKDIV0_APLL_MASK		(0x1<<0)
-#define S5PC1XX_CLKDIV0_APLL_SHIFT		(0)
+#define S5PC100_CLKDIV0_APLL_MASK		(0x1<<0)
+#define S5PC100_CLKDIV0_APLL_SHIFT		(0)
 #define S5PC100_CLKDIV0_ARM_MASK		(0x7<<4)
 #define S5PC100_CLKDIV0_ARM_SHIFT		(4)
 #define S5PC100_CLKDIV0_D0_MASK		(0x7<<8)
@@ -141,8 +140,8 @@
 #define S5PC100_CLKDIV0_SECSS_SHIFT		(16)
 
 /* CLKDIV1 */
-#define S5PC100_CLKDIV1_AM_MASK		(0x7<<0)
-#define S5PC100_CLKDIV1_AM_SHIFT		(0)
+#define S5PC100_CLKDIV1_APLL2_MASK		(0x7<<0)
+#define S5PC100_CLKDIV1_APLL2_SHIFT		(0)
 #define S5PC100_CLKDIV1_MPLL_MASK		(0x3<<4)
 #define S5PC100_CLKDIV1_MPLL_SHIFT		(4)
 #define S5PC100_CLKDIV1_MPLL2_MASK		(0x1<<8)
@@ -202,7 +201,6 @@
 #define S5PC100_CLKDIV4_AUDIO2_MASK		(0xf<<20)
 #define S5PC100_CLKDIV4_AUDIO2_SHIFT	(20)
 
-
 /* HCLKD0/PCLKD0 Clock Gate 0 Registers */
 #define S5PC100_CLKGATE_D00_INTC		(1<<0)
 #define S5PC100_CLKGATE_D00_TZIC		(1<<1)
@@ -295,8 +293,8 @@
 #define S5PC100_CLKGATE_D20_I2SD2		(1<<1)
 
 /* Special Clock Gate 0 Registers */
-#define	S5PC1XX_CLKGATE_SCLK0_HPM		(1<<0)
-#define	S5PC1XX_CLKGATE_SCLK0_PWI		(1<<1)
+#define	S5PC100_CLKGATE_SCLK0_HPM		(1<<0)
+#define	S5PC100_CLKGATE_SCLK0_PWI		(1<<1)
 #define	S5PC100_CLKGATE_SCLK0_ONENAND	(1<<2)
 #define	S5PC100_CLKGATE_SCLK0_UART		(1<<3)
 #define	S5PC100_CLKGATE_SCLK0_SPI0		(1<<4)
@@ -329,74 +327,17 @@
 #define	S5PC100_CLKGATE_SCLK1_SPDIF		(1<<11)
 #define	S5PC100_CLKGATE_SCLK1_CAM		(1<<12)
 
-/* register for power management */
-#define S5PC100_PWR_CFG 		S5PC1XX_CLKREG(0x8000)
-#define S5PC100_EINT_WAKEUP_MASK 	S5PC1XX_CLKREG(0x8004)
-#define S5PC100_NORMAL_CFG 		S5PC1XX_CLKREG(0x8010)
-#define S5PC100_STOP_CFG 		S5PC1XX_CLKREG(0x8014)
-#define S5PC100_SLEEP_CFG 		S5PC1XX_CLKREG(0x8018)
-#define S5PC100_STOP_MEM_CFG 	S5PC1XX_CLKREG(0x801C)
-#define S5PC100_OSC_FREQ 		S5PC1XX_CLKREG(0x8100)
-#define S5PC100_OSC_STABLE 		S5PC1XX_CLKREG(0x8104)
-#define S5PC100_PWR_STABLE 		S5PC1XX_CLKREG(0x8108)
-#define S5PC100_MTC_STABLE 		S5PC1XX_CLKREG(0x8110)
-#define S5PC100_CLAMP_STABLE 	S5PC1XX_CLKREG(0x8114)
-#define S5PC100_OTHERS 		S5PC1XX_CLKREG(0x8200)
-#define S5PC100_RST_STAT 		S5PC1XX_CLKREG(0x8300)
-#define S5PC100_WAKEUP_STAT 	S5PC1XX_CLKREG(0x8304)
-#define S5PC100_BLK_PWR_STAT 	S5PC1XX_CLKREG(0x8308)
-#define S5PC100_INFORM0 		S5PC1XX_CLKREG(0x8400)
-#define S5PC100_INFORM1 		S5PC1XX_CLKREG(0x8404)
-#define S5PC100_INFORM2 		S5PC1XX_CLKREG(0x8408)
-#define S5PC100_INFORM3 		S5PC1XX_CLKREG(0x840C)
-#define S5PC100_INFORM4 		S5PC1XX_CLKREG(0x8410)
-#define S5PC100_INFORM5 		S5PC1XX_CLKREG(0x8414)
-#define S5PC100_INFORM6 		S5PC1XX_CLKREG(0x8418)
-#define S5PC100_INFORM7 		S5PC1XX_CLKREG(0x841C)
-#define S5PC100_DCGIDX_MAP0 	S5PC1XX_CLKREG(0x8500)
-#define S5PC100_DCGIDX_MAP1 	S5PC1XX_CLKREG(0x8504)
-#define S5PC100_DCGIDX_MAP2 	S5PC1XX_CLKREG(0x8508)
-#define S5PC100_DCGPERF_MAP0 	S5PC1XX_CLKREG(0x850C)
-#define S5PC100_DCGPERF_MAP1 	S5PC1XX_CLKREG(0x8510)
-#define S5PC100_DVCIDX_MAP 		S5PC1XX_CLKREG(0x8514)
-#define S5PC100_FREQ_CPU 		S5PC1XX_CLKREG(0x8518)
-#define S5PC100_FREQ_DPM 		S5PC1XX_CLKREG(0x851C)
-#define S5PC100_DVSEMCLK_EN 	S5PC1XX_CLKREG(0x8520)
-#define S5PC100_APLL_CON_L8 	S5PC1XX_CLKREG(0x8600)
-#define S5PC100_APLL_CON_L7 	S5PC1XX_CLKREG(0x8604)
-#define S5PC100_APLL_CON_L6 	S5PC1XX_CLKREG(0x8608)
-#define S5PC100_APLL_CON_L5 	S5PC1XX_CLKREG(0x860C)
-#define S5PC100_APLL_CON_L4 	S5PC1XX_CLKREG(0x8610)
-#define S5PC100_APLL_CON_L3 	S5PC1XX_CLKREG(0x8614)
-#define S5PC100_APLL_CON_L2 	S5PC1XX_CLKREG(0x8618)
-#define S5PC100_APLL_CON_L1 	S5PC1XX_CLKREG(0x861C)
-#define S5PC100_IEM_CONTROL 	S5PC1XX_CLKREG(0x8620)
-#define S5PC100_CLKDIV_IEM_L8 	S5PC1XX_CLKREG(0x8700)
-#define S5PC100_CLKDIV_IEM_L7 	S5PC1XX_CLKREG(0x8704)
-#define S5PC100_CLKDIV_IEM_L6 	S5PC1XX_CLKREG(0x8708)
-#define S5PC100_CLKDIV_IEM_L5 	S5PC1XX_CLKREG(0x870C)
-#define S5PC100_CLKDIV_IEM_L4 	S5PC1XX_CLKREG(0x8710)
-#define S5PC100_CLKDIV_IEM_L3 	S5PC1XX_CLKREG(0x8714)
-#define S5PC100_CLKDIV_IEM_L2 	S5PC1XX_CLKREG(0x8718)
-#define S5PC100_CLKDIV_IEM_L1 	S5PC1XX_CLKREG(0x871C)
-#define S5PC100_IEM_HPMCLK_DIV 	S5PC1XX_CLKREG(0x8724)
-
-#define S5PC100_SWRESET		S5PC1XX_CLKREG(0x100000)
-#define S5PC100_OND_SWRESET		S5PC1XX_CLKREG(0x100008)
-#define S5PC100_GEN_CTRL		S5PC1XX_CLKREG(0x100100)
-#define S5PC100_GEN_STATUS		S5PC1XX_CLKREG(0x100104)
-#define S5PC100_MEM_SYS_CFG		S5PC1XX_CLKREG(0x100200)
-#define S5PC100_CAM_MUX_SEL		S5PC1XX_CLKREG(0x100300)
-#define S5PC100_MIXER_OUT_SEL	S5PC1XX_CLKREG(0x100304)
-#define S5PC100_LPMP_MODE_SEL	S5PC1XX_CLKREG(0x100308)
-#define S5PC100_MIPI_PHY_CON0	S5PC1XX_CLKREG(0x100400)
-#define S5PC100_MIPI_PHY_CON1	S5PC1XX_CLKREG(0x100414)
-#define S5PC100_HDMI_PHY_CON0	S5PC1XX_CLKREG(0x100420)
-
-#define S5PC100_CFG_WFI_CLEAN	(~(3<<5))
-#define S5PC100_CFG_WFI_IDLE	(1<<5)
-#define S5PC100_CFG_WFI_STOP	(2<<5)
-#define S5PC100_CFG_WFI_SLEEP	(3<<5)
+#define S5PC100_SWRESET		S5PC100_CLKREG(0x100000)
+#define S5PC100_OND_SWRESET		S5PC100_CLKREG(0x100008)
+#define S5PC100_GEN_CTRL		S5PC100_CLKREG(0x100100)
+#define S5PC100_GEN_STATUS		S5PC100_CLKREG(0x100104)
+#define S5PC100_MEM_SYS_CFG		S5PC100_CLKREG(0x100200)
+#define S5PC100_CAM_MUX_SEL		S5PC100_CLKREG(0x100300)
+#define S5PC100_MIXER_OUT_SEL	S5PC100_CLKREG(0x100304)
+#define S5PC100_LPMP_MODE_SEL	S5PC100_CLKREG(0x100308)
+#define S5PC100_MIPI_PHY_CON0	S5PC100_CLKREG(0x100400)
+#define S5PC100_MIPI_PHY_CON1	S5PC100_CLKREG(0x100414)
+#define S5PC100_HDMI_PHY_CON0	S5PC100_CLKREG(0x100420)
 
 #define S5PC100_OTHER_SYS_INT	24
 #define S5PC100_OTHER_STA_TYPE	23
@@ -411,7 +352,7 @@
 #define S5PC100_SLEEP_CFG_OSC_EN	0
 
 /* OTHERS Resgister */
-#define S5PC100_OTHERS_USB_SIG_MASK 	(1 << 16)
+#define S5PC100_OTHERS_USB_SIG_MASK	(1 << 16)
 #define S5PC100_OTHERS_MIPI_DPHY_EN		(1 << 28)
 
 /* MIPI D-PHY Control Register 0 */
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
index 6b24035..efc868b 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+++ b/arch/arm/plat-s5pc1xx/s5pc100-clock.c
@@ -87,13 +87,13 @@ static int clk_48m_ctrl(struct clk *clk, int enable)
 	/* can't rely on clock lock, this register has other usages */
 	local_irq_save(flags);
 
-	val = __raw_readl(S5PC1XX_CLK_SRC1);
+	val = __raw_readl(S5PC100_CLKSRC1);
 	if (enable)
 		val |= S5PC100_CLKSRC1_CLK48M_MASK;
 	else
 		val &= ~S5PC100_CLKSRC1_CLK48M_MASK;
 
-	__raw_writel(val, S5PC1XX_CLK_SRC1);
+	__raw_writel(val, S5PC100_CLKSRC1);
 	local_irq_restore(flags);
 
 	return 0;
@@ -685,7 +685,7 @@ static struct clk init_clocks[] = {
 		.id		= -1,
 		.parent		= NULL,
 		.enable		= s5pc1xx_sclk0_ctrl,
-		.ctrlbit	= S5PC1XX_CLKGATE_SCLK0_HPM,
+		.ctrlbit	= S5PC100_CLKGATE_SCLK0_HPM,
 	}, {
 		.name		= "sclk_onenand",
 		.id		= -1,
@@ -801,10 +801,10 @@ static struct clksrc_clk clk_mout_apll = {
 		.name		= "mout_apll",
 		.id		= -1,
 	},
-	.shift		= S5PC1XX_CLKSRC0_APLL_SHIFT,
-	.mask		= S5PC1XX_CLKSRC0_APLL_MASK,
+	.shift		= S5PC100_CLKSRC0_APLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_APLL_MASK,
 	.sources	= &clk_src_apll,
-	.reg_source	= S5PC1XX_CLK_SRC0,
+	.reg_source	= S5PC100_CLKSRC0,
 };
 
 static struct clk clk_fout_epll = {
@@ -827,10 +827,10 @@ static struct clksrc_clk clk_mout_epll = {
 		.name		= "mout_epll",
 		.id		= -1,
 	},
-	.shift		= S5PC1XX_CLKSRC0_EPLL_SHIFT,
-	.mask		= S5PC1XX_CLKSRC0_EPLL_MASK,
+	.shift		= S5PC100_CLKSRC0_EPLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_EPLL_MASK,
 	.sources	= &clk_src_epll,
-	.reg_source	= S5PC1XX_CLK_SRC0,
+	.reg_source	= S5PC100_CLKSRC0,
 };
 
 static struct clk *clk_src_mpll_list[] = {
@@ -848,10 +848,10 @@ static struct clksrc_clk clk_mout_mpll = {
 		.name		= "mout_mpll",
 		.id		= -1,
 	},
-	.shift		= S5PC1XX_CLKSRC0_MPLL_SHIFT,
-	.mask		= S5PC1XX_CLKSRC0_MPLL_MASK,
+	.shift		= S5PC100_CLKSRC0_MPLL_SHIFT,
+	.mask		= S5PC100_CLKSRC0_MPLL_MASK,
 	.sources	= &clk_src_mpll,
-	.reg_source	= S5PC1XX_CLK_SRC0,
+	.reg_source	= S5PC100_CLKSRC0,
 };
 
 static unsigned long s5pc1xx_clk_doutmpll_get_rate(struct clk *clk)
@@ -861,7 +861,7 @@ static unsigned long s5pc1xx_clk_doutmpll_get_rate(struct clk *clk)
 
 	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
 
-	clkdiv = __raw_readl(S5PC1XX_CLK_DIV1) & S5PC100_CLKDIV1_MPLL_MASK;
+	clkdiv = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL_MASK;
 	rate /= (clkdiv >> S5PC100_CLKDIV1_MPLL_SHIFT) + 1;
 
 	return rate;
@@ -881,7 +881,7 @@ static unsigned long s5pc1xx_clk_doutmpll2_get_rate(struct clk *clk)
 
 	printk(KERN_DEBUG "%s: parent is %ld\n", __func__, rate);
 
-	clkdiv = __raw_readl(S5PC1XX_CLK_DIV1) & S5PC100_CLKDIV1_MPLL2_MASK;
+	clkdiv = __raw_readl(S5PC100_CLKDIV1) & S5PC100_CLKDIV1_MPLL2_MASK;
 	rate /= (clkdiv >> S5PC100_CLKDIV1_MPLL2_SHIFT) + 1;
 
 	return rate;
@@ -1007,8 +1007,8 @@ static struct clksrc_clk clk_uart_uclk1 = {
 	.mask		= S5PC100_CLKSRC1_UART_MASK,
 	.sources	= &clkset_uart,
 	.divider_shift	= S5PC100_CLKDIV2_UART_SHIFT,
-	.reg_divider	= S5PC1XX_CLK_DIV2,
-	.reg_source	= S5PC1XX_CLK_SRC1,
+	.reg_divider	= S5PC100_CLKDIV2,
+	.reg_source	= S5PC100_CLKSRC1,
 };
 
 /* Clock initialisation code */
@@ -1061,8 +1061,8 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
 
-	clkdiv0 = __raw_readl(S5PC1XX_CLK_DIV0);
-	clkdiv1 = __raw_readl(S5PC1XX_CLK_DIV1);
+	clkdiv0 = __raw_readl(S5PC100_CLKDIV0);
+	clkdiv1 = __raw_readl(S5PC100_CLKDIV1);
 
 	printk(KERN_DEBUG "%s: clkdiv0 = %08x, clkdiv1 = %08x\n",
 			__func__, clkdiv0, clkdiv1);
@@ -1075,15 +1075,15 @@ void __init_or_cpufreq s5pc100_setup_clocks(void)
 
 	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
 
-	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC1XX_APLL_CON));
-	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC1XX_MPLL_CON));
-	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC1XX_EPLL_CON));
+	apll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_APLL_CON));
+	mpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_MPLL_CON));
+	epll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_EPLL_CON));
 	hpll = s5pc1xx_get_pll(xtal, __raw_readl(S5PC100_HPLL_CON));
 
 	printk(KERN_INFO "S5PC100: PLL settings, A=%ld, M=%ld, E=%ld, H=%ld\n",
 	       apll, mpll, epll, hpll);
 
-	armclk = apll / GET_DIV(clkdiv0, S5PC1XX_CLKDIV0_APLL);
+	armclk = apll / GET_DIV(clkdiv0, S5PC100_CLKDIV0_APLL);
 	armclk = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_ARM);
 	hclkd0 = armclk / GET_DIV(clkdiv0, S5PC100_CLKDIV0_D0);
 	pclkd0 = hclkd0 / GET_DIV(clkdiv0, S5PC100_CLKDIV0_PCLKD0);
-- 
1.6.4
