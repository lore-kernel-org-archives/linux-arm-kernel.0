From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Apr 2015 15:33:46 -0700
Subject: [PATCH 1/7] Documentation: DT: Add Broadcom BCM63138 PMB binding
In-Reply-To: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429310032-19402-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Device Tree binding for the Broadcom BCM63138 Processor Monitor
Bus, which is an internal bus used to access different power and reset
signals within a BCM63138 System-on-a-Chip.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/reset/brcm,bcm63138-pmb.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt b/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
new file mode 100644
index 000000000000..aa1eecd23046
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
@@ -0,0 +1,19 @@
+Broadcom BCM63138 Processor Monitor Bus binding
+===============================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Require properties:
+
+- compatible: must be "brcm,bcm63138-pmb"
+- reg: base register address and size for this bus controller
+- #reset-cells: must be 2 first cell is the internal bus number, and the third
+  cell is the address on this bus
+
+Example:
+	pmb0: reset-controller at 4800c0 {
+		compatible = "brcm,bcm63138-pmb";
+		reg = <0x4800c0 0x10>;
+		#reset-cells = <2>;
+	};
-- 
2.1.0
