From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 14 Aug 2012 19:49:00 +0530
Subject: [PATCHv6 18/24] i2c: omap: remove redundant status read
In-Reply-To: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
References: <1344953946-13005-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1344953946-13005-19-git-send-email-shubhrajyoti@ti.com>
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
