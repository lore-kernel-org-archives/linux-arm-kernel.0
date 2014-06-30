From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:20 +0900
Subject: [PATCH 10/17] spi: s3c64xx: remove s5pc100 related spi codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes sp5c100 related spi because of no more support
s5pc100 SoC.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4a1890a..a771a3a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1323,13 +1323,6 @@ static struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	.tx_st_done	= 21,
 };
 
-static struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
-	.fifo_lvl_mask	= { 0x7f, 0x7F },
-	.rx_lvl_offset	= 13,
-	.tx_st_done	= 21,
-	.high_speed	= true,
-};
-
 static struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
@@ -1362,9 +1355,6 @@ static struct platform_device_id s3c64xx_spi_driver_ids[] = {
 		.name		= "s3c6410-spi",
 		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
 	}, {
-		.name		= "s5pc100-spi",
-		.driver_data	= (kernel_ulong_t)&s5pc100_spi_port_config,
-	}, {
 		.name		= "s5pv210-spi",
 		.driver_data	= (kernel_ulong_t)&s5pv210_spi_port_config,
 	}, {
@@ -1381,9 +1371,6 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,s3c6410-spi",
 			.data = (void *)&s3c6410_spi_port_config,
 	},
-	{ .compatible = "samsung,s5pc100-spi",
-			.data = (void *)&s5pc100_spi_port_config,
-	},
 	{ .compatible = "samsung,s5pv210-spi",
 			.data = (void *)&s5pv210_spi_port_config,
 	},
-- 
1.7.10.4
