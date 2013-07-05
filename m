From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 05 Jul 2013 15:39:11 +0800
Subject: [PATCH] irqchip: nvic: Fix wrong num_ct argument for
 irq_alloc_domain_generic_chips()
Message-ID: <1373009951.14756.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third parameter of irq_alloc_domain_generic_chips() is the number of
irq_chip_type instances associated with these chips rather than numbanks.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/irqchip/irq-nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 8d0c8b3..70bdf6e 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -84,7 +84,7 @@ static int __init nvic_of_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	ret = irq_alloc_domain_generic_chips(nvic_irq_domain, 32, numbanks,
+	ret = irq_alloc_domain_generic_chips(nvic_irq_domain, 32, 1,
 					     "nvic_irq", handle_fasteoi_irq,
 					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
-- 
1.8.1.2
