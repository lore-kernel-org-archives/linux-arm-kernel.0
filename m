From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 8 Oct 2012 14:35:15 +0530
Subject: [PATCH 2/3] i2c: omap: Remove the redundant fifo clear
In-Reply-To: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1349687116-14463-2-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap_i2c_resize_fifo already takes care of the fifo clearing so,
remove the (re)clearing of the fifo.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ce41596..db0b272 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -524,11 +524,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
 
-	/* Clear the FIFO Buffers */
-	w = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
-	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
-	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
-
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
 
-- 
1.7.5.4
