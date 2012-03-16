From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 16 Mar 2012 19:35:53 +0530
Subject: [PATCH v4 05/12] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331906760-5259-6-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
framework) removed retrigger support in favor of using generic IRQ
framework.  This patch cleans up some unused remnants of that removal.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3b91ade..47143b7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -627,7 +627,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 isr;
 	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
-	u32 retrigger = 0;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -664,8 +663,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			chained_irq_exit(chip, desc);
 		}
 
-		isr |= retrigger;
-		retrigger = 0;
 		if (!isr)
 			break;
 
-- 
1.7.0.4
