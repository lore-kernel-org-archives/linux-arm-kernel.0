From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 May 2015 16:28:19 -0700
Subject: [PATCH v3 1/5] Documentation: devicetree: add Broadcom SATA binding
In-Reply-To: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1431473303-18873-2-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v3: no change
v2: no change

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
new file mode 100644
index 000000000000..afeede13e195
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -0,0 +1,35 @@
+* Broadcom SATA3 AHCI Controller for STB
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA controller should have its own node.
+
+Required properties:
+- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
+                       "brcm,sata3-ahci"
+- reg                : register mappings for AHCI and SATA_TOP_CTRL
+- reg-names          : "ahci" and "top-ctrl"
+- interrupts         : interrupt mapping for SATA IRQ
+
+Also see ahci-platform.txt.
+
+Example:
+
+	sata at f045a000 {
+		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
+		reg-names = "ahci", "top-ctrl";
+		interrupts = <0 30 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0: sata-port at 0 {
+			reg = <0>;
+			phys = <&sata_phy 0>;
+		};
+
+		sata1: sata-port at 1 {
+			reg = <1>;
+			phys = <&sata_phy 1>;
+		};
+	};
+
-- 
1.9.1
