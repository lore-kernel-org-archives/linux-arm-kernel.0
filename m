From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:29 +0200
Subject: [PATCH 09/16] i2c: i2c-ocores: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-10-git-send-email-wsa@the-dreams.de>
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
 drivers/i2c/busses/i2c-ocores.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0e10cc6182f0..2a4fe0b7cfb7 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -239,15 +239,15 @@ static u32 ocores_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm ocores_algorithm = {
-	.master_xfer	= ocores_xfer,
-	.functionality	= ocores_func,
+	.master_xfer = ocores_xfer,
+	.functionality = ocores_func,
 };
 
 static struct i2c_adapter ocores_adapter = {
-	.owner		= THIS_MODULE,
-	.name		= "i2c-ocores",
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED,
-	.algo		= &ocores_algorithm,
+	.owner = THIS_MODULE,
+	.name = "i2c-ocores",
+	.class = I2C_CLASS_DEPRECATED,
+	.algo = &ocores_algorithm,
 };
 
 static const struct of_device_id ocores_i2c_match[] = {
-- 
2.0.0
