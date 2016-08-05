From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 Aug 2016 16:55:18 +0200
Subject: [PATCH 1/4] dt-bindings: interrupt-controller: add DT binding for
 Marvell 7K/8K PIC
In-Reply-To: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1470408921-447-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding description for the PIC
interrupt controller available in the ARM64 Marvell Armada 7K/8K SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../interrupt-controller/marvell,armada-8k-pic.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt
new file mode 100644
index 0000000..86a7b4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt
@@ -0,0 +1,25 @@
+Marvell Armada 7K/8K PIC Interrupt controller
+---------------------------------------------
+
+This is the Device Tree binding for the PIC, a secondary interrupt
+controller available on the Marvell Armada 7K/8K ARM64 SoCs, and
+typically connected to the GIC as the primary interrupt controller.
+
+Required properties:
+- compatible: should be "marvell,armada-8k-pic"
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: the number of cells to define interrupts on this
+  controller. Should be 1
+- reg: the register area for the PIC interrupt controller
+- interrupts: the interrupt to the primary interrupt controller,
+  typically the GIC
+
+Example:
+
+	pic: interrupt-controller at 3f0100 {
+		compatible = "marvell,armada-8k-pic";
+		reg = <0x3f0100 0x10>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.7.4
