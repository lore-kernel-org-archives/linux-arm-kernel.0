From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:54:28 +0900
Subject: [PATCH 4/4] i2c: s4c2410: Constify platform_device_id
In-Reply-To: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495668-31878-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 958c8db4ec30..c1f0e62d1bb1 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -132,7 +132,7 @@ struct s3c24xx_i2c {
 	unsigned int		sys_i2c_cfg;
 };
 
-static struct platform_device_id s3c24xx_driver_ids[] = {
+static const struct platform_device_id s3c24xx_driver_ids[] = {
 	{
 		.name		= "s3c2410-i2c",
 		.driver_data	= 0,
-- 
2.1.4
