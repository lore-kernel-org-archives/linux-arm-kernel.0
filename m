From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 21:50:25 +0100
Subject: [PATCH v2 1/2] irqchip: sunxi: Change compatibles
In-Reply-To: <1391806226-27480-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391806226-27480-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391806226-27480-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Change the compatibles
to match the other pattern in the irq controller driver for consistency.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 ++--
 drivers/irqchip/irq-sun4i.c                                           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index 32cec4b..b290ca1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,7 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-ic"
+- compatible : should be "allwinner,sun4i-a10-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
@@ -11,7 +11,7 @@ Required properties:
 Example:
 
 intc: interrupt-controller {
-	compatible = "allwinner,sun4i-ic";
+	compatible = "allwinner,sun4i-a10-ic";
 	reg = <0x01c20400 0x400>;
 	interrupt-controller;
 	#interrupt-cells = <1>;
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index a5438d8..69e4e2d 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -134,7 +134,7 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-ic", sun4i_of_init);
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
 
 static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
1.8.4.2
