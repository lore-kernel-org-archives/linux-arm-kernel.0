From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Nov 2017 23:02:21 +0300
Subject: [PATCH 3/3] arm64: dts: renesas: eagle: add EtherAVB pins
Message-ID: <20171110200714.406365231@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) EtherAVB pin data to the Eagle board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
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
 	status = "okay";
@@ -53,6 +56,11 @@
 };
 
 &pfc {
+	avb_pins: avb {
+		groups = "avb0_mdio", "avb0_mii";
+		function = "avb0";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
