From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Jul 2015 16:14:36 +0900
Subject: [PATCH] i2c: cadence: set THIS_MODULE to the owner of the adapter
Message-ID: <1437462876-13755-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The owner of the adapter is missing, while this driver is tristate.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-cadence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 2ee78e0..3b33b8a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -844,6 +844,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 
 	id->irq = platform_get_irq(pdev, 0);
 
+	id->adap.owner = THIS_MODULE;
 	id->adap.dev.of_node = pdev->dev.of_node;
 	id->adap.algo = &cdns_i2c_algo;
 	id->adap.timeout = CDNS_I2C_TIMEOUT;
-- 
1.9.1
