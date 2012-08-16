From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 16 Aug 2012 19:33:49 +0530
Subject: [PATCHv7 18/24] i2c: omap: remove redundant status read
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1345125835-15524-19-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the redundant read of the status register.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dfdcc2b..2dd2301 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -946,7 +946,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				num_bytes = dev->buf_len;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
 				goto out;
 
@@ -962,7 +961,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				num_bytes = dev->threshold;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
 				goto out;
 
-- 
1.7.5.4
