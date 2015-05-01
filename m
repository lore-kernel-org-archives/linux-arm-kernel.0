From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:54:26 +0900
Subject: [PATCH 2/4] i2c: mxs: Constify platform_device_id
In-Reply-To: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495668-31878-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3e84f6c090a5..033846cdf266 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -784,7 +784,7 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
-static struct platform_device_id mxs_i2c_devtype[] = {
+static const struct platform_device_id mxs_i2c_devtype[] = {
 	{
 		.name = "imx23-i2c",
 		.driver_data = MXS_I2C_V1,
-- 
2.1.4
