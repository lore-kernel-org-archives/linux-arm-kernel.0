From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 23 Sep 2011 17:23:47 +0530
Subject: [PATCH 7/7] ARM: SAMSUNG: Remove SPI bus clocks from platform data
In-Reply-To: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
References: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
Message-ID: <1316778827-24694-8-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI bus clocks can be avoided passing through platform
data as spi driver is getting the bus clock using the
generic clock connection id registered via clkdev.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c                  |    7 -------
 arch/arm/mach-s5p64x0/dev-spi.c                  |    6 ------
 arch/arm/mach-s5pc100/dev-spi.c                  |    7 -------
 arch/arm/mach-s5pv210/dev-spi.c                  |    6 ------
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 --
 5 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
index 5e6b420..86fb130 100644
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -23,12 +23,6 @@
 #include <plat/gpio-cfg.h>
 #include <plat/devs.h>
 
-static char *spi_src_clks[] = {
-	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
-	[S3C64XX_SPI_SRCCLK_SPIBUS] = "spi-bus",
-	[S3C64XX_SPI_SRCCLK_48M] = "spi_48m",
-};
-
 /* SPI Controller platform_devices */
 
 /* Since we emulate multi-cs capability, we do not touch the GPC-3,7.
@@ -175,5 +169,4 @@ void __init s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
 }
diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
index ac825e8..0604494 100644
--- a/arch/arm/mach-s5p64x0/dev-spi.c
+++ b/arch/arm/mach-s5p64x0/dev-spi.c
@@ -24,11 +24,6 @@
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
 
-static char *s5p64x0_spi_src_clks[] = {
-	[S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
-	[S5P64X0_SPI_SRCCLK_SCLK] = "sclk_spi",
-};
-
 /* SPI Controller platform_devices */
 
 /* Since we emulate multi-cs capability, we do not touch the CS.
@@ -222,5 +217,4 @@ void __init s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = s5p64x0_spi_src_clks[src_clk_nr];
 }
diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
index e5d6c4d..155f50d 100644
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -21,12 +21,6 @@
 #include <plat/gpio-cfg.h>
 #include <plat/irqs.h>
 
-static char *spi_src_clks[] = {
-	[S5PC100_SPI_SRCCLK_PCLK] = "pclk",
-	[S5PC100_SPI_SRCCLK_48M] = "spi_48m",
-	[S5PC100_SPI_SRCCLK_SPIBUS] = "spi_bus",
-};
-
 /* SPI Controller platform_devices */
 
 /* Since we emulate multi-cs capability, we do not touch the CS.
@@ -223,5 +217,4 @@ void __init s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
 }
diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
index eaf9a7b..39bef19 100644
--- a/arch/arm/mach-s5pv210/dev-spi.c
+++ b/arch/arm/mach-s5pv210/dev-spi.c
@@ -20,11 +20,6 @@
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
 
-static char *spi_src_clks[] = {
-	[S5PV210_SPI_SRCCLK_PCLK] = "pclk",
-	[S5PV210_SPI_SRCCLK_SCLK] = "sclk_spi",
-};
-
 /* SPI Controller platform_devices */
 
 /* Since we emulate multi-cs capability, we do not touch the CS.
@@ -171,5 +166,4 @@ void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
 }
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 4c16fa3..c3d82a5 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -31,7 +31,6 @@ struct s3c64xx_spi_csinfo {
 /**
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
- * @src_clk_name: Platform name of the corresponding clock.
  * @clk_from_cmu: If the SPI clock/prescalar control block is present
  *     by the platform's clock-management-unit and not in SPI controller.
  * @num_cs: Number of CS this controller emulates.
@@ -43,7 +42,6 @@ struct s3c64xx_spi_csinfo {
  */
 struct s3c64xx_spi_info {
 	int src_clk_nr;
-	char *src_clk_name;
 	bool clk_from_cmu;
 
 	int num_cs;
-- 
1.7.4.4
