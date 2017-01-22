From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:16:09 +0100
Subject: [PATCH 02/22] irqchip: DT bindings for Cortina Gemini irqchip
Message-ID: <20170122121609.10098-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Cortina Gemini interrupt
controller. They are pretty standard.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
irqchip maintainers: please just apply this when you feel pleased
with it. These portions are functionally orthogonal to the series,
it is just in a series for context.
---
 .../cortina,gemini-interrupt-controller.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt
new file mode 100644
index 000000000000..97c1167fa533
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt
@@ -0,0 +1,22 @@
+* Cortina Systems Gemini interrupt controller
+
+This interrupt controller is found on the Gemini SoCs.
+
+Required properties:
+- compatible: must be "cortina,gemini-interrupt-controller"
+- reg: The register bank for the interrupt controller.
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: The number of cells to define the interrupts.
+  Must be 2 as the controller can specify level or rising edge
+  IRQs. The bindings follows the standard binding for controllers
+  with two cells specified in
+  interrupt-controller/interrupts.txt
+
+Example:
+
+interrupt-controller at 48000000 {
+	compatible = "cortina,gemini-interrupt-controller";
+	reg = <0x48000000 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.9.3
