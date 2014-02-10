From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Feb 2014 11:04:08 +0100
Subject: [PATCH 14/17] i2c: i2c-sirf: deprecate class based instantiation
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392026654-5343-15-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Barry Song <baohua@kernel.org>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 6784f7f..8e3be7e 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -312,7 +312,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 		goto out;
 	}
 	adap = &siic->adapter;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	siic->base = devm_ioremap_resource(&pdev->dev, mem_res);
-- 
1.8.5.1
