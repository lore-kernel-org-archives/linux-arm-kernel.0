From: antony@phenome.org (Antony Antony)
Date: Wed, 29 Nov 2017 15:17:16 +0100
Subject: [PATCH] arm64: dts: allwinner: h5: NanoPi NEO Plus2 : add EMAC support
Message-ID: <20171129141716.98951-1-antony@phenome.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add arm64 H5 dwmac-sun8i support for this board

Signed-off-by: Antony Antony <antony@phenome.org>
---
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 7c028af..01dace4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -53,6 +53,7 @@
 	compatible = "friendlyarm,nanopi-neo-plus2", "allwinner,sun50i-h5";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -133,6 +134,22 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy at 7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.7.4
