From: balbi@ti.com (Felipe Balbi)
Date: Mon,  6 Aug 2012 17:18:54 +0300
Subject: [PATCH 1/4] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Message-ID: <1344262737-6662-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

even if our clocks are disabled, we still
handled the IRQ, so we should return IRQ_HANDLED.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dd2301..f5eafb7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -862,7 +862,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	int err = 0, count = 0;
 
 	if (pm_runtime_suspended(dev->dev))
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 
 	do {
 		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-- 
1.7.12.rc0
