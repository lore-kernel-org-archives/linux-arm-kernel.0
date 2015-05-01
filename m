From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:50:01 +0900
Subject: [PATCH 1/3] mtd: mxc-nand: Constify platform_device_id
Message-ID: <1430495403-31560-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mtd/nand/mxc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 372e0e38f59b..2c46489eeee0 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1350,7 +1350,7 @@ static inline int is_imx53_nfc(struct mxc_nand_host *host)
 	return host->devtype_data == &imx53_nand_devtype_data;
 }
 
-static struct platform_device_id mxcnd_devtype[] = {
+static const struct platform_device_id mxcnd_devtype[] = {
 	{
 		.name = "imx21-nand",
 		.driver_data = (kernel_ulong_t) &imx21_nand_devtype_data,
-- 
2.1.4
