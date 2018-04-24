From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 22:32:37 +0200
Subject: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <20180424203239.21885-9-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 755ab2dc6969..f55dc78957ad 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1376,15 +1376,6 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.clk_from_cmu	= true,
 };
 
-static struct s3c64xx_spi_port_config exynos5440_spi_port_config = {
-	.fifo_lvl_mask	= { 0x1ff },
-	.rx_lvl_offset	= 15,
-	.tx_st_done	= 25,
-	.high_speed	= true,
-	.clk_from_cmu	= true,
-	.quirks		= S3C64XX_SPI_QUIRK_POLL,
-};
-
 static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
 	.rx_lvl_offset	= 15,
@@ -1428,9 +1419,6 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos4210-spi",
 			.data = (void *)&exynos4_spi_port_config,
 	},
-	{ .compatible = "samsung,exynos5440-spi",
-			.data = (void *)&exynos5440_spi_port_config,
-	},
 	{ .compatible = "samsung,exynos7-spi",
 			.data = (void *)&exynos7_spi_port_config,
 	},
-- 
2.14.1
