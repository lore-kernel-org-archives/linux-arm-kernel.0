From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 15:40:47 +0900
Subject: [PATCH] irqchip: renesas-intc: Document DT bindings
Message-ID: <1385620847-18919-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../interrupt-controller/renesas,intc-irqc.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt
new file mode 100644
index 0000000..305d4e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqc.txt
@@ -0,0 +1,30 @@
+DT bindings for the R-/SH-Mobile INTC controller
+
+Required properties:
+
+- compatible: Must be one of the following:
+    "renesas,intc"
+    "renesas,intc-r8a73a4"
+    "renesas,intc-r8a7790"
+    "renesas,intc-r8a7791"
+- #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
+  interrupts.txt in this directory
+
+Optional properties:
+
+- any properties, listed in interrupts.txt, and any standard resource allocation
+  properties
+
+Example:
+
+        irqc0: interrupt-controller at e61c0000 {
+                compatible = "renesas,irqc-r8a7790", "renesas,irqc";
+                #interrupt-cells = <2>;
+                interrupt-controller;
+                reg = <0 0xe61c0000 0 0x200>;
+                interrupt-parent = <&gic>;
+                interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+                             <0 1 IRQ_TYPE_LEVEL_HIGH>,
+                             <0 2 IRQ_TYPE_LEVEL_HIGH>,
+                             <0 3 IRQ_TYPE_LEVEL_HIGH>;
+        };
-- 
1.8.4
