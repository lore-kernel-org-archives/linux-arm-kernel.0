From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:54:27 +0900
Subject: [PATCH 3/4] i2c: rcar: Constify platform_device_id
In-Reply-To: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495668-31878-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495668-31878-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 5a84bea5b845..06f34d1c5121 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -713,7 +713,7 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id rcar_i2c_id_table[] = {
+static const struct platform_device_id rcar_i2c_id_table[] = {
 	{ "i2c-rcar",		I2C_RCAR_GEN1 },
 	{ "i2c-rcar_gen1",	I2C_RCAR_GEN1 },
 	{ "i2c-rcar_gen2",	I2C_RCAR_GEN2 },
-- 
2.1.4
