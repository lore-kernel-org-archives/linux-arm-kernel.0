From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 3 Jul 2012 20:07:51 +0530
Subject: [PATCHv4 13/18] i2c: omap: simplify errata check
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1341326276-25434-14-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

omap_i2c_dev is allocated with kzalloc(),
so we need not initialize b_hw to zero.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0fda3b7..7e3502e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1114,9 +1114,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev >= OMAP_I2C_REV_ON_3630_4430)
-			dev->b_hw = 0; /* Disable hardware fixes */
-		else
+		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
-- 
1.7.5.4
