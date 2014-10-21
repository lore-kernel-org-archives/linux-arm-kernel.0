From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Oct 2014 10:24:49 +0200
Subject: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 36 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  7 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 36 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  7 +++++
 4 files changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index ea9519d..84df85e 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 /include/ "sun5i-a10s.dtsi"
 /include/ "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
@@ -98,6 +99,41 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+			button at 19 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+			button at 39 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+			button at 60 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+			button at 80 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+			button at 98 {
+				label = "Home";
+				linux,code = <KEY_HOME>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 531272c..a73cec4 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -520,6 +520,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 429994e..11ecb36 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 /include/ "sun5i-a13.dtsi"
 /include/ "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A13-Olinuxino";
@@ -66,6 +67,41 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+			button at 19 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+			button at 39 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+			button at 60 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+			button at 80 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+			button at 98 {
+				label = "Home";
+				linux,code = <KEY_HOME>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart1: serial at 01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b131068..528d0d6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -468,6 +468,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
-- 
2.1.0
