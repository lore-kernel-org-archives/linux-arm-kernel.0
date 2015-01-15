From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 15 Jan 2015 12:33:59 +0200
Subject: [PATCH v3 1/2] irqchip: devicetree: document Conexant Digicolor irq
 binding
In-Reply-To: <cover.1421317616.git.baruch@tkos.co.il>
References: <cover.1421317616.git.baruch@tkos.co.il>
Message-ID: <505a65c8861e5210d94227bc0eec89cab0593fca.1421317616.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../bindings/interrupt-controller/digicolor-ic.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
new file mode 100644
index 000000000000..c25c9a4de615
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
@@ -0,0 +1,22 @@
+Conexant Digicolor Interrupt Controller
+
+Required properties:
+
+- compatible : should be "cnxt,cx92755-ic"
+- reg : Specifies base physical address and size of the interrupt controller
+  registers (IC) area
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- syscon: A phandle to the syscon node describing UC registers
+
+Example:
+
+	intc: interrupt-controller at f0000040 {
+		compatible = "cnxt,cx92755-ic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xf0000040 0x40>;
+		syscon = <&uc_regs>;
+	};
+
-- 
2.1.4
