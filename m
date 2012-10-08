From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 8 Oct 2012 14:35:16 +0530
Subject: [PATCH 3/3] i2c: omap: Remove Address as slave wakeup
In-Reply-To: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1349687116-14463-3-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slave support is not there in the current i2c.
Lets remove the Address as slave wakeup from the Wakeup enable
register.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db0b272..c7b0a2c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -128,6 +128,11 @@ enum {
 				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
 				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
 
+#define OMAP_I2C_WE_ENABLED	(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
+				OMAP_I2C_WE_BF_WE | \
+				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
+				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
+				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
 #define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
@@ -326,7 +331,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
-			dev->westate = OMAP_I2C_WE_ALL;
+			dev->westate = OMAP_I2C_WE_ENABLED;
 			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
 							dev->westate);
 		}
-- 
1.7.5.4
