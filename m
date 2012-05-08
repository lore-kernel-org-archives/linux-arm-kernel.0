From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:49 +0530
Subject: [PATCH 05/10] ARM: Samsung: Update the device names for spi clock
 lookup
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the addition of platform specific driver data in the spi-s3c64xx
driver, the device name of spi controllers are changed. Accordingly,
update the device name of spi clocks instances.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos4.c   |   18 +++++++++---------
 arch/arm/mach-s3c24xx/clock-s3c2416.c  |    2 +-
 arch/arm/mach-s3c24xx/clock-s3c2443.c  |    2 +-
 arch/arm/mach-s3c24xx/common-s3c2443.c |    4 ++--
 arch/arm/mach-s3c64xx/clock.c          |   20 ++++++++++----------
 arch/arm/mach-s5p64x0/clock-s5p6440.c  |   12 ++++++------
 arch/arm/mach-s5p64x0/clock-s5p6450.c  |   12 ++++++------
 arch/arm/mach-s5pc100/clock.c          |   30 +++++++++++++++---------------
 arch/arm/mach-s5pv210/clock.c          |   14 +++++++-------
 9 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index 6efd1e5..57b5464 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -581,17 +581,17 @@ static struct clk exynos4_init_clocks_off[] = {
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "exynos4210-spi.0",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "exynos4210-spi.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.2",
+		.devname	= "exynos4210-spi.2",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
@@ -1246,7 +1246,7 @@ static struct clksrc_clk exynos4_clk_sclk_mmc3 = {
 static struct clksrc_clk exynos4_clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "exynos4210-spi.0",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 16),
 	},
@@ -1258,7 +1258,7 @@ static struct clksrc_clk exynos4_clk_sclk_spi0 = {
 static struct clksrc_clk exynos4_clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "exynos4210-spi.1",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 20),
 	},
@@ -1270,7 +1270,7 @@ static struct clksrc_clk exynos4_clk_sclk_spi1 = {
 static struct clksrc_clk exynos4_clk_sclk_spi2 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.2",
+		.devname	= "exynos4210-spi.2",
 		.enable		= exynos4_clksrc_mask_peril1_ctrl,
 		.ctrlbit	= (1 << 24),
 	},
@@ -1348,9 +1348,9 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos4_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos4_clk_pdma1),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos4_clk_mdma1),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
-	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),
+	CLKDEV_INIT("exynos4210-spi.0", "spi_busclk0", &exynos4_clk_sclk_spi0.clk),
+	CLKDEV_INIT("exynos4210-spi.1", "spi_busclk0", &exynos4_clk_sclk_spi1.clk),
+	CLKDEV_INIT("exynos4210-spi.2", "spi_busclk0", &exynos4_clk_sclk_spi2.clk),
 };
 
 static int xtal_rate;
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
index 8702ecf..a582ba1 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
@@ -144,7 +144,7 @@ static struct clk_lookup s3c2416_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &hsspi_mux.clk),
+	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &hsspi_mux.clk),
 };
 
 void __init s3c2416_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
index a4c5a52..7f689ce 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
@@ -181,7 +181,7 @@ static struct clk *clks[] __initdata = {
 
 static struct clk_lookup s3c2443_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_hsmmc),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_hsspi.clk),
