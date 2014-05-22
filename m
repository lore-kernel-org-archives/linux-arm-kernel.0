From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 May 2014 09:36:46 -0700
Subject: [PATCH v2 2/2] Documentation: add Broadcom STB Level-2 interrupt
 controller binding
In-Reply-To: <1400776606-22427-1-git-send-email-f.fainelli@gmail.com>
References: <1400776606-22427-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1400776606-22427-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Device Tree binding document for the Broadcom
Set-top-box Level 2 interrupt controller hardware.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- respin

 .../bindings/interrupt-controller/brcm,l2-intc.txt | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
new file mode 100644
index 000000000000..448273a30a11
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
@@ -0,0 +1,29 @@
+Broadcom Generic Level 2 Interrupt Controller
+
+Required properties:
+
+- compatible: should be "brcm,l2-intc"
+- reg: specifies the base physical address and size of the registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an
+  interrupt source. Should be 1.
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+  this controller is cacaded from
+- interrupts: specifies the interrupt line in the interrupt-parent irq space
+  to be used for cascading
+
+Optional properties:
+
+- brcm,irq-can-wake: If present, this means the L2 controller can be used as a
+  wakeup source for system suspend/resume.
+
+Example:
+
+hif_intr2_intc: interrupt-controller at f0441000 {
+	compatible = "brcm,l2-intc";
+	reg = <0xf0441000 0x30>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	interrupt-parent = <&intc>;
+	interrupts = <0x0 0x20 0x0>;
+};
-- 
1.9.1
