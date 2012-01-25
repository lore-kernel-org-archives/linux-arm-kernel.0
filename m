From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:37:32 +0000
Subject: [PATCH 22/33] MFD: ucb1x00-core: add owner and dev initializers to
 gpio structure
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3ye-0000ZF-VH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the gpio device with proper .owner and .dev elements set
appropraitely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 74d9fcf..30ef726 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -579,6 +579,8 @@ static int ucb1x00_probe(struct mcp *mcp)
 	ucb->gpio.base = -1;
 	if (pdata && pdata->gpio_base) {
 		ucb->gpio.label = dev_name(&ucb->dev);
+		ucb->gpio.dev = &ucb->dev;
+		ucb->gpio.owner = THIS_MODULE;
 		ucb->gpio.base = pdata->gpio_base;
 		ucb->gpio.ngpio = 10;
 		ucb->gpio.set = ucb1x00_gpio_set;
-- 
1.7.4.4
