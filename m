From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:04 +0900
Subject: [PATCH 1/4] spi: imx: Constify platform_device_id
Message-ID: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f08e812b2984..eb7d3a6fb14c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -674,7 +674,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.devtype = IMX51_ECSPI,
 };
 
-static struct platform_device_id spi_imx_devtype[] = {
+static const struct platform_device_id spi_imx_devtype[] = {
 	{
 		.name = "imx1-cspi",
 		.driver_data = (kernel_ulong_t) &imx1_cspi_devtype_data,
-- 
2.1.4
