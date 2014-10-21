From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Oct 2014 10:24:50 +0200
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
In-Reply-To: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1413879890-7254-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 48 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  7 ++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9d669cdf..85e7194 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
 /include/ "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
@@ -100,6 +101,53 @@
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
+				linux,code = <KEY_SEARCH>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+			button at 98 {
+				label = "Home";
+				linux,code = <KEY_HOME>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+			button at 118 {
+				label = "Home";
+				linux,code = <KEY_ESC>;
+				channel = <0>;
+				voltage = <1184678>;
+			};
+			button at 139 {
+				label = "Home";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <1398804>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f0a75c6..219cd57 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -911,6 +911,13 @@
 			status = "disabled";
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <0 31 4>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
2.1.0
