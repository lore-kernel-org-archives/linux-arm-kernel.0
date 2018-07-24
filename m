From: pn@denx.de (Parthiban Nallathambi)
Date: Tue, 24 Jul 2018 17:02:17 +0200
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Actions external
 interrupt controller
In-Reply-To: <20180724150219.1807724-1-pn@denx.de>
References: <20180724150219.1807724-1-pn@denx.de>
Message-ID: <20180724150219.1807724-2-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actions Semi OWL family SoC's provides support for external interrupt
controller to be connected and controlled using SIRQ pins. S500, S700
and S900 provides 3 SIRQ lines and works independently for 3 external
interrupt controllers.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../interrupt-controller/actions,owl-sirq.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
new file mode 100644
index 000000000000..c5f8a29573c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
@@ -0,0 +1,34 @@
+Actions Semi Owl SoCs SIRQ interrupt controller
+
+S500, S700 and S900 SoC's from Actions provides interface, in which external
+interrupt controller can be connected. It has the following properties:
+
+- inputs three interrupt signal from external interrupt controller
+
+Required properties:
+
+- compatible: should be one of the following
+	"actions,s700-sirq"
+	"actions,s900-sirq"
+- reg: physical base address of the controller and length of memory mapped.
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 2.
+- interrupts: specifies the interrupt line in the interrupt controller and
+  interrupt type (level or edge triggered)
+- sampling-rate-24m: this means the external controller's interrupts can be
+  sampled at 24MHz. Sampling can be specified for each SIRQ lines, as an array
+  element. By default, all lines are sampled at 32KHz.
+
+Example:
+
+sirq: interrupt-controller at e01b0000 {
+	compatible = "actions,s700-sirq";
+	reg = <0 0xe01b0000 0 0x1000>;
+	interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	sampling-rate-24m = <0 0 1>;
+};
-- 
2.14.4
