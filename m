From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:04 +0200
Subject: [PATCH 09/29] arm64: dts: renesas: v3hsk: add GEther support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <c0f91cac37df2d6b7f2d6692552a2f16099f7755.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the V3H Starter Kit board dependent part of the GEther device node.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index c9680994555d..bb7e0e5cd57b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &scif0;
+		ethernet0 = &gether;
 	};
 
 	chosen {
@@ -36,7 +37,27 @@
 	clock-frequency = <32768>;
 };
 
+&gether {
+	pinctrl-0 = <&gether_pins>;
+	pinctrl-names = "default";
+
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &pfc {
+	gether_pins: gether {
+		groups = "gether_mdio_a", "gether_rgmii",
+			 "gether_txcrefclk", "gether_txcrefclk_mega";
+		function = "gether";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
-- 
2.11.0
