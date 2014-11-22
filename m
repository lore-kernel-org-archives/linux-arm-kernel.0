From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 22 Nov 2014 17:23:30 +0100
Subject: [PATCHv0 2/2] arm: mvebu: normalize pinctrl entries for Armada SoCs
In-Reply-To: <cover.1416670812.git.arno@natisbad.org>
References: <cover.1416670812.git.arno@natisbad.org>
Message-ID: <00114c3169e1d93259ff4150ed46ee36eae16b1e.1416670812.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


There are currently 2 differents naming conventions used between the
existing Armada SoC DT files for pinctrl entries (*_pin(s): *-pin(s)
and pmx_*: pmx-*) with a vast majority of files using the former:

$ grep _pin arch/arm/boot/dts/armada-*.dts* | wc -l
155
$ grep pmx arch/arm/boot/dts/armada-*.dts* | wc -l
13

In fact, only some Armada XP files are using the second variant.
This patch normalizes those files (mainly ge0/1 entries) to use
the first variant.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts       | 12 ++++++------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |  4 ++--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  |  4 ++--
 arch/arm/boot/dts/armada-xp.dtsi                |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index c9d25bdbe795..ba7ef9a2a904 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -84,14 +84,14 @@
 			};
 
 			ethernet at 70000 {
-				pinctrl-0 = <&pmx_ge0_rgmii>;
+				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy0>;
 				phy-mode = "rgmii-id";
 			};
 			ethernet at 74000 {
-				pinctrl-0 = <&pmx_ge1_rgmii>;
+				pinctrl-0 = <&ge1_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy1>;
@@ -116,7 +116,7 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		pinctrl-0 = <&pmx_keys>;
+		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
 		button at 1 {
@@ -128,15 +128,15 @@
 };
 
 &pinctrl {
-	pinctrl-0 = <&pmx_phy_int>;
+	pinctrl-0 = <&phy_int_pin>;
 	pinctrl-names = "default";
 
-	pmx_keys: pmx-keys {
+	keys_pin: keys-pin {
 		marvell,pins = "mpp33";
 		marvell,function = "gpio";
 	};
 
-	pmx_phy_int: pmx-phy-int {
+	phy_int_pin: phy-int-pin {
 		marvell,pins = "mpp32";
 		marvell,function = "gpio";
 	};
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 088d8d2fe9eb..a2ef93c1eb10 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -66,7 +66,7 @@
 			};
 
 			ethernet at 70000 {
-				pinctrl-0 = <&pmx_ge0_rgmii>;
+				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy0>;
@@ -74,7 +74,7 @@
 			};
 
 			ethernet at 74000 {
-				pinctrl-0 = <&pmx_ge1_rgmii>;
+				pinctrl-0 = <&ge1_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy1>;
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 97cbf980c54d..749fdba5a642 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -184,14 +184,14 @@
 
 			ethernet at 70000 {
 				status = "okay";
-				pinctrl-0 = <&pmx_ge0_rgmii>;
+				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
 				phy = <&phy1>;
 				phy-mode = "rgmii-id";
 			};
 
 			ethernet at 74000 {
-				pinctrl-0 = <&pmx_ge1_rgmii>;
+				pinctrl-0 = <&ge1_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
 				phy = <&phy0>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bdb36a05c039..a2a6451524dc 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -212,7 +212,7 @@
 };
 
 &pinctrl {
-	pmx_ge0_gmii: pmx-ge0-gmii {
+	ge0_gmii_pins: ge0-gmii-pins {
 		marvell,pins =
 		     "mpp0",  "mpp1",  "mpp2",  "mpp3",
 		     "mpp4",  "mpp5",  "mpp6",  "mpp7",
@@ -223,7 +223,7 @@
 		marvell,function = "ge0";
 	};
 
-	pmx_ge0_rgmii: pmx-ge0-rgmii {
+	ge0_rgmii_pins: ge0-rgmii-pins {
 		marvell,pins =
 		     "mpp0", "mpp1", "mpp2", "mpp3",
 		     "mpp4", "mpp5", "mpp6", "mpp7",
@@ -231,7 +231,7 @@
 		marvell,function = "ge0";
 	};
 
-	pmx_ge1_rgmii: pmx-ge1-rgmii {
+	ge1_rgmii_pins: ge1-rgmii-pins {
 		marvell,pins =
 		     "mpp12", "mpp13", "mpp14", "mpp15",
 		     "mpp16", "mpp17", "mpp18", "mpp19",
-- 
2.1.1
