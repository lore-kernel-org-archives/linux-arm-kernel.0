From: carlo@caione.org (Carlo Caione)
Date: Wed,  5 Mar 2014 20:45:31 +0100
Subject: [PATCH v5 3/3] ARM: sun7i/sun6i: irqchip: Update the documentation
In-Reply-To: <1394048731-4570-1-git-send-email-carlo@caione.org>
References: <1394048731-4570-1-git-send-email-carlo@caione.org>
Message-ID: <1394048731-4570-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added documentation for NMI irqchip.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../allwinner,sun67i-sc-nmi.txt                    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
new file mode 100644
index 0000000..d1c5cda
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
@@ -0,0 +1,27 @@
+Allwinner Sunxi NMI Controller
+==============================
+
+Required properties:
+
+- compatible : should be "allwinner,sun7i-a20-sc-nmi" or
+  "allwinner,sun6i-a31-sc-nmi"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2. The first cell is the IRQ number, the
+  second cell the trigger type as defined in interrupt.txt in this directory.
+- interrupt-parent: Specifies the parent interrupt controller.
+- interrupts: Specifies the interrupt line (NMI) which is handled by
+  the interrupt controller in the parent controller's notation. This value
+  shall be the NMI.
+
+Example:
+
+sc-nmi-intc at 01c00030 {
+	compatible = "allwinner,sun7i-a20-sc-nmi";
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	reg = <0x01c00030 0x0c>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 0 4>;
+};
-- 
1.8.3.2
