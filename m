From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:22 +0200
Subject: [PATCH 02/16] i2c: i2c-at91: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index e95f9ba96790..7033e9166d1f 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -768,7 +768,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
 	i2c_set_adapdata(&dev->adapter, dev);
 	dev->adapter.owner = THIS_MODULE;
-	dev->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
+	dev->adapter.class = I2C_CLASS_DEPRECATED;
 	dev->adapter.algo = &at91_twi_algorithm;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
-- 
2.0.0
