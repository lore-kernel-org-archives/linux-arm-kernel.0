From: carlo.caione@gmail.com (Carlo Caione)
Date: Mon,  6 Jan 2014 18:41:37 +0100
Subject: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the documentation
In-Reply-To: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <1389030097-10822-4-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added documentation for NMI irqchip.

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
 .../allwinner,sun7i-sc-nmi.txt                     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-sc-nmi.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-sc-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-sc-nmi.txt
new file mode 100644
index 0000000..8ba0124
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-sc-nmi.txt
@@ -0,0 +1,25 @@
+Allwinner Sunxi NMI Controller
+==============================
+
+Required properties:
+
+- compatible : should be "allwinner,sun7i-sc-nmi"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+- interrupt-parent: Specifies the parent interrupt controller.
+- interrupts: Specifies the list of interrupt lines which are handled by
+  the interrupt controller in the parent controller's notation. This value
+  shall be the NMI.
+
+Example:
+
+sc-nmi-intc at 01c00030 {
+	compatible = "allwinner,sun7i-sc-nmi";
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	reg = <0x01c00030 0x0c>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 0 1>;
+};
-- 
1.8.5.2
