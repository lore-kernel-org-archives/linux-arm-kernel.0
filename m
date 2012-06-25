From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 25 Jun 2012 16:41:39 +0530
Subject: [PATCHv10 4/7] I2C: OMAP: Do not initialise the completion everytime
In-Reply-To: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340622702-21622-5-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use INIT_COMPLETION instead of init_completion in transfer.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c771c28..f1109f4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -493,7 +493,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
 	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
 
-	init_completion(&dev->cmd_complete);
+	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
@@ -1003,6 +1003,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dev);
+	init_completion(&dev->cmd_complete);
 
 	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-- 
1.7.5.4
