From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:27 +0100
Subject: [PATCH v2 13/18] arm64: dts: allwinner: a64: Olinuxino: add Ethernet
 nodes
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-14-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes required to enable the Gigabit Ethernet on the board.
The PHY is powered by the always-on power rail VDD_SYS_3.3V (DCDC1).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index b3f186434f36..26075b9a76e3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -51,6 +51,7 @@
 	compatible = "olimex,a64-olinuxino", "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -64,6 +65,22 @@
 	};
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.14.4
