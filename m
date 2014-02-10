From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Feb 2014 11:04:07 +0100
Subject: [PATCH 13/17] i2c: i2c-s3c2410: deprecate class based instantiation
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392026654-5343-14-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index bf8fb94..4a623e0 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1062,7 +1062,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.algo    = &s3c24xx_i2c_algorithm;
 	i2c->adap.retries = 2;
-	i2c->adap.class   = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	i2c->adap.class   = I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
 	i2c->tx_setup     = 50;
 
 	init_waitqueue_head(&i2c->wait);
-- 
1.8.5.1
