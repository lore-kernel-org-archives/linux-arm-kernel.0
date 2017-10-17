From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Oct 2017 14:47:03 +0200
Subject: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Realtek RTD1295
In-Reply-To: <20171017124708.6242-1-afaerber@suse.de>
References: <20171017124708.6242-1-afaerber@suse.de>
Message-ID: <20171017124708.6242-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for Realtek RTD1295 IRQ mux.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Renamed non-iso irq mux to "misc" for clarity

 v1 -> v2:
 * Dropped reference to common interrupt.txt bindings (Rob)
 
 .../interrupt-controller/realtek,rtd119x-mux.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
new file mode 100644
index 000000000000..f39ce341adbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
@@ -0,0 +1,23 @@
+Realtek RTD119x/129x IRQ Mux Controller
+=======================================
+
+Required properties:
+
+- compatible           :  Should be one of the following:
+                          - "realtek,rtd1295-misc-irq-mux"
+                          - "realtek,rtd1295-iso-irq-mux"
+- reg                  :  Specifies base physical address and size of the registers.
+- interrupts           :  Specifies the interrupt line which is mux'ed.
+- interrupt-controller :  Presence indicates the node as interrupt controller.
+- #interrupt-cells     :  Shall be 1. See common bindings in interrupt.txt.
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
2.13.6
