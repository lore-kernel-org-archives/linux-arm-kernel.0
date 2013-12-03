From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Dec 2013 20:51:45 +0100
Subject: [PATCH 2/2] ARM: DT: Kirkwood: Use symbolic names from gpio.h
In-Reply-To: <1386100305-31280-1-git-send-email-andrew@lunn.ch>
References: <1386100305-31280-1-git-send-email-andrew@lunn.ch>
Message-ID: <1386100305-31280-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW instead of 0 and 1.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |  8 +++----
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  4 ++--
 arch/arm/boot/dts/kirkwood-dns320.dts              | 10 ++++-----
 arch/arm/boot/dts/kirkwood-dns325.dts              | 10 ++++-----
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 12 +++++-----
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  4 ++--
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  6 ++---
 arch/arm/boot/dts/kirkwood-goflexnet.dts           | 22 +++++++++---------
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  8 +++----
 arch/arm/boot/dts/kirkwood-ib62x0.dts              | 12 +++++-----
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 20 ++++++++---------
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 14 ++++++------
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  4 ++--
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 22 +++++++++---------
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 14 ++++++------
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 10 ++++-----
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 16 ++++++-------
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  6 ++---
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-ns2max.dts              | 10 ++++-----
 arch/arm/boot/dts/kirkwood-ns2mini.dts             | 10 ++++-----
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      |  4 ++--
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 26 +++++++++++-----------
 arch/arm/boot/dts/kirkwood-nsa310a.dts             | 24 ++++++++++----------
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  8 +++----
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  8 +++----
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  6 ++---
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  4 ++--
 arch/arm/boot/dts/kirkwood-topkick.dts             | 10 ++++-----
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  4 ++--
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  4 ++--
 arch/arm/boot/dts/kirkwood.dtsi                    |  1 +
 32 files changed, 162 insertions(+), 161 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 17123f25e2db..bb4df405527c 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -67,7 +67,7 @@
 		button at 1 {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio0 16 1>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -76,17 +76,17 @@
 
 		red-fail {
 			label = "cloudbox:red:fail";
-			gpios = <&gpio0 14 0>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
 		blue-sata {
 			label = "cloudbox:blue:sata";
-			gpios = <&gpio0 15 0>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
-		gpios = <&gpio0 17 0>;
+		gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
index 053aa20fb30f..afebc1570318 100644
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -51,8 +51,8 @@
 		mvsdio at 90000 {
 			pinctrl-0 = <&pmx_sdio_gpios>;
 			pinctrl-names = "default";
-			wp-gpios = <&gpio1 5 0>;
-			cd-gpios = <&gpio1 6 0>;
+			wp-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			cd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index e112ca62d978..db495cecc308 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -24,24 +24,24 @@
 
 		blue-power {
 			label = "dns320:blue:power";
-			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
+			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 		blue-usb {
 			label = "dns320:blue:usb";
-			gpios = <&gpio1 11 1>; /* GPIO 43 Active Low */
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
 		orange-l_hdd {
 			label = "dns320:orange:l_hdd";
-			gpios = <&gpio0 28 1>; /* GPIO 28 Active Low */
+			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
 		orange-r_hdd {
 			label = "dns320:orange:r_hdd";
-			gpios = <&gpio0 27 1>; /* GPIO 27 Active Low */
+			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
 		};
 		orange-usb {
 			label = "dns320:orange:usb";
-			gpios = <&gpio1 3 1>; /* GPIO 35 Active Low */
+			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>; /* GPIO 35 */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index 5119fb8a8eb6..9a551940e9d1 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -24,24 +24,24 @@
 
 		white-power {
 			label = "dns325:white:power";
-			gpios = <&gpio0 26 1>; /* GPIO 26 Active Low */
+			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 		white-usb {
 			label = "dns325:white:usb";
-			gpios = <&gpio1 11 1>; /* GPIO 43 Active Low */
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>; /* GPIO 43 */
 		};
 		red-l_hdd {
 			label = "dns325:red:l_hdd";
-			gpios = <&gpio0 28 1>; /* GPIO 28 Active Low */
+			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
 		red-r_hdd {
 			label = "dns325:red:r_hdd";
-			gpios = <&gpio0 27 1>; /* GPIO 27 Active Low */
+			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
 		};
 		red-usb {
 			label = "dns325:red:usb";
-			gpios = <&gpio0 29 1>; /* GPIO 29 Active Low */
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 1d680d11f629..12087566ac6d 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -16,17 +16,17 @@
 		button at 1 {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 2 1>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "USB unmount button";
 			linux,code = <KEY_EJECTCD>;
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			label = "Reset button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 16 1>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -35,8 +35,8 @@
 		compatible = "gpio-fan";
 		pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 14 1
-			 &gpio1 13 1>;
+		gpios = <&gpio1 14 GPIO_ACTIVE_LOW
+			 &gpio1 13 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map = <0    0
 				      3000 1
 				      6000 2>;
@@ -46,7 +46,7 @@
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&pmx_power_off>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 4 0>;
+		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 	};
 
 	ocp at f1000000 {
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 33ff368fbfa5..92e383c19bb3 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -42,12 +42,12 @@
 
 		health {
 			label = "status:green:health";
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 		fault {
 			label = "status:orange:fault";
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 	};
 	regulators {
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 6f62af99c9cb..a7558375e06f 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -87,15 +87,15 @@
 
 		bluetooth {
 			label = "dreamplug:blue:bluetooth";
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		wifi {
 			label = "dreamplug:green:wifi";
-			gpios = <&gpio1 16 1>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
 		wifi-ap {
 			label = "dreamplug:green:wifi_ap";
-			gpios = <&gpio1 17 1>;
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index a43bebb25110..41fa38b9b57e 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -85,44 +85,44 @@
 
 		health {
 			label = "status:green:health";
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 		fault {
 			label = "status:orange:fault";
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		left0 {
 			label = "status:white:left0";
-			gpios = <&gpio1 10 0>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
 		left1 {
 			label = "status:white:left1";
-			gpios = <&gpio1 11 0>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
 		left2 {
 			label = "status:white:left2";
-			gpios = <&gpio1 12 0>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		};
 		left3 {
 			label = "status:white:left3";
-			gpios = <&gpio1 13 0>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
 		right0 {
 			label = "status:white:right0";
-			gpios = <&gpio1 6 0>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
 		right1 {
 			label = "status:white:right1";
-			gpios = <&gpio1 7 0>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 		right2 {
 			label = "status:white:right2";
-			gpios = <&gpio1 8 0>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 		right3 {
 			label = "status:white:right3";
-			gpios = <&gpio1 9 0>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
 	};
 	regulators {
@@ -141,7 +141,7 @@
 			enable-active-high;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 29 0>;
+			gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index d30a91a5047d..40da99469c05 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -60,19 +60,19 @@
 
 		health-r {
 			label = "guruplug:red:health";
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 		health-g {
 			label = "guruplug:green:health";
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		wmode-r {
 			label = "guruplug:red:wmode";
-			gpios = <&gpio1 16 1>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
 		wmode-g {
 			label = "guruplug:green:wmode";
-			gpios = <&gpio1 17 1>;
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 1d69cad81021..ef2f333db701 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -64,12 +64,12 @@
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio0 29 1>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 28 1>;
+			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -81,16 +81,16 @@
 
 		green-os {
 			label = "ib62x0:green:os";
-			gpios = <&gpio0 25 0>;
+			gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 		red-os {
 			label = "ib62x0:red:os";
-			gpios = <&gpio0 22 0>;
+			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
 		};
 		usb-copy {
 			label = "ib62x0:red:usb_copy";
-			gpios = <&gpio0 27 0>;
+			gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -98,7 +98,7 @@
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&pmx_power_off>;
 		pinctrl-names = "default";
-		gpios = <&gpio0 24 0>;
+		gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index d69123f71ebb..e7aacb15aefb 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -94,37 +94,37 @@
 
 		led-level {
 			label = "led_level";
-			gpios = <&gpio1 9 0>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 		power-blue {
 			label = "power:blue";
-			gpios = <&gpio1 10 0>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 		};
 		power-red {
 			label = "power:red";
-			gpios = <&gpio1 11 0>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
 		usb1 {
 			label = "usb1:blue";
-			gpios = <&gpio1 12 0>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		};
 		usb2 {
 			label = "usb2:blue";
-			gpios = <&gpio1 13 0>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
 		usb3 {
 			label = "usb3:blue";
-			gpios = <&gpio1 14 0>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
 		usb4 {
 			label = "usb4:blue";
-			gpios = <&gpio1 15 0>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		};
 		otb {
 			label = "otb:blue";
-			gpios = <&gpio1 16 0>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -138,13 +138,13 @@
 		button at 1 {
 			label = "OTB Button";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 3 1>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
 		button at 2 {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 12 1>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 01534da7b25e..f2f1077f2b06 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -127,20 +127,20 @@
 
 		power_led {
 			label = "status:white:power_led";
-			gpios = <&gpio0 16 0>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 		rebuild_led {
 			label = "status:white:rebuild_led";
-			gpios = <&gpio1 4 0>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 		};
 		health_led {
 			label = "status:red:health_led";
-			gpios = <&gpio1 5 0>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		};
 		backup_led {
 			label = "status:blue:backup_led";
-			gpios = <&gpio0 15 0>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 	};
 	gpio-keys {
@@ -155,17 +155,17 @@
 		Power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio0 14 1>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 		};
 		Reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 12 1>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
 		};
 		OTB {
 			label = "OTB Button";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 3 1>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index cd44f37e54b5..5b5808ebc6e0 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -38,8 +38,8 @@
 
 	i2c at 0 {
 		compatible = "i2c-gpio";
-		gpios = < &gpio0 8 0		/* sda */
-			&gpio0 9 0 >;		/* scl */
+		gpios = < &gpio0 8 GPIO_ACTIVE_HIGH		/* sda */
+			  &gpio0 9 GPIO_ACTIVE_HIGH>;		/* scl */
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 1abfa0dd700b..c025ee945f6d 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -109,19 +109,19 @@
 		button at 1 {
 			label = "Function Button";
 			linux,code = <KEY_OPTION>;
-			gpios = <&gpio1 9 1>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "Power-on Switch";
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
-			gpios = <&gpio1 10 1>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			label = "Power-auto Switch";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
-			gpios = <&gpio1 11 1>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -134,28 +134,28 @@
 
 		led at 1 {
 			label = "lsxl:blue:func";
-			gpios = <&gpio1 4 1>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 2 {
 			label = "lsxl:red:alarm";
-			gpios = <&gpio1 5 1>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 3 {
 			label = "lsxl:amber:info";
-			gpios = <&gpio1 6 1>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
 		led at 4 {
 			label = "lsxl:blue:power";
-			gpios = <&gpio1 7 1>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
 		led at 5 {
 			label = "lsxl:red:func";
-			gpios = <&gpio1 16 1>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -163,13 +163,13 @@
 		compatible = "gpio-fan";
 		pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
 		pinctrl-names = "default";
-		gpios = <&gpio0 19 1
-		         &gpio0 18 1>;
+		gpios = <&gpio0 19 GPIO_ACTIVE_LOW
+		         &gpio0 18 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map = <0    3
 		                      1500 2
 		                      3250 1
 		                      5000 0>;
-		alarm-gpios = <&gpio1 8 0>;
+		alarm-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 	};
 
 	restart_poweroff {
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 6c1ec2786e6e..c20607cd7d7c 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -110,7 +110,7 @@
 			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
 			pinctrl-names = "default";
 			status = "okay";
-			cd-gpios = <&gpio1 15 1>;
+			cd-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 			/* No WP GPIO */
 		};
 	};
@@ -126,36 +126,36 @@
 
 		health {
 			label = "status:green:health";
-			gpios = <&gpio0 7 1>;
+			gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 		};
 
 		user1o {
 			label = "user1:orange";
-			gpios = <&gpio1 8 1>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
 		user1g {
 			label = "user1:green";
-			gpios = <&gpio1 9 1>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
 		user0o {
 			label = "user0:orange";
-			gpios = <&gpio1 12 1>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
 		user0g {
 			label = "user0:green";
-			gpios = <&gpio1 13 1>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
 		misc {
 			label = "status:orange:misc";
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index ade432466c85..dc86429756d7 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -90,17 +90,17 @@
 
 		green-status {
 			label = "gtw:green:Status";
-			gpios = <&gpio0 20 0>;
+			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 		};
 
 		red-status {
 			label = "gtw:red:Status";
-			gpios = <&gpio0 21 0>;
+			gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
 		};
 
 		green-usb {
 			label = "gtw:green:USB";
-			gpios = <&gpio0 12 0>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -114,12 +114,12 @@
 		button at 1 {
 			label = "SWR Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "WPS Button";
 			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index c35f917ac438..08e498df25ff 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -112,24 +112,24 @@
 
 		power_led {
 			label = "status:blue:power_led";
-			gpios = <&gpio0 31 1>;   /* GPIO 31 Active Low */
+			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 		activity_led {
 			label = "status:blue:activity_led";
-			gpios = <&gpio1 6 1>;    /* GPIO 38 Active Low */
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;    /* GPIO 38 */
 		};
 		disk1_led {
 			label = "status:blue:disk1_led";
-			gpios = <&gpio0 23 1>;   /* GPIO 23 Active Low */
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
 		disk2_led {
 			label = "status:blue:disk2_led";
-			gpios = <&gpio0 22 1>;   /* GPIO 22 Active Low */
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
 		backup_led {
 			label = "status:blue:backup_led";
-			gpios = <&gpio0 29 1>;   /* GPIO 29 Active Low*/
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -144,17 +144,17 @@
 		button at 1 {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 15 1>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 13 1>;
+			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			label = "Backup Button";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 13 1>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 3101aecdcc0a..ae1ccbe41029 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -65,7 +65,7 @@
 		button at 1 {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 0 0>;
+			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -74,13 +74,13 @@
 
 		red-fail {
 			label = "ns2:red:fail";
-			gpios = <&gpio0 12 0>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
-		gpios = <&gpio0 31 0>;
+		gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
 	};
 
 };
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index 279607093cdb..5efb39a92b3c 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -25,7 +25,7 @@
 
 		blue-sata {
 			label = "ns2:blue:sata";
-			gpios = <&gpio0 30 1>;
+			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
index defdc77fb550..72c78d0b1116 100644
--- a/arch/arm/boot/dts/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
@@ -22,10 +22,10 @@
 
 	gpio_fan {
 		compatible = "gpio-fan";
-		gpios = <&gpio0 22 1
-			 &gpio0  7 1
-			 &gpio1  1 1
-			 &gpio0 23 1>;
+		gpios = <&gpio0 22 GPIO_ACTIVE_LOW
+			 &gpio0  7 GPIO_ACTIVE_LOW
+			 &gpio1  1 GPIO_ACTIVE_LOW
+			 &gpio0 23 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map =
 			<   0  0
 			 1500 15
@@ -36,7 +36,7 @@
 			 3300 10
 			 4300  9
 			 5500  8>;
-		alarm-gpios = <&gpio0 25 1>;
+		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 	};
 
 	ns2-leds {
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index adbafdd90991..c441bf62c09f 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -23,10 +23,10 @@
 
 	gpio_fan {
 		compatible = "gpio-fan";
-		gpios = <&gpio0 22 1
-			 &gpio0  7 1
-			 &gpio1  1 1
-			 &gpio0 23 1>;
+		gpios = <&gpio0 22 GPIO_ACTIVE_LOW
+			 &gpio0  7 GPIO_ACTIVE_LOW
+			 &gpio1  1 GPIO_ACTIVE_LOW
+			 &gpio0 23 GPIO_ACTIVE_LOW>;
 		gpio-fan,speed-map =
 			<   0  0
 			 3000 15
@@ -37,7 +37,7 @@
 			 7140 10
 			 7980  9
 			 9200  8>;
-		alarm-gpios = <&gpio0 25 1>;
+		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 	};
 
 	ns2-leds {
diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
index e3f915defd3d..aa78c2d11fe7 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
@@ -40,7 +40,7 @@
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&pmx_pwr_off>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 16 0>;
+		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
 
 	regulators {
@@ -58,7 +58,7 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 21 0>;
+			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index c45a26ce8b57..03fa24cf3344 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -120,17 +120,17 @@
 		button at 1 {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 14 0>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
 		button at 2 {
 			label = "Copy Button";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 5 1>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 4 1>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -145,43 +145,43 @@
 
 		green-sys {
 			label = "nsa310:green:sys";
-			gpios = <&gpio0 28 0>;
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
 		red-sys {
 			label = "nsa310:red:sys";
-			gpios = <&gpio0 29 0>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
 		green-hdd {
 			label = "nsa310:green:hdd";
-			gpios = <&gpio1 9 0>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
 		red-hdd {
 			label = "nsa310:red:hdd";
-			gpios = <&gpio1 10 0>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
 		green-esata {
 			label = "nsa310:green:esata";
-			gpios = <&gpio0 12 0>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
 		red-esata {
 			label = "nsa310:red:esata";
-			gpios = <&gpio0 13 0>;
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
 		green-usb {
 			label = "nsa310:green:usb";
-			gpios = <&gpio0 15 0>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 		red-usb {
 			label = "nsa310:red:usb";
-			gpios = <&gpio0 16 0>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
 		green-copy {
 			label = "nsa310:green:copy";
-			gpios = <&gpio1 7 0>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 		red-copy {
 			label = "nsa310:red:copy";
-			gpios = <&gpio1 8 0>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index 874df7d26c7c..a5e779452867 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -108,17 +108,17 @@
 		button at 1 {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 14 0>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
 		button at 2 {
 			label = "Copy Button";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 5 1>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 		button at 3 {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 4 1>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -127,39 +127,39 @@
 
 		green-sys {
 			label = "nsa310:green:sys";
-			gpios = <&gpio0 28 0>;
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
 		red-sys {
 			label = "nsa310:red:sys";
-			gpios = <&gpio0 29 0>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
 		green-hdd {
 			label = "nsa310:green:hdd";
-			gpios = <&gpio1 9 0>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
 		red-hdd {
 			label = "nsa310:red:hdd";
-			gpios = <&gpio1 10 0>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
 		green-esata {
 			label = "nsa310:green:esata";
-			gpios = <&gpio0 12 0>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
 		red-esata {
 			label = "nsa310:red:esata";
-			gpios = <&gpio0 13 0>;
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
 		green-usb {
 			label = "nsa310:green:usb";
-			gpios = <&gpio0 15 0>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
 		green-copy {
 			label = "nsa310:green:copy";
-			gpios = <&gpio1 7 0>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 		red-copy {
 			label = "nsa310:red:copy";
-			gpios = <&gpio1 8 0>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 6c171e067b59..5c6a4f1b4e93 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -101,17 +101,17 @@
 
 		led-red {
 			label = "obsa6:red:stat";
-			gpios = <&gpio1 9 1>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
 
 		led-green {
 			label = "obsa6:green:stat";
-			gpios = <&gpio1 10 1>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
 
 		led-yellow {
 			label = "obsa6:yellow:stat";
-			gpios = <&gpio1 11 1>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
         };
 
@@ -125,7 +125,7 @@
 		button at 1 {
 			label = "Init Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 6 0>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index c97bad46c29c..c054ef61cff5 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -126,17 +126,17 @@
 
 		led-red {
 			label = "obsa7:red:stat";
-			gpios = <&gpio1 9 1>;
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
 
 		led-green {
 			label = "obsa7:green:stat";
-			gpios = <&gpio1 10 1>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
 
 		led-yellow {
 			label = "obsa7:yellow:stat";
-			gpios = <&gpio1 11 1>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
         };
 
@@ -150,7 +150,7 @@
 		button at 1 {
 			label = "Init Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio1 6 0>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
index eac6a21f3b1f..016aed6875f5 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
@@ -24,8 +24,8 @@
 			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd &pmx_sdio_wp>;
 			pinctrl-names = "default";
 			status = "okay";
-			cd-gpios = <&gpio1 12 1>;
-			wp-gpios = <&gpio1 15 0>;
+			cd-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -36,7 +36,7 @@
 
 		health {
 			label = "sheevaplug:blue:health";
-			gpios = <&gpio1 17 1>;
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
index bb61918313db..becfb712e196 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -31,13 +31,13 @@
 
 		health {
 			label = "sheevaplug:blue:health";
-			gpios = <&gpio1 17 1>;
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
 		misc {
 			label = "sheevaplug:red:misc";
-			gpios = <&gpio1 14 1>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 320da677b984..40d6adf678ca 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -131,25 +131,25 @@
 
 		disk {
 			label = "topkick:yellow:disk";
-			gpios = <&gpio0 21 1>;
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "ide-disk";
 		};
 		system2 {
 			label = "topkick:red:system";
-			gpios = <&gpio1 5 1>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 		system {
 			label = "topkick:blue:system";
-			gpios = <&gpio1 6 1>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 		wifi {
 			label = "topkick:green:wifi";
-			gpios = <&gpio1 7 1>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		};
 		wifi2 {
 			label = "topkick:yellow:wifi";
-			gpios = <&gpio1 16 1>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 	regulators {
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 89f7094117f4..c17ae45e19be 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -42,12 +42,12 @@
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio0 15 1>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 16 1>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 6976afb56605..0713d072758a 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -52,12 +52,12 @@
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
-			gpios = <&gpio1 11 1>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
 		button at 2 {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
-			gpios = <&gpio1 5 1>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 477c0b5553e8..dd58a25a4166 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,5 +1,6 @@
 /include/ "skeleton.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
-- 
1.8.5
