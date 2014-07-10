From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:24 +0200
Subject: [PATCH 04/16] i2c: i2c-bfin-twi: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 3e271e7558d3..067c1615e968 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -648,7 +648,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
 	p_adap->algo = &bfin_twi_algorithm;
 	p_adap->algo_data = iface;
-	p_adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
+	p_adap->class = I2C_CLASS_DEPRECATED;
 	p_adap->dev.parent = &pdev->dev;
 	p_adap->timeout = 5 * HZ;
 	p_adap->retries = 3;
-- 
2.0.0
