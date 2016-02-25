From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 25 Feb 2016 23:04:47 +0100
Subject: [PATCH 2/2] devicetree: document NXP LPC1850 PINT irq controller
 binding
In-Reply-To: <1456437887-24432-1-git-send-email-manabian@gmail.com>
References: <1456437887-24432-1-git-send-email-manabian@gmail.com>
Message-ID: <1456437887-24432-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for NXP LPC1850 GPIO Pin Interrupt (PINT)
controller.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../interrupt-controller/nxp,lpc1850-gpio-pint.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc1850-gpio-pint.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc1850-gpio-pint.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc1850-gpio-pint.txt
new file mode 100644
index 000000000000..dc43f187ebda
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc1850-gpio-pint.txt
@@ -0,0 +1,22 @@
+NXP LPC18xx/43xx GPIO Pin Interrupt (PINT) controller
+
+Required properties:
+
+- compatible : should be "nxp,lpc1850-gpio-pint".
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+- interrupts : Specifies the CPU interrupts the controller is connected to.
+- clocks: Must contain a reference to the functional clock.
+
+Example:
+
+pint: interrupt-controller at 40087000 {
+	compatible = "nxp,lpc1850-gpio-pint";
+	reg = <0x40087000 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	interrupts = <32 33 34 35 36 37 38 39>;
+	clocks = <&ccu1 CLK_CPU_GPIO>;
+};
-- 
1.8.0
