From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:54:25 +0900
Subject: [PATCH 1/4] i2c: imx: Constify platform_device_id
Message-ID: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a53a7dd66945..785aa674a4da 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -241,7 +241,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
 
 };
 
-static struct platform_device_id imx_i2c_devtype[] = {
+static const struct platform_device_id imx_i2c_devtype[] = {
 	{
 		.name = "imx1-i2c",
 		.driver_data = (kernel_ulong_t)&imx1_i2c_hwdata,
-- 
2.1.4
