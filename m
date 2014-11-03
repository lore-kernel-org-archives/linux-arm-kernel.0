From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  3 Nov 2014 09:31:03 +0100
Subject: [PATCH v2 4/5] irqchip: atmel-aic: rename at91sam9_aic_irq_fixup for
 naming consistency
In-Reply-To: <1415003464-29239-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415003464-29239-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415003464-29239-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Rename at91sam9_aic_irq_fixup into at91rm9200_aic_irq_fixup to be
consistent with other fixup functions.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index d7b0495..6f011b4 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -209,7 +209,7 @@ static const struct irq_domain_ops aic_irq_ops = {
 	.xlate	= aic_irq_domain_xlate,
 };
 
-static void __init at91sam9_aic_irq_fixup(struct device_node *root)
+static void __init at91rm9200_aic_irq_fixup(struct device_node *root)
 {
 	aic_common_rtc_irq_fixup(root);
 }
@@ -227,9 +227,9 @@ static void __init at91sam9g45_aic_irq_fixup(struct device_node *root)
 
 static const struct of_device_id __initdata aic_irq_fixups[] = {
 	{ .compatible = "atmel,at91sam9g45", .data = at91sam9g45_aic_irq_fixup },
-	{ .compatible = "atmel,at91sam9n12", .data = at91sam9_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9n12", .data = at91rm9200_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9rl", .data = at91sam9g45_aic_irq_fixup },
-	{ .compatible = "atmel,at91sam9x5", .data = at91sam9_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9x5", .data = at91rm9200_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9260", .data = at91sam9260_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9261", .data = at91sam9260_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9263", .data = at91sam9260_aic_irq_fixup },
-- 
1.9.1