+	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk2", &clk_hsspi.clk),
 };
 
 void __init s3c2443_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index aeeb2be..aeb4a24 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -559,7 +559,7 @@ static struct clk hsmmc1_clk = {
 
 static struct clk hsspi_clk = {
 	.name		= "spi",
-	.devname	= "s3c64xx-spi.0",
+	.devname	= "s3c2443-spi.0",
 	.parent		= &clk_p,
 	.enable		= s3c2443_clkcon_enable_p,
 	.ctrlbit	= S3C2443_PCLKCON_HSSPI,
@@ -633,7 +633,7 @@ static struct clk_lookup s3c2443_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_esys_uart.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &hsspi_clk),
+	CLKDEV_INIT("s3c2443-spi.0", "spi_busclk0", &hsspi_clk),
 };
 
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 52f079a..28041e8 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -178,13 +178,13 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= S3C_CLKCON_PCLK_KEYPAD,
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s3c6410-spi.0",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI0,
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s3c6410-spi.1",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI1,
@@ -331,7 +331,7 @@ static struct clk init_clocks_off[] = {
 
 static struct clk clk_48m_spi0 = {
 	.name		= "spi_48m",
-	.devname	= "s3c64xx-spi.0",
+	.devname	= "s3c6410-spi.0",
 	.parent		= &clk_48m,
 	.enable		= s3c64xx_sclk_ctrl,
 	.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
@@ -339,7 +339,7 @@ static struct clk clk_48m_spi0 = {
 
 static struct clk clk_48m_spi1 = {
 	.name		= "spi_48m",
-	.devname	= "s3c64xx-spi.1",
+	.devname	= "s3c6410-spi.1",
 	.parent		= &clk_48m,
 	.enable		= s3c64xx_sclk_ctrl,
 	.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
@@ -802,7 +802,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "spi-bus",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s3c6410-spi.0",
 		.ctrlbit	= S3C_CLKCON_SCLK_SPI0,
 		.enable		= s3c64xx_sclk_ctrl,
 	},
@@ -814,7 +814,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
 static struct clksrc_clk clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "spi-bus",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s3c6410-spi.1",
 		.ctrlbit	= S3C_CLKCON_SCLK_SPI1,
 		.enable		= s3c64xx_sclk_ctrl,
 	},
@@ -858,10 +858,10 @@ static struct clk_lookup s3c64xx_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_48m_spi0),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_48m_spi1),
+	CLKDEV_INIT("s3c6410-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c6410-spi.0", "spi_busclk2", &clk_48m_spi0),
+	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c6410-spi.1", "spi_busclk2", &clk_48m_spi1),
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index ee1e8e7..55ea3ab 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -227,13 +227,13 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5p64x0-spi.0",
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5p64x0-spi.1",
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 22),
@@ -467,7 +467,7 @@ static struct clksrc_clk clk_sclk_uclk = {
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5p64x0-spi.0",
 		.ctrlbit	= (1 << 20),
 		.enable		= s5p64x0_sclk_ctrl,
 	},
@@ -479,7 +479,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
 static struct clksrc_clk clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5p64x0-spi.1",
 		.ctrlbit	= (1 << 21),
 		.enable		= s5p64x0_sclk_ctrl,
 	},
@@ -519,8 +519,8 @@ static struct clk_lookup s5p6440_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s5p64x0.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s5p64x0.1", "spi_busclk1", &clk_sclk_spi1.clk),
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index dae6a13..f3e0ef3 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -236,13 +236,13 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5p64x0-spi.0",
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5p64x0-spi.1",
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 22),
@@ -528,7 +528,7 @@ static struct clksrc_clk clk_sclk_uclk = {
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5p64x0-spi.0",
 		.ctrlbit	= (1 << 20),
 		.enable		= s5p64x0_sclk_ctrl,
 	},
@@ -540,7 +540,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
 static struct clksrc_clk clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5p64x0-spi.1",
 		.ctrlbit	= (1 << 21),
 		.enable		= s5p64x0_sclk_ctrl,
 	},
