From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 16 Aug 2012 19:33:50 +0530
Subject: [PATCHv7 19/24] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1345125835-15524-20-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

even if our clocks are disabled, we still
handled the IRQ, so we should return IRQ_HANDLED.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.5.4
