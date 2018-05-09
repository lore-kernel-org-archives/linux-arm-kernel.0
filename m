From: peda@axentia.se (Peter Rosin)
Date: Wed,  9 May 2018 21:45:32 +0200
Subject: [PATCH 2/2] i2c: exynos5: remove pointless initializers
In-Reply-To: <20180509194532.28929-1-peda@axentia.se>
References: <20180509194532.28929-1-peda@axentia.se>
Message-ID: <20180509194532.28929-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variables are always assigned before use anyway.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-exynos5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index a2cbc779c33a..185fba37e830 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msgs, int num)
 {
 	struct exynos5_i2c *i2c = adap->algo_data;
-	int i = 0, ret = 0, stop = 0;
+	int i, ret, stop;
 
 	if (i2c->suspended) {
 		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
-- 
2.11.0
