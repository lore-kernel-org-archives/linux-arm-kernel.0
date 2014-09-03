From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  3 Sep 2014 11:07:51 +0200
Subject: [PATCH 5/5] irqchip: atmel-aic: add missing entry for rm9200 irq
 fixups
In-Reply-To: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409735271-15353-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91rm9200 have an RTT block and thus must at91rm9200_aic_irq_fixup
has to be called when intialazing the irqchip.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index a755cfe..02ff229 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -228,6 +228,7 @@ static void __init at91sam9g45_aic_irq_fixup(struct device_node *root)
 }
 
 static const struct of_device_id __initdata aic_irq_fixups[] = {
+	{ .compatible = "atmel,at91rm9200", .data = at91rm9200_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9g45", .data = at91sam9g45_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9n12", .data = at91rm9200_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9rl", .data = at91sam9g45_aic_irq_fixup },
-- 
1.9.1
