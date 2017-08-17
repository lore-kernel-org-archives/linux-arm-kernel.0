From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 12:11:38 +0200
Subject: [RFC 1/3] dt-bindings: interrupt-controller: Add Realtek RTD1295
In-Reply-To: <20170817101140.32000-1-afaerber@suse.de>
References: <20170817101140.32000-1-afaerber@suse.de>
Message-ID: <20170817101140.32000-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for Realtek RTD1295 IRQ mux.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 .../interrupt-controller/realtek,rtd119x-mux.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
new file mode 100644
index 000000000000..4b43370e3d74
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
@@ -0,0 +1,28 @@
+Realtek RTD119x/129x IRQ Mux Controller
+=======================================
+
+Required properties:
+
+- compatible           :  Should be one of the following:
+                          - "realtek,rtd1295-irq-mux"
+                          - "realtek,rtd1295-iso-irq-mux"
+- reg                  :  Specifies base physical address and size of the registers.
+- interrupts           :  Specifies the interrupt line which is mux'ed.
+- interrupt-controller :  Presence indicates the node as interrupt controller.
+- #interrupt-cells     :  Shall be 1. See common bindings in interrupt.txt.
+
+
+Optional properties:
+
+See interrupt.txt for common bindings.
+
+
+Example:
+
+	interrupt-controller at 98007000 {
+		compatible = "realtek,rtd1295-iso-irq-mux";
+		reg = <0x98007000 0x100>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
-- 
2.12.3
