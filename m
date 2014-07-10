From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:36 +0200
Subject: [PATCH 16/16] i2c: i2c-xiic: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-17-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.
While we are here, remove the indentation for the array setup because
such things always break after some time.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-xiic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 7731f1795869..ade9223912d3 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -677,15 +677,15 @@ static u32 xiic_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm xiic_algorithm = {
-	.master_xfer	= xiic_xfer,
-	.functionality	= xiic_func,
+	.master_xfer = xiic_xfer,
+	.functionality = xiic_func,
 };
 
 static struct i2c_adapter xiic_adapter = {
-	.owner		= THIS_MODULE,
-	.name		= DRIVER_NAME,
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED,
-	.algo		= &xiic_algorithm,
+	.owner = THIS_MODULE,
+	.name = DRIVER_NAME,
+	.class = I2C_CLASS_DEPRECATED,
+	.algo = &xiic_algorithm,
 };
 
 
-- 
2.0.0
