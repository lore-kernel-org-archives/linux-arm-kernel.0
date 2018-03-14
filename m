From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 14 Mar 2018 22:58:33 +0300
Subject: [PATCH v2] arm64: dts: renesas: eagle: add EtherAVB pins
Message-ID: <382aeecb-c484-ec27-1ef1-8da1673c2c14@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) EtherAVB pin data to the Eagle board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
pin groups (posted yesterday) in order to work properly...

Changes in version 2:
- updated the pin groups according to the recent PFC driver patch;
- updated due to  the patch reordering.

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -34,6 +34,9 @@
 };
 
 &avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
 	renesas,no-ether-link;
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
@@ -71,6 +74,11 @@
 };
 
 &pfc {
+	avb_pins: avb0 {
+		groups = "avb0_mdio", "avb0_rgmii", "avb0_txcrefclk";
+		function = "avb0";
+	};
+
 	i2c0_pins: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
