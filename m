From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 19:24:13 +0300
Subject: [PATCH v2 03/17] i2c: omap: add blank lines
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Message-ID: <1339691067-919-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trivial patch to aid readability. No functional
changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 39d5583..07ae391 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -829,6 +829,7 @@ complete:
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
@@ -841,6 +842,7 @@ complete:
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
+
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
 
@@ -887,6 +889,7 @@ complete:
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
 			continue;
 		}
+
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes = 1;
 			if (dev->fifo_size) {
@@ -934,10 +937,12 @@ complete:
 				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 			continue;
 		}
+
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
 			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
 		}
+
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
-- 
1.7.10.4
