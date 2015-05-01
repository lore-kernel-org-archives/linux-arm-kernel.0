From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:06 +0900
Subject: [PATCH 3/4] spi: s3c64xx: Constify platform_device_id
In-Reply-To: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495047-31122-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b1c6731fbf27..2a8c513c4d07 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1347,7 +1347,7 @@ static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
-static struct platform_device_id s3c64xx_spi_driver_ids[] = {
+static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
 		.driver_data	= (kernel_ulong_t)&s3c2443_spi_port_config,
-- 
2.1.4