@@ -562,8 +562,8 @@ static struct clk_lookup s5p6450_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s5p64x0-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s5p64x0-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 16eca4e..9262197 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -564,19 +564,19 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5pc100-spi.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5pc100-spi.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.2",
+		.devname	= "s5pc100-spi.2",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 8),
@@ -702,7 +702,7 @@ static struct clk clk_hsmmc0 = {
 
 static struct clk clk_48m_spi0 = {
 	.name		= "spi_48m",
-	.devname	= "s3c64xx-spi.0",
+	.devname	= "s5pc100-spi.0",
 	.parent		= &clk_mout_48m.clk,
 	.enable		= s5pc100_sclk0_ctrl,
 	.ctrlbit	= (1 << 7),
@@ -710,7 +710,7 @@ static struct clk clk_48m_spi0 = {
 
 static struct clk clk_48m_spi1 = {
 	.name		= "spi_48m",
-	.devname	= "s3c64xx-spi.1",
+	.devname	= "s5pc100-spi.1",
 	.parent		= &clk_mout_48m.clk,
 	.enable		= s5pc100_sclk0_ctrl,
 	.ctrlbit	= (1 << 8),
@@ -718,7 +718,7 @@ static struct clk clk_48m_spi1 = {
 
 static struct clk clk_48m_spi2 = {
 	.name		= "spi_48m",
-	.devname	= "s3c64xx-spi.2",
+	.devname	= "s5pc100-spi.2",
 	.parent		= &clk_mout_48m.clk,
 	.enable		= s5pc100_sclk0_ctrl,
 	.ctrlbit	= (1 << 9),
@@ -1085,7 +1085,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5pc100-spi.0",
 		.ctrlbit	= (1 << 4),
 		.enable		= s5pc100_sclk0_ctrl,
 	},
@@ -1097,7 +1097,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
 static struct clksrc_clk clk_sclk_spi1 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5pc100-spi.1",
 		.ctrlbit	= (1 << 5),
 		.enable		= s5pc100_sclk0_ctrl,
 	},
@@ -1109,7 +1109,7 @@ static struct clksrc_clk clk_sclk_spi1 = {
 static struct clksrc_clk clk_sclk_spi2 = {
 	.clk	= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.2",
+		.devname	= "s5pc100-spi.2",
 		.ctrlbit	= (1 << 6),
 		.enable		= s5pc100_sclk0_ctrl,
 	},
@@ -1315,12 +1315,12 @@ static struct clk_lookup s5pc100_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_48m_spi0),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_48m_spi1),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
-	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk1", &clk_48m_spi2),
-	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
+	CLKDEV_INIT("s5pc100-spi.0", "spi_busclk1", &clk_48m_spi0),
+	CLKDEV_INIT("s5pc100-spi.0", "spi_busclk2", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s5pc100-spi.1", "spi_busclk1", &clk_48m_spi1),
+	CLKDEV_INIT("s5pc100-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk1", &clk_48m_spi2),
+	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
 };
 
 void __init s5pc100_register_clocks(void)
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 09609d5..fcdf52d 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -445,19 +445,19 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5pv210-spi.0",
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<12),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5pv210-spi.1",
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<13),
 	}, {
 		.name		= "spi",
-		.devname	= "s3c64xx-spi.2",
+		.devname	= "s5pv210-spi.2",
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<14),
@@ -1035,7 +1035,7 @@ static struct clksrc_clk clk_sclk_mmc3 = {
 static struct clksrc_clk clk_sclk_spi0 = {
 	.clk		= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.0",
+		.devname	= "s5pv210-spi.0",
 		.enable		= s5pv210_clk_mask0_ctrl,
 		.ctrlbit	= (1 << 16),
 	},
@@ -1047,7 +1047,7 @@ static struct clksrc_clk clk_sclk_spi0 = {
 static struct clksrc_clk clk_sclk_spi1 = {
 	.clk		= {
 		.name		= "sclk_spi",
-		.devname	= "s3c64xx-spi.1",
+		.devname	= "s5pv210-spi.1",
 		.enable		= s5pv210_clk_mask0_ctrl,
 		.ctrlbit	= (1 << 17),
 	},
@@ -1331,8 +1331,8 @@ static struct clk_lookup s5pv210_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 	CLKDEV_INIT(NULL, "spi_busclk0", &clk_p),
-	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
-	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s5pv210-spi.0", "spi_busclk1", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s5pv210-spi.1", "spi_busclk1", &clk_sclk_spi1.clk),
 };
 
 void __init s5pv210_register_clocks(void)
-- 
1.6.6.rc2
