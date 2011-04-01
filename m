From: nikai@nikai.net (Nicolas Kaiser)
Date: Fri, 1 Apr 2011 23:51:13 +0200
Subject: [PATCH] arm: nomadik: avoid assigning u32 to bool
Message-ID: <20110401235113.083787a7@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid assigning u32 to the bool 'enabled'.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index f49748e..8b722f7 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -636,7 +636,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (type & IRQ_TYPE_LEVEL_LOW)
 		return -EINVAL;
 
-	enabled = nmk_chip->enabled & bitmask;
+	enabled = !!(nmk_chip->enabled & bitmask);
 
 	spin_lock_irqsave(&nmk_chip->lock, flags);
 
-- 
1.7.3.4
