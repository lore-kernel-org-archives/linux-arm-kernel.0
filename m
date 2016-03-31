From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 31 Mar 2016 17:09:31 +0200
Subject: [PATCH v2 1/9] Documentation: dt-bindings: Document STM32 EXTI
 controller bindings
In-Reply-To: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1459436979-17275-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../bindings/interrupt-controller/st,stm32-exti.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
new file mode 100644
index 000000000000..6e7703d4ff5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -0,0 +1,20 @@
+STM32 External Interrupt Controller
+
+Required properties:
+
+- compatible: Should be "st,stm32-exti"
+- reg: Specifies base physical address and size of the registers
+- interrupt-controller: Indentifies the node as an interrupt controller
+- #interrupt-cells: Specifies the number of cells to encode an interrupt
+  specifier, shall be 2
+- interrupts: interrupts references to primary interrupt controller
+
+Example:
+
+exti: interrupt-controller at 40013c00 {
+	compatible = "st,stm32-exti";
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	reg = <0x40013C00 0x400>;
+	interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
+};
-- 
1.9.1
