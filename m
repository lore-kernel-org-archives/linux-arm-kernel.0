From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:28 -0700
Subject: [PATCH 3/6] ARM: dts: imx: ventana: use gpio constants
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1410242851-30765-4-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the gpio contants defined in bindings for active high/low

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 23 ++++++++++++-----------
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 14 ++++++++------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 22 ++++++++++++----------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 22 ++++++++++++----------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 22 ++++++++++++----------
 5 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 035f2b1..9687cd8 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -10,6 +10,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "imx6q.dtsi"
 
 / {
@@ -40,20 +41,20 @@
 
 		led0: user1 {
 			label = "user1";
-			gpios = <&gpio4 6 0>; /* 102 -> MX6_PANLEDG */
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 -> MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led1: user2 {
 			label = "user2";
-			gpios = <&gpio4 10 0>; /* 106 -> MX6_PANLEDR */
+			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* 106 -> MX6_PANLEDR */
 			default-state = "off";
 		};
 
 		led2: user3 {
 			label = "user3";
-			gpios = <&gpio4 15 1>; /* 111 -> MX6_LOCLED# */
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* 111 -> MX6_LOCLED# */
 			default-state = "off";
 		};
 	};
@@ -64,7 +65,7 @@
 
 	pps {
 		compatible = "pps-gpio";
-		gpios = <&gpio1 5 0>;
+		gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -106,7 +107,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -134,7 +135,7 @@
 
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
-	cs-gpios = <&gpio3 19 0>;
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
@@ -150,7 +151,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
@@ -331,8 +332,8 @@
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <12 2>; /* gpio7_12 active low */
-		wakeup-gpios = <&gpio7 12 0>;
+		interrupts = <12 2>;
+		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -462,7 +463,7 @@
 };
 
 &pcie {
-	reset-gpio = <&gpio1 29 0>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
@@ -508,7 +509,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 0>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 482ef28..fa2cae4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -9,6 +9,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
@@ -28,14 +30,14 @@
 
 		led0: user1 {
 			label = "user1";
-			gpios = <&gpio4 6 0>; /* 102 -> MX6_PANLEDG */
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led1: user2 {
 			label = "user2";
-			gpios = <&gpio4 7 0>; /* 103 -> MX6_PANLEDR */
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 	};
@@ -46,7 +48,7 @@
 
 	pps {
 		compatible = "pps-gpio";
-		gpios = <&gpio1 26 0>;
+		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -79,7 +81,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -89,7 +91,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -279,7 +281,7 @@
 };
 
 &pcie {
-	reset-gpio = <&gpio1 0 0>;
+	reset-gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index f8c4ab4..53f4a0b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -9,6 +9,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
@@ -37,20 +39,20 @@
 
 		led0: user1 {
 			label = "user1";
-			gpios = <&gpio4 6 0>; /* 102 -> MX6_PANLEDG */
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led1: user2 {
 			label = "user2";
-			gpios = <&gpio4 7 0>; /* 103 -> MX6_PANLEDR */
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
 		led2: user3 {
 			label = "user3";
-			gpios = <&gpio4 15 1>; /* 111 - MX6_LOCLED# */
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
 		};
 	};
@@ -61,7 +63,7 @@
 
 	pps {
 		compatible = "pps-gpio";
-		gpios = <&gpio1 26 0>;
+		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -113,7 +115,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -143,7 +145,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -226,8 +228,8 @@
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <12 2>; /* gpio7_12 active low */
-		wakeup-gpios = <&gpio7 12 0>;
+		interrupts = <12 2>;
+		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -402,7 +404,7 @@
 };
 
 &pcie {
-	reset-gpio = <&gpio1 29 0>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -449,7 +451,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 0>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 01edfd99..2074df6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -9,6 +9,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
@@ -38,20 +40,20 @@
 
 		led0: user1 {
 			label = "user1";
-			gpios = <&gpio4 6 0>; /* 102 -> MX6_PANLEDG */
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led1: user2 {
 			label = "user2";
-			gpios = <&gpio4 7 0>; /* 103 -> MX6_PANLEDR */
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
 		led2: user3 {
 			label = "user3";
-			gpios = <&gpio4 15 1>; /* 111 -> MX6_LOCLED# */
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
 		};
 	};
@@ -62,7 +64,7 @@
 
 	pps {
 		compatible = "pps-gpio";
-		gpios = <&gpio1 26 0>;
+		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -114,7 +116,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -150,7 +152,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -233,8 +235,8 @@
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <11 2>; /* gpio1_11 active low */
-		wakeup-gpios = <&gpio1 11 0>;
+		interrupts = <11 2>;
+		wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -418,7 +420,7 @@
 };
 
 &pcie {
-	reset-gpio = <&gpio1 29 0>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
@@ -470,7 +472,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 0>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index fab9c7a..ab7827a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -9,6 +9,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
@@ -38,20 +40,20 @@
 
 		led0: user1 {
 			label = "user1";
-			gpios = <&gpio4 6 0>; /* 102 -> MX6_PANLEDG */
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led1: user2 {
 			label = "user2";
-			gpios = <&gpio4 7 0>; /* 103 -> MX6_PANLEDR */
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
 		led2: user3 {
 			label = "user3";
-			gpios = <&gpio4 15 1>; /* 111 -> MX6_LOCLED# */
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
 		};
 	};
@@ -62,7 +64,7 @@
 
 	pps {
 		compatible = "pps-gpio";
-		gpios = <&gpio1 26 0>;
+		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -104,7 +106,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -140,7 +142,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -322,8 +324,8 @@
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <12 2>; /* gpio7_12 active low */
-		wakeup-gpios = <&gpio7 12 0>;
+		interrupts = <12 2>;
+		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -501,7 +503,7 @@
 };
 
 &pcie {
-	reset-gpio = <&gpio1 29 0>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
@@ -557,7 +559,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 0>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
-- 
1.8.3.2
