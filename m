From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:59:55 +0100
Subject: [PATCH 2/6] ARM: sunxi: DT: convert DTs to use common GPIOs includes
In-Reply-To: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1418767199-20957-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the various raw GPIO flags by their definition in the common
dt-bindings header.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 10 ++++++----
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  6 ++++--
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  8 +++++---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  8 +++++---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  4 +++-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  4 +++-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  8 +++++---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  4 +++-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 10 ++++++----
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    |  8 +++++---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 +++-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  8 +++++---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  8 +++++---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  4 +++-
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  6 ++++--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  8 +++++---
 arch/arm/boot/dts/sun6i-a31-m9.dts               |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 18 ++++++++++--------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      | 14 ++++++++------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        | 14 ++++++++------
 arch/arm/boot/dts/sun7i-a20-m3.dts               |  6 ++++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  8 +++++---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         |  4 ++--
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  4 +++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts          |  6 ++++--
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   | 10 ++++++----
 30 files changed, 145 insertions(+), 87 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 3bb636978582..532ab3bd9735 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -51,6 +51,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Mele A1000";
 	compatible = "mele,a1000", "allwinner,sun4i-a10";
@@ -77,7 +79,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -159,12 +161,12 @@
 
 		red {
 			label = "a1000:red:usr";
-			gpios = <&pio 7 10 0>;
+			gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>;
 		};
 
 		blue {
 			label = "a1000:blue:usr";
-			gpios = <&pio 7 20 0>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -176,7 +178,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pio 7 15 0>;
+		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_usb1_vbus: usb1-vbus {
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index b2b45c4f7915..490b77c9bb36 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -49,6 +49,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "BA10 tvbox";
 	compatible = "allwinner,ba10-tvbox", "allwinner,sun4i-a10";
@@ -74,7 +76,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -140,7 +142,7 @@
 	};
 
 	reg_usb2_vbus: usb2-vbus {
-		gpio = <&pio 7 12 0>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index c5691a8666c5..abc3c06677d2 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -50,6 +50,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Cubietech Cubieboard";
 	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
@@ -75,7 +77,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -157,12 +159,12 @@
 
 		blue {
 			label = "cubieboard:blue:usr";
-			gpios = <&pio 7 21 0>; /* LED1 */
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* LED1 */
 		};
 
 		green {
 			label = "cubieboard:green:usr";
-			gpios = <&pio 7 20 0>; /* LED2 */
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* LED2 */
 			linux,default-trigger = "heartbeat";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 0c6c81a6b61b..be1f29e50811 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -51,6 +51,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Miniand Hackberry";
 	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
@@ -77,7 +79,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -157,7 +159,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pio 7 19 0>;
+		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_usb1_vbus: usb1-vbus {
@@ -166,7 +168,7 @@
 
 	reg_usb2_vbus: usb2-vbus {
 		pinctrl-0 = <&usb2_vbus_pin_hackberry>;
-		gpio = <&pio 7 12 0>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 5980ad0e69e3..482914333bba 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -51,6 +51,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "INet-97F Rev 02";
 	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
@@ -65,7 +67,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index e55639988e5d..1db02eb3796c 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -51,6 +51,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "PineRiver Mini X-Plus";
 	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
@@ -61,7 +63,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 3f607946abad..5d9b86839f16 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -49,6 +49,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A10-OLinuXino-LIME";
 	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
@@ -74,7 +76,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -151,14 +153,14 @@
 
 		green {
 			label = "a10-olinuxino-lime:green:usr";
-			gpios = <&pio 7 2 0>;
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_ahci_5v: ahci-5v {
 		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
-		gpio = <&pio 2 3 0>;
+		gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 7367eff79dea..48161adfb32c 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -50,6 +50,8 @@
 #include "sun4i-a10.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "LinkSprite pcDuino";
 	compatible = "linksprite,a10-pcduino", "allwinner,sun4i-a10";
@@ -75,7 +77,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 29a47dd4bad5..ab9b6c24efeb 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -51,6 +51,8 @@
 #include "sun5i-a10s.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A10s-Olinuxino Micro";
 	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
@@ -76,7 +78,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 1 0>; /* PG1 */
+			cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -86,7 +88,7 @@
 			pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 13 0>; /* PG13 */
+			cd-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -185,14 +187,14 @@
 
 		green {
 			label = "a10s-olinuxino-micro:green:usr";
-			gpios = <&pio 4 3 0>;
+			gpios = <&pio 4 3 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
-		gpio = <&pio 1 10 0>;
+		gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 3a0d9dc39914..da2d2535b1bc 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -49,6 +49,8 @@
 #include "sun5i-a10s.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "R7 A10s hdmi tv-stick";
 	compatible = "allwinner,r7-tv-dongle", "allwinner,sun5i-a10s";
@@ -59,7 +61,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 1 0>; /* PG1 */
+			cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -123,14 +125,14 @@
 
 		green {
 			label = "r7-tv-dongle:green:usr";
-			gpios = <&pio 1 2 0>;
+			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_r7>;
-		gpio = <&pio 6 13 0>;
+		gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index ca6b6dd30e47..bccc1bcaa868 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -49,6 +49,8 @@
 #include "sun5i-a13.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "HSG H702";
 	compatible = "hsg,h702", "allwinner,sun5i-a13";
@@ -59,7 +61,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
 			cd-inverted;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 729f02daf605..c30180794c54 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -50,6 +50,8 @@
 #include "sun5i-a13.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A13-Olinuxino Micro";
 	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
@@ -60,7 +62,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -133,14 +135,14 @@
 
 		power {
 			label = "a13-olinuxino-micro:green:power";
-			gpios = <&pio 6 9 0>;
+			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
-		gpio = <&pio 6 11 0>;
+		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 0e9e17dcc936..c2f6288083ae 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -51,6 +51,8 @@
 #include "sun5i-a13.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A13-Olinuxino";
 	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
@@ -61,7 +63,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -133,14 +135,14 @@
 		pinctrl-0 = <&led_pins_olinuxino>;
 
 		power {
-			gpios = <&pio 6 9 0>;
+			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
-		gpio = <&pio 6 11 0>;
+		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index 42a11f4795f7..0d86e8cb2ca2 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -51,6 +51,8 @@
 #include "sun6i-a31.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
 	compatible = "allwinner,app4-evb1", "allwinner,sun6i-a31";
@@ -87,7 +89,7 @@
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_a>;
-		gpio = <&pio 7 27 0>;
+		gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 2e5bcaf6e860..deab8f357ad7 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -51,6 +51,8 @@
 #include "sun6i-a31.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "WITS A31 Colombus Evaluation Board";
 	compatible = "wits,colombus", "allwinner,sun6i-a31";
@@ -65,7 +67,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
 			vmmc-supply = <&reg_vcc3v0>;
 			bus-width = <4>;
-			cd-gpios = <&pio 0 8 0>; /* PA8 */
+			cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -127,7 +129,7 @@
 	reg_usb2_vbus: usb2-vbus {
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb2_vbus_pin_colombus>;
-		gpio = <&pio 7 24 0>;
+		gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index a3bf20930d50..7364d22b33dd 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -51,6 +51,8 @@
 #include "sun6i-a31.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Merrii A31 Hummingbird";
 	compatible = "merrii,a31-hummingbird", "allwinner,sun6i-a31";
@@ -65,7 +67,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
 			vmmc-supply = <&reg_vcc3v0>;
 			bus-width = <4>;
-			cd-gpios = <&pio 0 8 0>; /* PA8 */
+			cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -139,7 +141,7 @@
 			pinctrl-0 = <&gmac_pins_rgmii_a>;
 			phy = <&phy1>;
 			phy-mode = "rgmii";
-			snps,reset-gpio = <&pio 0 21 0>;
+			snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
 			snps,reset-active-low;
 			snps,reset-delays-us = <0 10000 30000>;
 			status = "okay";
@@ -152,7 +154,7 @@
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_a>;
-		gpio = <&pio 7 24 0>; /* PH24 */
+		gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 9b47964dcc5a..799040627ab7 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -49,6 +49,8 @@
 #include "sun6i-a31.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Mele M9 / A1000G Quad top set box";
 	compatible = "mele,m9", "allwinner,sun6i-a31";
@@ -63,7 +65,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 22 0>; /* PH22 */
+			cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -130,14 +132,14 @@
 
 		blue {
 			label = "m9:blue:usr";
-			gpios = <&pio 7 13 0>;
+			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb1_vbus_pin_m9>;
-		gpio = <&pio 2 27 0>;
+		gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index e9e96584bedd..e273f0e0627a 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -51,6 +51,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "LeMaker Banana Pi";
 	compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
@@ -67,7 +69,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 10 0>; /* PH10 */
+			cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -188,7 +190,7 @@
 
 		green {
 			label = "bananapi:green:usr";
-			gpios = <&pio 7 24 0>;
+			gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -209,6 +211,6 @@
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <100000>;
 		enable-active-high;
-		gpio = <&pio 7 23 0>;
+		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 809d448ecf30..27ca1a16ca91 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -15,6 +15,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Cubietech Cubieboard2";
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
@@ -25,7 +27,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -120,12 +122,12 @@
 
 		blue {
 			label = "cubieboard2:blue:usr";
-			gpios = <&pio 7 21 0>;
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>;
 		};
 
 		green {
 			label = "cubieboard2:green:usr";
-			gpios = <&pio 7 20 0>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 9812a3a34831..a6e88f8ce533 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -15,6 +15,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Cubietech Cubietruck";
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
@@ -25,7 +27,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -168,34 +170,34 @@
 
 		blue {
 			label = "cubietruck:blue:usr";
-			gpios = <&pio 7 21 0>;
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>;
 		};
 
 		orange {
 			label = "cubietruck:orange:usr";
-			gpios = <&pio 7 20 0>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 
 		white {
 			label = "cubietruck:white:usr";
-			gpios = <&pio 7 11 0>;
+			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;
 		};
 
 		green {
 			label = "cubietruck:green:usr";
-			gpios = <&pio 7 7 0>;
+			gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	reg_ahci_5v: ahci-5v {
 		pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
-		gpio = <&pio 7 12 0>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
 	reg_usb0_vbus: usb0-vbus {
 		pinctrl-0 = <&usb0_vbus_pin_a>;
-		gpio = <&pio 7 17 0>;
+		gpio = <&pio 7 17 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
@@ -215,6 +217,6 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pio 7 9 0>;
+		gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index add6d95a0246..3b8bd22296e6 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -15,6 +15,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Merrii A20 Hummingbird";
 	compatible = "merrii,a20-hummingbird", "allwinner,sun7i-a20";
@@ -25,7 +27,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v0>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -184,7 +186,7 @@
 			phy-mode = "rgmii";
 			phy-supply = <&reg_gmac_vdd>;
 			/* phy reset config */
-			snps,reset-gpio = <&pio 0 17 0>; /* PA17 */
+			snps,reset-gpio = <&pio 0 17 GPIO_ACTIVE_HIGH>; /* PA17 */
 			snps,reset-active-low;
 			/* wait 1s after reset, otherwise fail to read phy id */
 			snps,reset-delays-us = <0 10000 1000000>;
@@ -198,13 +200,13 @@
 
 	reg_ahci_5v: ahci-5v {
 		pinctrl-0 = <&ahci_pwr_pin_a20_hummingbird>;
-		gpio = <&pio 7 15 0>; /* PH15 */
+		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 		status = "okay";
 	};
 
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-0 = <&usb1_vbus_pin_a20_hummingbird>;
-		gpio = <&pio 7 2 0>; /* PH2 */
+		gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 		status = "okay";
 	};
 
@@ -220,7 +222,7 @@
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		enable-active-high;
-		gpio = <&pio 7 9 0>; /* PH9 */
+		gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	};
 
 	reg_gmac_vdd: gmac_vdd {
@@ -231,6 +233,6 @@
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		enable-active-high;
-		gpio = <&pio 7 16 0>; /* PH16 */
+		gpio = <&pio 7 16 GPIO_ACTIVE_HIGH>; /* PH16 */
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 780f1aa98429..a422f19a0261 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -49,6 +49,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "I12 / Q5 / QT840A A20 tvbox";
 	compatible = "allwinner,i12-tvbox", "allwinner,sun7i-a20";
@@ -59,7 +61,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -179,12 +181,12 @@
 
 		red {
 			label = "i12_tvbox:red:usr";
-			gpios = <&pio 7 9 1>;
+			gpios = <&pio 7 9 GPIO_ACTIVE_LOW>;
 		};
 
 		blue {
 			label = "i12_tvbox:blue:usr";
-			gpios = <&pio 7 20 0>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -204,7 +206,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
-		gpio = <&pio 7 2 0>;
+		gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_vmmc3_io: vmmc3-io {
@@ -217,7 +219,7 @@
 		/* This controls VCC-PI, must be always on! */
 		regulator-always-on;
 		enable-active-high;
-		gpio = <&pio 7 12 0>;
+		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
@@ -229,6 +231,6 @@
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <50000>;
 		enable-active-high;
-		gpio = <&pio 7 21 0>;
+		gpio = <&pio 7 21 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index 82046234d9e8..3e40ae74f5e2 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -51,6 +51,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Mele M3";
 	compatible = "mele,m3", "allwinner,sun7i-a20";
@@ -61,7 +63,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -154,7 +156,7 @@
 
 		blue {
 			label = "m3:blue:usr";
-			gpios = <&pio 7 20 0>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 996da8be0e44..0423b1cbb365 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -52,6 +52,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A20-OLinuXino-LIME";
 	compatible = "olimex,a20-olinuxino-lime", "allwinner,sun7i-a20";
@@ -62,7 +64,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -152,14 +154,14 @@
 
 		green {
 			label = "a20-olinuxino-lime:green:usr";
-			gpios = <&pio 7 2 0>;
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_ahci_5v: ahci-5v {
 		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
-		gpio = <&pio 2 3 0>;
+		gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 5fda1e02acdb..ce1e28afa2fe 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -49,6 +49,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A20-OLinuXino-LIME2";
 	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
@@ -59,7 +61,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -199,14 +201,14 @@
 
 		green {
 			label = "a20-olinuxino-lime2:green:usr";
-			gpios = <&pio 7 2 0>;
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
 
 	reg_ahci_5v: ahci-5v {
 		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
-		gpio = <&pio 2 3 0>;
+		gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 7ed510fe1872..abfad90c28eb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -15,6 +15,8 @@
 #include "sun7i-a20.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Olimex A20-Olinuxino Micro";
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
@@ -36,7 +38,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -46,7 +48,7 @@
 			pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 11 0>; /* PH11 */
+			cd-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -166,7 +168,7 @@
 
 		green {
 			label = "a20-olinuxino-micro:green:usr";
-			gpios = <&pio 7 2 0>;
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 2a9b610931c0..e0aa97599cbf 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -62,7 +62,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
 			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
-			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 			cd-inverted;
 			status = "okay";
 		};
@@ -203,7 +203,7 @@
 	};
 
 	reg_ahci_5v: ahci-5v {
-		gpio = <&pio 7 2 0>;
+		gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 491cd6ca4e31..bca84ebde871 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -51,6 +51,8 @@
 #include "sun8i-a23.dtsi"
 #include "sunxi-common-regulators.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Ippo Q8H Dual Core Tablet (v5)";
 	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
@@ -65,7 +67,7 @@
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
 			vmmc-supply = <&reg_vcc3v0>;
 			bus-width = <4>;
-			cd-gpios = <&pio 1 4 0>; /* PB4 */
+			cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
 			cd-inverted;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 7fe242a8134b..8868c946e034 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -50,6 +50,8 @@
 /dts-v1/;
 #include "sun9i-a80.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Merrii A80 Optimus Board";
 	compatible = "merrii,a80-optimus", "allwinner,sun9i-a80";
@@ -106,14 +108,14 @@
 
 		led2 {
 			label = "optimus:led2:usr";
-			gpios = <&pio 7 1 0>;
+			gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
 		};
 
 		/* led3 is on PM15, in R_PIO */
 
 		led4 {
 			label = "optimus:led4:usr";
-			gpios = <&pio 7 0 0>;
+			gpios = <&pio 7 0 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index d8876634f965..d6b7983cf16a 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -47,6 +47,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	soc at 01c00000 {
 		pio: pinctrl at 01c20800 {
@@ -89,7 +91,7 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-boot-on;
 		enable-active-high;
-		gpio = <&pio 1 8 0>;
+		gpio = <&pio 1 8 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
 
@@ -101,7 +103,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&pio 1 9 0>;
+		gpio = <&pio 1 9 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
 
@@ -113,7 +115,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&pio 7 6 0>;
+		gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
 
@@ -125,7 +127,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
-		gpio = <&pio 7 3 0>;
+		gpio = <&pio 7 3 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
 
-- 
2.2.0
