From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Jul 2014 13:46:34 +0200
Subject: [PATCH 14/16] i2c: i2c-stu300: Drop class based scanning to improve
 bootup time
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1404992799-3705-15-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index fefb1c19ec1d..6a44f37798c8 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -909,7 +909,7 @@ static int stu300_probe(struct platform_device *pdev)
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
 	/* DDC class but actually often used for more generic I2C */
-	adap->class = I2C_CLASS_DDC | I2C_CLASS_DEPRECATED;
+	adap->class = I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "ST Microelectronics DDC I2C adapter",
 		sizeof(adap->name));
 	adap->nr = bus_nr;
-- 
2.0.0
