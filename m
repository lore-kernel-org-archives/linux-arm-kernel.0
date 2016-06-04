From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:56 +0300
Subject: [PATCH 04/22] irqchip: clps711x: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt | 4 ++--
 drivers/irqchip/irq-clps711x.c                                        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
index 759339c..969b458 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
@@ -2,7 +2,7 @@ Cirrus Logic CLPS711X Interrupt Controller
 
 Required properties:
 
-- compatible: Should be "cirrus,clps711x-intc".
+- compatible: Should be "cirrus,ep7209-intc".
 - reg: Specifies base physical address of the registers set.
 - interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: Specifies the number of cells needed to encode an
@@ -34,7 +34,7 @@ ID	Name	Description
 
 Example:
 	intc: interrupt-controller {
-		compatible = "cirrus,clps711x-intc";
+		compatible = "cirrus,ep7312-intc", "cirrus,ep7209-intc";
 		reg = <0x80000000 0x4000>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 2223b3f..f913f4d 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -234,5 +234,5 @@ static int __init clps711x_intc_init_dt(struct device_node *np,
 
 	return _clps711x_intc_init(np, res.start, resource_size(&res));
 }
-IRQCHIP_DECLARE(clps711x, "cirrus,clps711x-intc", clps711x_intc_init_dt);
+IRQCHIP_DECLARE(clps711x, "cirrus,ep7209-intc", clps711x_intc_init_dt);
 #endif
-- 
2.4.9
