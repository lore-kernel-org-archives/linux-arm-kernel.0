From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:34 +0800
Subject: [PATCH 14/17] ARM: at91: add clocks for spi DT entries
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352710357-3265-15-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
[<wenyou.yang at atmel.com: declare the spi clocks for other at91 SoC]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
Cc: plagnioj at jcrosoft.com
Cc: linux at maxim.org.za
---
Hi, Richard,

This patch is based on the original patch from Richard Genoud,
	[PATCH] sam9x5: declare SPI clocks
and referring to this patch, Wenyou Yang declare the spi clocks for
	other at91 SoC.

Is it ok for you?

Best Regards
Wenyou Yang

 arch/arm/mach-at91/at91sam9260.c |    2 ++
 arch/arm/mach-at91/at91sam9g45.c |    2 ++
 arch/arm/mach-at91/at91sam9n12.c |    2 ++
 arch/arm/mach-at91/at91sam9x5.c  |    2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index f820261..6c217eb 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -230,6 +230,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
 	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 84af1b5..d419002 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -256,6 +256,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fff84000.i2c", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fff88000.i2c", &twi1_clk),
 	/* fake hclk clock */
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index 732d3d3..ea87f0e 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -169,6 +169,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "f0000000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "f0004000.spi", &spi1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8010000.i2c", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8014000.i2c", &twi1_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index e503538..19408af 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -231,6 +231,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "f0000000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "f0004000.spi", &spi1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8010000.i2c", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8014000.i2c", &twi1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "f8018000.i2c", &twi2_clk),
-- 
1.7.9.5
