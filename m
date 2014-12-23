From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Dec 2014 11:13:22 +0100
Subject: [PATCH resend 3/3] ARM: dts: sun7i: Add lradc node
In-Reply-To: <1419329602-11552-1-git-send-email-hdegoede@redhat.com>
References: <1419329602-11552-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1419329602-11552-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++++++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                |  7 +++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9d669cdf..c00badd 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -12,8 +12,9 @@
  */
 
 /dts-v1/;
-/include/ "sun7i-a20.dtsi"
-/include/ "sunxi-common-regulators.dtsi"
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
@@ -100,6 +101,60 @@
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
+				label = "Search";
+				linux,code = <KEY_SEARCH>;
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
+
+			button at 1184 {
+				label = "Esc";
+				linux,code = <KEY_ESC>;
+				channel = <0>;
+				voltage = <1184678>;
+			};
+
+			button at 1398 {
+				label = "Enter";
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
index e558125..e24f7cc 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -930,6 +930,13 @@
 			status = "disabled";
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
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
