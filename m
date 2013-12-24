From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:01 +0900
Subject: [PATCH 2/3] irqchip: renesas-irqc: Enable mask on suspend
In-Reply-To: <cover.1387855444.git.horms+renesas@verge.net.au>
References: <cover.1387855444.git.horms+renesas@verge.net.au>
Message-ID: <6a7e3b3007b5396a9e812ca0ceddc7915f8768dd.1387855444.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when lazy interrupt disable has been enabled in the driver
then extend the code to set IRQCHIP_MASK_ON_SUSPEND which tells
the core that only IRQs marked as wakeups need to stay enabled
during Suspend-to-RAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 8fdd7d6..082d95c 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -213,7 +213,7 @@ static int irqc_probe(struct platform_device *pdev)
 	irq_chip->irq_mask = irqc_irq_disable;
 	irq_chip->irq_unmask = irqc_irq_enable;
 	irq_chip->irq_set_type = irqc_irq_set_type;
-	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
+	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      p->number_of_irqs,
-- 
1.8.4
