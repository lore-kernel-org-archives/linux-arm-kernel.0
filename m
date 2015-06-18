From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 15:07:35 +0200
Subject: [PATCH] irqchip: atmel-aic5: Add sama5d2 support
Message-ID: <1434632855-27272-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sama5d2 support to irq-atmel-aic5.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/interrupt-controller/atmel,aic.txt       | 2 +-
 drivers/irqchip/irq-atmel-aic5.c                                 | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index f292917fa00d..0e9f09a6a2fe 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -2,7 +2,7 @@
 
 Required properties:
 - compatible: Should be "atmel,<chip>-aic"
-  <chip> can be "at91rm9200", "sama5d3" or "sama5d4"
+  <chip> can be "at91rm9200", "sama5d2", "sama5d3" or "sama5d4"
 - interrupt-controller: Identifies the node as an interrupt controller.
 - interrupt-parent: For single AIC system, it is an empty property.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index a2e8c3f876cb..459bf4429d36 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -339,6 +339,15 @@ static int __init aic5_of_init(struct device_node *node,
 	return 0;
 }
 
+#define NR_SAMA5D2_IRQS		77
+
+static int __init sama5d2_aic5_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAMA5D2_IRQS);
+}
+IRQCHIP_DECLARE(sama5d2_aic5, "atmel,sama5d2-aic", sama5d2_aic5_of_init);
+
 #define NR_SAMA5D3_IRQS		48
 
 static int __init sama5d3_aic5_of_init(struct device_node *node,
-- 
2.1.3
