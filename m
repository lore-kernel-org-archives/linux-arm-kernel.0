From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:13 +0900
Subject: [PATCH 03/17] spi: s3c64xx: remove s5p64x0 related spi codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes s5p64x0 related spi because of no more support for
s5p64x0 SoCs. Meanwhile, cleanup SPI DT bindings for s5p6440-spi, it
should be s5p64x0-spi instead.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt |    1 -
 drivers/spi/spi-s3c64xx.c                             |    9 ---------
 2 files changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 86aa061..fe6f903 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -8,7 +8,6 @@ Required SoC Specific Properties:
 - compatible: should be one of the following.
     - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
     - samsung,s3c6410-spi: for s3c6410 platforms
-    - samsung,s5p6440-spi: for s5p6440 and s5p6450 platforms
     - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
     - samsung,exynos4210-spi: for exynos4 and exynos5 platforms
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 75a5696..4a1890a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1323,12 +1323,6 @@ static struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	.tx_st_done	= 21,
 };
 
-static struct s3c64xx_spi_port_config s5p64x0_spi_port_config = {
-	.fifo_lvl_mask	= { 0x1ff, 0x7F },
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-};
-
 static struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
 	.rx_lvl_offset	= 13,
@@ -1368,9 +1362,6 @@ static struct platform_device_id s3c64xx_spi_driver_ids[] = {
 		.name		= "s3c6410-spi",
 		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
 	}, {
-		.name		= "s5p64x0-spi",
-		.driver_data	= (kernel_ulong_t)&s5p64x0_spi_port_config,
-	}, {
 		.name		= "s5pc100-spi",
 		.driver_data	= (kernel_ulong_t)&s5pc100_spi_port_config,
 	}, {
-- 
1.7.10.4
