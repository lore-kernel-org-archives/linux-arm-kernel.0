From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Dec 2014 11:13:21 +0100
Subject: [PATCH resend 2/3] ARM: dts: sun5i: Add lradc node
In-Reply-To: <1419329602-11552-1-git-send-email-hdegoede@redhat.com>
References: <1419329602-11552-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1419329602-11552-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 45 ++++++++++++++++++++++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  7 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 45 ++++++++++++++++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  7 ++++
 4 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index fe3c559..dac9d49 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -48,8 +48,9 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a10s.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a10s.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
@@ -134,6 +135,46 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+
+			button at 191 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+
+			button at 392 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+
+			button at 601 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+
+			button at 795 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+
+			button at 987 {
+				label = "Home";
+				linux,code = <KEY_HOMEPAGE>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 1b76667..58a9666 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -526,6 +526,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom at 01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index e31d291..529ff27 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -48,8 +48,9 @@
  */
 
 /dts-v1/;
-/include/ "sun5i-a13.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A13-Olinuxino";
@@ -102,6 +103,46 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+
+			button at 191 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+
+			button at 392 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+
+			button at 601 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+
+			button at 795 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+
+			button at 987 {
+				label = "Home";
+				linux,code = <KEY_HOMEPAGE>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart1: serial at 01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c35217e..061b2273 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -460,6 +460,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
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
