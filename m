From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:09:54 -0700
Subject: [PATCH v2 1/9] Documentation: DT: Add Broadcom BCM63138 PMB binding
In-Reply-To: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
References: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830602-10988-2-git-send-email-f.fainelli@gmail.com>
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
index 000000000000..a98872d27872
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
+- #reset-cells: must be 2 first cell is the address within the bus instance designated
+  by the phandle, and the second is the number of zones for this peripheral
+
+Example:
+	pmb0: reset-controller at 4800c0 {
+		compatible = "brcm,bcm63138-pmb";
+		reg = <0x4800c0 0x10>;
+		#reset-cells = <2>;
+	};
-- 
2.1.0
