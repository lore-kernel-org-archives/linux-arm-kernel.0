From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 15:40:57 +0900
Subject: [PATCH] irqchip: renesas-intc-irqpin: Update Documentation of DT
 bindings compat string and example
Message-ID: <1385620857-18994-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the compat strings to provide hardware-specific compat strings
for each variant of the hardware that is supported.

Also provide an example which was previously missing from
the bindings documentation

Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../interrupt-controller/renesas,intc-irqpin.txt   | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
index 1f8b0c5..240ab2a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -2,7 +2,12 @@ DT bindings for the R-/SH-Mobile irqpin controller
 
 Required properties:
 
-- compatible: has to be "renesas,intc-irqpin"
+- compatible: Must be one of the following:
+    "renesas,intc-irqpin"
+    "renesas,intc-irqpin-r8a7740"
+    "renesas,intc-irqpin-r8a7778"
+    "renesas,intc-irqpin-r8a7779"
+    "renesas,intc-irqpin-sh73a0"
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
 
@@ -14,3 +19,25 @@ Optional properties:
   if different from the default 4 bits
 - control-parent: disable and enable interrupts on the parent interrupt
   controller, needed for some broken implementations
+
+Example:
+
+        irqpin0: irqpin at e6900000 {
+                compatible = "renesas,intc-irqpin";
+                #interrupt-cells = <2>;
+                interrupt-controller;
+                reg = <0xe6900000 4>,
+                        <0xe6900010 4>,
+                        <0xe6900020 1>,
+                        <0xe6900040 1>,
+                        <0xe6900060 1>;
+                interrupt-parent = <&gic>;
+                interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH
+                              0 149 IRQ_TYPE_LEVEL_HIGH>;
+        };
-- 
1.8.4
