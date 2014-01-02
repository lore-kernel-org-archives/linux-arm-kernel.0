From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  2 Jan 2014 10:58:27 +0100
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
In-Reply-To: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
References: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388656707-16181-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 9 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 0ee2641..2c9a38f 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
@@ -86,6 +87,14 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			allwinner,chan0-step = <200>;
+			linux,chan0-keycodes = <KEY_VOLUMEUP KEY_VOLUMEDOWN
+						KEY_MENU KEY_SEARCH KEY_HOME
+						KEY_ESC KEY_ENTER>;
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 68e825a..3484275 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -531,6 +531,13 @@
 			interrupts = <0 24 1>;
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
1.8.4.2
