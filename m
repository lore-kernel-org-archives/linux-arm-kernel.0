From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Feb 2014 11:04:04 +0100
Subject: [PATCH 10/17] i2c: i2c-nomadik: deprecate class based instantiation
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392026654-5343-11-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 8bf9ac0..e3777ac 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1019,7 +1019,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->dev.of_node = np;
 	adap->dev.parent = &adev->dev;
 	adap->owner	= THIS_MODULE;
-	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
 	adap->algo	= &nmk_i2c_algo;
 	adap->timeout	= msecs_to_jiffies(pdata->timeout);
 	snprintf(adap->name, sizeof(adap->name),
-- 
1.8.5.1
