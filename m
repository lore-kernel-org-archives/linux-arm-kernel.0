From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:28:01 +0900
Subject: [PATCH 11/11] ARM: S5P6440: Remove redundant defines
Message-ID: <1273710481-14856-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Remove redundant defines in the clock code.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c                   |   62 +++++++++++-----------
 arch/arm/mach-s5p6440/include/mach/regs-clock.h |   49 ------------------
 2 files changed, 31 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index ca6e48d..051d182 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -357,121 +357,121 @@ static struct clk init_clocks_disable[] = {
 		.id		= -1,
 		.parent		= &clk_hclk.clk,
 		.enable		= s5p6440_mem_ctrl,
-		.ctrlbit	= S5P_CLKCON_MEM0_HCLK_NFCON,
+		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "adc",
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_TSADC,
+		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "i2c",
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_IIC0,
+		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "i2s_v40",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_IIS2,
+		.ctrlbit	= (1 << 26),
 	}, {
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_SPI0,
+		.ctrlbit	= (1 << 21),
 	}, {
 		.name		= "spi",
 		.id		= 1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_SPI1,
+		.ctrlbit	= (1 << 22),
 	}, {
 		.name		= "sclk_spi_48",
 		.id		= 0,
 		.parent		= &clk_48m,
 		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_SPI0_48,
+		.ctrlbit	= (1 << 22),
 	}, {
 		.name		= "sclk_spi_48",
 		.id		= 1,
 		.parent		= &clk_48m,
 		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_SPI1_48,
+		.ctrlbit	= (1 << 23),
 	}, {
 		.name		= "mmc_48m",
 		.id		= 0,
 		.parent		= &clk_48m,
 		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC0_48,
+		.ctrlbit	= (1 << 27),
 	}, {
 		.name		= "mmc_48m",
 		.id		= 1,
 		.parent		= &clk_48m,
 		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC1_48,
+		.ctrlbit	= (1 << 28),
 	}, {
 		.name		= "mmc_48m",
 		.id		= 2,
 		.parent		= &clk_48m,
 		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC2_48,
+		.ctrlbit	= (1 << 29),
 	}, {
 		.name    	= "otg",
 		.id	   	= -1,
 		.parent		= &clk_hclk_low.clk,
 		.enable  	= s5p6440_hclk0_ctrl,
-		.ctrlbit 	= S5P_CLKCON_HCLK0_USB
+		.ctrlbit	= (1 << 20),
 	}, {
 		.name    	= "post",
 		.id	   	= -1,
 		.parent		= &clk_hclk_low.clk,
 		.enable  	= s5p6440_hclk0_ctrl,
-		.ctrlbit 	= S5P_CLKCON_HCLK0_POST0
+		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "lcd",
 		.id		= -1,
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk1_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK1_DISPCON,
+		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC0,
+		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC1,
+		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC2,
+		.ctrlbit	= (1 << 19),
 	}, {
 		.name		= "rtc",
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_RTC,
+		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "watchdog",
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_WDT,
+		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "timers",
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_PWM,
+		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hclk_fimgvg",
 		.id		= -1,
@@ -550,31 +550,31 @@ static struct clk init_clocks[] = {
 		.id		= -1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_GPIO,
+		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "uart",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART0,
+		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "uart",
 		.id		= 1,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART1,
+		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "uart",
 		.id		= 2,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART2,
+		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "uart",
 		.id		= 3,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART3,
+		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "mem",
 		.id		= -1,
@@ -639,7 +639,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "mmc_bus",
 			.id		= 0,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC0,
+			.ctrlbit        = (1 << 24),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_group1,
@@ -649,7 +649,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "mmc_bus",
 			.id		= 1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC1,
+			.ctrlbit        = (1 << 25),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_group1,
@@ -659,7 +659,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "mmc_bus",
 			.id		= 2,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC2,
+			.ctrlbit        = (1 << 26),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_group1,
@@ -669,7 +669,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "uclk1",
 			.id		= -1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_UART,
+			.ctrlbit        = (1 << 5),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_uart,
@@ -679,7 +679,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "spi_epll",
 			.id		= 0,
-			.ctrlbit        = S5P_CLKCON_SCLK0_SPI0,
+			.ctrlbit        = (1 << 20),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_group1,
@@ -689,7 +689,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "spi_epll",
 			.id		= 1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_SPI1,
+			.ctrlbit        = (1 << 21),
 			.enable		= s5p6440_sclk_ctrl,
 		},
 		.sources = &clkset_group1,
diff --git a/arch/arm/mach-s5p6440/include/mach/regs-clock.h b/arch/arm/mach-s5p6440/include/mach/regs-clock.h
index c783ecc..0e9b1b7 100644
--- a/arch/arm/mach-s5p6440/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5p6440/include/mach/regs-clock.h
@@ -69,55 +69,6 @@
 #define S5P_CLKDIV0_ARM_MASK		(0xf << 0)
 #define S5P_CLKDIV0_ARM_SHIFT		(0)
 
-/* CLKDIV3 */
-#define S5P_CLKDIV3_PCLK_LOW_MASK	(0xf << 12)
-#define S5P_CLKDIV3_PCLK_LOW_SHIFT	(12)
-#define S5P_CLKDIV3_HCLK_LOW_MASK	(0xf << 8)
-#define S5P_CLKDIV3_HCLK_LOW_SHIFT	(8)
-
-/* HCLK0 GATE Registers */
-#define S5P_CLKCON_HCLK0_USB		(1<<20)
-#define S5P_CLKCON_HCLK0_HSMMC2		(1<<19)
-#define S5P_CLKCON_HCLK0_HSMMC1		(1<<18)
-#define S5P_CLKCON_HCLK0_HSMMC0		(1<<17)
-#define S5P_CLKCON_HCLK0_POST0		(1<<5)
-
-/* HCLK1 GATE Registers */
-#define S5P_CLKCON_HCLK1_DISPCON	(1<<1)
-
-/* PCLK GATE Registers */
-#define S5P_CLKCON_PCLK_IIS2		(1<<26)
-#define S5P_CLKCON_PCLK_SPI1		(1<<22)
-#define S5P_CLKCON_PCLK_SPI0		(1<<21)
-#define S5P_CLKCON_PCLK_GPIO		(1<<18)
-#define S5P_CLKCON_PCLK_IIC0		(1<<17)
-#define S5P_CLKCON_PCLK_TSADC		(1<<12)
-#define S5P_CLKCON_PCLK_PWM		(1<<7)
-#define S5P_CLKCON_PCLK_RTC		(1<<6)
-#define S5P_CLKCON_PCLK_WDT		(1<<5)
-#define S5P_CLKCON_PCLK_UART3		(1<<4)
-#define S5P_CLKCON_PCLK_UART2		(1<<3)
-#define S5P_CLKCON_PCLK_UART1		(1<<2)
-#define S5P_CLKCON_PCLK_UART0		(1<<1)
-
-/* SCLK0 GATE Registers */
-#define S5P_CLKCON_SCLK0_MMC2_48	(1<<29)
-#define S5P_CLKCON_SCLK0_MMC1_48	(1<<28)
-#define S5P_CLKCON_SCLK0_MMC0_48	(1<<27)
-#define S5P_CLKCON_SCLK0_MMC2		(1<<26)
-#define S5P_CLKCON_SCLK0_MMC1		(1<<25)
-#define S5P_CLKCON_SCLK0_MMC0		(1<<24)
-#define S5P_CLKCON_SCLK0_SPI1_48 	(1<<23)
-#define S5P_CLKCON_SCLK0_SPI0_48 	(1<<22)
-#define S5P_CLKCON_SCLK0_SPI1		(1<<21)
-#define S5P_CLKCON_SCLK0_SPI0		(1<<20)
-#define S5P_CLKCON_SCLK0_UART		(1<<5)
-
-/* SCLK1 GATE Registers */
-
-/* MEM0 GATE Registers */
-#define S5P_CLKCON_MEM0_HCLK_NFCON	(1<<2)
-
 /*OTHERS Resgister */
 #define S5P_OTHERS_USB_SIG_MASK		(1<<16)
 #define S5P_OTHERS_HCLK_LOW_SEL_MPLL	(1<<6)
-- 
1.6.2.5
