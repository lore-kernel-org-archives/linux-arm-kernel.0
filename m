From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:43 +0200
Subject: [PATCH 1/8] ARM: kirkwood: DT: Remove button address and fixup names
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT compiler is now warning about unit names with addresses but not
reg property. Fix all the gpio-key buttons which causes warnings.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts | 4 ++--
 arch/arm/boot/dts/kirkwood-cloudbox.dts          | 2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi            | 6 +++---
 arch/arm/boot/dts/kirkwood-ib62x0.dts            | 4 ++--
 arch/arm/boot/dts/kirkwood-iconnect.dts          | 4 ++--
 arch/arm/boot/dts/kirkwood-laplug.dts            | 2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi             | 6 +++---
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts   | 4 ++--
 arch/arm/boot/dts/kirkwood-netxbig.dtsi          | 8 ++++----
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi       | 2 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi    | 6 +++---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts     | 2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts     | 2 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts             | 2 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts        | 4 ++--
 arch/arm/boot/dts/kirkwood-ts219-6282.dts        | 4 ++--
 arch/arm/boot/dts/kirkwood-ts419.dtsi            | 4 ++--
 18 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts b/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
index fa02a9aff05e..f16a73e49a88 100644
--- a/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
+++ b/arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
@@ -36,13 +36,13 @@
 	gpio_keys {
 		compatible = "gpio-keys";
 
-		button at 1{
+		reset {
 			label = "Reset";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
 
-		button at 2{
+		button {
 			label = "Power";
 			linux,code = <KEY_SLEEP>;
 			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 7ec76566acf2..555b7e4c58a5 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -60,7 +60,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 113dcf056dcf..d8fca9db46d0 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -13,17 +13,17 @@
 			     &pmx_button_reset>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		power {
 			label = "Power button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		eject {
 			label = "USB unmount button";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+		reset {
 			label = "Reset button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index bfa5edde179c..ef84d8699a76 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -62,12 +62,12 @@
 		pinctrl-0 = <&pmx_button_reset &pmx_button_usb_copy>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 38e31d15a62d..674306746dec 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -136,13 +136,13 @@
 		pinctrl-0 = < &pmx_button_reset &pmx_button_otb >;
 		pinctrl-names = "default";
 
-		button at 1 {
+		otb {
 			label = "OTB Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 			debounce-interval = <100>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/kirkwood-laplug.dts
index 24425660e973..c39e17a89f4e 100644
--- a/arch/arm/boot/dts/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/kirkwood-laplug.dts
@@ -62,7 +62,7 @@
 	gpio_keys {
 		compatible = "gpio-keys";
 
-		button at 1{
+		power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 1d6528d82969..2869c5dbc1ad 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -107,18 +107,18 @@
 			     &pmx_power_auto_switch>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		option {
 			label = "Function Button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		reserved {
 			label = "Power-on Switch";
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+		power {
 			label = "Power-auto Switch";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index b7e7d78c484e..6a8f59acb539 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -109,12 +109,12 @@
 		pinctrl-0 = <&pmx_keys>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		restart {
 			label = "SWR Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		wps {
 			label = "WPS Button";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-netxbig.dtsi b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
index 62515a8b99b9..52b58fe0c4fe 100644
--- a/arch/arm/boot/dts/kirkwood-netxbig.dtsi
+++ b/arch/arm/boot/dts/kirkwood-netxbig.dtsi
@@ -59,22 +59,22 @@
 		#size-cells = <0>;
 
 		/*
-		 * button at 1 and button at 2 represent a three position rocker
+		 * esc and power represent a three position rocker
 		 * switch. Thus the conventional KEY_POWER does not fit
 		 */
-		button at 1 {
+		exc {
 			label = "Back power switch (on|auto)";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
 			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		power {
 			label = "Back power switch (auto|off)";
 			linux,code = <KEY_1>;
 			linux,input-type = <5>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+		option {
 			label = "Function button";
 			linux,code = <KEY_OPTION>;
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index e832b6320264..b4d59261eddc 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -57,7 +57,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		power {
 			label = "Power push button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
index 2075a2e828f1..5ccc46190079 100644
--- a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
@@ -77,17 +77,17 @@
 		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
-		button at 2 {
+		copy {
 			label = "Copy Button";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+		reset {
 			label = "Reset Button";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index fb9dc227255d..0db0e3edc88f 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -117,7 +117,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		power {
 			label = "Init Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index d5e3bc518968..cf2f5240e176 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -135,7 +135,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		button {
 			label = "Init Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
index 8082d64266a3..b2f26239d298 100644
--- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
+++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
@@ -33,7 +33,7 @@
 		pinctrl-0 = <&pmx_button_eject>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		eject {
 			debounce_interval = <50>;
 			wakeup-source;
 			linux,code = <KEY_EJECTCD>;
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index ed956b849a71..af5ce85b2c38 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -173,7 +173,7 @@
 		pinctrl-0 = <&pmx_button_power>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		power {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 9767d73f3857..ee62204e4ecd 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -39,12 +39,12 @@
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index bfc1a32d4e42..1d291f620869 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -49,12 +49,12 @@
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/kirkwood-ts419.dtsi b/arch/arm/boot/dts/kirkwood-ts419.dtsi
index 30ab93bfb1e4..02bd53762705 100644
--- a/arch/arm/boot/dts/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts419.dtsi
@@ -45,12 +45,12 @@
 		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		copy {
 			label = "USB Copy";
 			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
-- 
2.7.0
