From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Oct 2014 17:24:10 +0200
Subject: [PATCH v2 2/6] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
In-Reply-To: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
References: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1414164254-13053-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Describe the binding for the Marvell MVEBU SATA phy. This driver
can be used at least with Kirkwood, Dove and maybe others.
Additionally, update the SATA binding with the properties to link
to the phy nodes.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
 .../devicetree/bindings/phy/phy-mvebu.txt          | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu.txt

diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
index 1c8351604d38..b460edd12766 100644
--- a/Documentation/devicetree/bindings/ata/marvell.txt
+++ b/Documentation/devicetree/bindings/ata/marvell.txt
@@ -6,11 +6,17 @@ Required Properties:
 - interrupts    : Interrupt controller is using
 - nr-ports      : Number of SATA ports in use.
 
+Optional Properties:
+- phys		: List of phandles to sata phys
+- phy-names	: Should be "0", "1", etc, one number per phandle
+
 Example:
 
 	sata at 80000 {
 		compatible = "marvell,orion-sata";
 		reg = <0x80000 0x5000>;
 		interrupts = <21>;
+		phys = <&sata_phy0>, <&sata_phy1>;
+		phy-names = "0", "1";
 		nr-ports = <2>;
 	}
diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu.txt b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
new file mode 100644
index 000000000000..6cb3364aeafb
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu.txt
@@ -0,0 +1,22 @@
+* Marvell MVEBU SATA PHY
+
+Power control for the SATA phy found on Marvell MVEBU SoCs.
+
+This document extends the binding described in phy-bindings.txt
+
+Required properties :
+
+ - reg		   : Offset and length of the register set for the SATA device
+ - compatible	   : Should be "marvell,mvebu-sata-phy"
+ - clocks	   : phandle of clock and specifier that supplies the device
+ - clock-names	   : Should be "sata"
+
+Example:
+		sata-phy at 84000 {
+			compatible = "marvell,mvebu-sata-phy";
+			reg = <0x84000 0x0334>;
+			clocks = <&gate_clk 15>;
+			clock-names = "sata";
+			#phy-cells = <0>;
+			status = "ok";
+		};
-- 
1.9.1
