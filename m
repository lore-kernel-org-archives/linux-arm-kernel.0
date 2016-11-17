From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:54 +0100
Subject: [PATCH v3 05/19] ARM: dts: armada-370-xp: Fixup mdio DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-6-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MDIO has a reg property so the unit name should contain an address.
Take the opportunity to use the node label instead of the full name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                | 24 +++++++--------
 arch/arm/boot/dts/armada-370-mirabox.dts           | 23 +++++++-------
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 16 +++++-----
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 24 +++++++--------
 arch/arm/boot/dts/armada-370-rd.dts                | 19 ++++++------
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 13 ++++----
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 18 +++++------
 .../dts/armada-370-seagate-personal-cloud.dtsi     | 18 +++++------
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 12 ++++----
 arch/arm/boot/dts/armada-370-xp.dtsi               |  2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          | 20 ++++++------
 arch/arm/boot/dts/armada-xp-db.dts                 | 36 +++++++++++-----------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 36 +++++++++++-----------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    | 20 ++++++------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 21 +++++++------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   | 36 +++++++++++-----------
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 20 ++++++------
 17 files changed, 181 insertions(+), 177 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 033fa63544f7..d26115085ea1 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -86,18 +86,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -260,6 +248,18 @@
 		compatible = "linux,spdif-dir";
 	};
 };
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 
 &spi0 {
 	pinctrl-0 = <&spi0_pins2>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index d5e19cd4d256..3e1ef56b6319 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -113,17 +113,6 @@
 				};
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -197,6 +186,18 @@
 	};
 };
 
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	pwr_led_pin: pwr-led-pin {
 		marvell,pins = "mpp63";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index a9e3810aea65..a6409853db6d 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -99,14 +99,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
-					reg = <0>;
-				};
-			};
-
 			ethernet at 74000 {
 				pinctrl-0 = <&ge1_rgmii_pins>;
 				pinctrl-names = "default";
@@ -260,6 +252,14 @@
 	};
 };
 
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
+		reg = <0>;
+	};
+};
+
 &pinctrl {
 	power_led_pin: power-led-pin {
 		marvell,pins = "mpp57";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 14c379699350..fd5f1d9a434a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -93,18 +93,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -282,6 +270,18 @@
 	};
 };
 
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	poweroff: poweroff {
 		marvell,pins = "mpp60";
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index fbef730e8d37..621add7e12d5 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -102,14 +102,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
@@ -235,7 +227,16 @@
 			};
 		};
 	 };
- };
+};
+
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 
 &pinctrl {
 	fan_pins: fan-pins {
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index ae2e1fe50ef6..82ce5ec6467b 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -36,12 +36,6 @@
 		};
 
 		internal-regs {
-			mdio {
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
-
 			ethernet at 74000 {
 				status = "okay";
 				pinctrl-0 = <&ge1_rgmii_pins>;
@@ -131,3 +125,10 @@
 			  1300 0>;
 	};
 };
+
+&mdio {
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 3036e25c5992..724a47908e3f 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -51,15 +51,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				pinctrl-0 = <&ge0_rgmii_pins>;
@@ -208,6 +199,15 @@
 	};
 };
 
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &pinctrl {
 	pinctrl-0 = <&hdd0_led_sata_pin>, <&hdd1_led_sata_pin>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 01cded310cbc..fb52a34f0a35 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -51,15 +51,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				pinctrl-0 = <&mdio_pins>;
-				pinctrl-names = "default";
-
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-			};
-
 			ethernet at 74000 {
 				status = "okay";
 				pinctrl-0 = <&ge1_rgmii_pins>;
@@ -143,6 +134,15 @@
 	};
 };
 
+&mdio {
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &pinctrl {
 	pinctrl-0 = <&sata_led_pin>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index a9cc42776874..a696bbf0f703 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -127,12 +127,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 			       status = "okay";
 			       phy = <&phy1>;
@@ -220,6 +214,12 @@
 	};
 };
 
+&mdio {
+	phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	disk1_led_pin: disk1-led-pin {
 		marvell,pins = "mpp31";
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 54359896b76c..a4f9684def1c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -259,7 +259,7 @@
 				status = "disabled";
 			};
 
-			mdio: mdio {
+			mdio: mdio at 72004 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index ce152719bc28..7038c8625ac5 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -111,16 +111,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -153,6 +143,16 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	pinctrl-0 = <&phy_int_pin>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 075120bc3ec4..665c81ff98db 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -160,24 +160,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-
-				phy2: ethernet-phy at 2 {
-					reg = <25>;
-				};
-
-				phy3: ethernet-phy at 3 {
-					reg = <27>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
@@ -266,6 +248,24 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+
+	phy2: ethernet-phy at 2 {
+		reg = <25>;
+	};
+
+	phy3: ethernet-phy at 3 {
+		reg = <27>;
+	};
+};
+
 &spi0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 190e4eccb180..09c9cabdf67a 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -175,24 +175,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 {
-					reg = <16>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <17>;
-				};
-
-				phy2: ethernet-phy at 2 {
-					reg = <18>;
-				};
-
-				phy3: ethernet-phy at 3 {
-					reg = <19>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
@@ -251,6 +233,24 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <16>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <17>;
+	};
+
+	phy2: ethernet-phy at 2 {
+		reg = <18>;
+	};
+
+	phy3: ethernet-phy at 3 {
+		reg = <19>;
+	};
+};
+
 &spi0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 8af463f26ea1..0a6a43692620 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -89,16 +89,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -296,6 +286,16 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	poweroff_pin: poweroff-pin {
 		marvell,pins = "mpp24";
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index b6bf5344fbbe..c4685cb86f06 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -153,16 +153,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				pinctrl-0 = <&ge0_rgmii_pins>;
 				pinctrl-names = "default";
@@ -300,6 +290,17 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 { /* Marvell 88E1318 */
+		reg = <1>;
+	};
+};
+
+
 &pinctrl {
 	poweroff: poweroff {
 		marvell,pins = "mpp42";
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index ed3b889d16ce..2e2cd9353761 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -155,24 +155,6 @@
 				};
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 {
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
-
-				phy2: ethernet-phy at 2 {
-					reg = <2>;
-				};
-
-				phy3: ethernet-phy at 3 {
-					reg = <3>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
@@ -240,6 +222,24 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+
+	phy2: ethernet-phy at 2 {
+		reg = <2>;
+	};
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+	};
+};
+
 &pinctrl {
 	led_pins: led-pins-0 {
 		marvell,pins = "mpp49", "mpp51", "mpp53";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index ae286736b90a..189ec7f4667c 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -150,16 +150,6 @@
 				status = "okay";
 			};
 
-			mdio {
-				phy0: ethernet-phy at 0 { /* Marvell 88E1512 */
-					reg = <0>;
-				};
-
-				phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
-					reg = <1>;
-				};
-			};
-
 			ethernet at 70000 {
 				status = "okay";
 				pinctrl-0 = <&ge0_rgmii_pins>;
@@ -240,6 +230,16 @@
 	};
 };
 
+&mdio {
+	phy0: ethernet-phy at 0 { /* Marvell 88E1512 */
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 { /* Marvell 88E1512 */
+		reg = <1>;
+	};
+};
+
 &pinctrl {
 	sata1_pwr_pin: sata1-pwr-pin {
 		marvell,pins = "mpp42";
-- 
2.10.2
