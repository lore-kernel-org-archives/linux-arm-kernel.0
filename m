From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Mar 2015 18:23:39 -0700
Subject: [PATCH 2/5] Documentation: devicetree: add Broadcom SATA PHY binding
In-Reply-To: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1426728222-8197-2-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 28nm STB chips, based on BCM7445.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
new file mode 100644
index 000000000000..39eddd53b318
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
@@ -0,0 +1,40 @@
+* Broadcom SATA3 PHY for STB
+
+Required properties:
+- compatible: should be one or more of
+     "brcm,bcm7445-sata-phy"
+     "brcm,phy-sata3"
+- address-cells: should be 1
+- size-cells: should be 0
+- phy-cells: generic PHY binding; must be 1
+- reg: register ranges for the PHY PCB interface, and for the PHY port control
+     registers found in the SATA_TOP_CTRL block (i.e., PHY_CTRL 1/2/3/4)
+- reg-names: should be "phy" and "port-ctrl"
+
+Sub-nodes:
+  Each port's PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- reg: the PHY number
+Optional:
+- brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
+
+
+Example:
+
+	sata-phy at f0458100 {
+		compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+		reg = <0xf0458100 0x1e00>, <0xf045804c 0x10>;
+		reg-names = "phy", "port-ctrl";
+		#phy-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata-phy at 0 {
+			reg = <0>;
+		};
+
+		sata-phy at 1 {
+			reg = <1>;
+		};
+	};
-- 
1.9.1
