From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 21 Mar 2015 14:23:01 +0100
Subject: [PATCH] ARM: dts: sun6i: csq cs908 dts cleanup
Message-ID: <1426944181-30588-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unused usb1_vbus_pin_csq908 node (vbus is always on on the cs908),
and sort the remaining nodes alphabetically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31s-cs908.dts | 37 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
index bc3734f..3f0cc8c 100644
--- a/arch/arm/boot/dts/sun6i-a31s-cs908.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
@@ -55,10 +55,6 @@
 	compatible = "csq,cs908", "allwinner,sun6i-a31s";
 };
 
-&usbphy {
-	status = "okay";
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -67,25 +63,6 @@
 	status = "okay";
 };
 
-&ohci1 {
-	status = "okay";
-};
-
-&pio {
-	usb1_vbus_pin_csq908: usb1_vbus_pin at 0 {
-		allwinner,pins = "PC27";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
 &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_pins_mii_a>;
@@ -102,3 +79,17 @@
 	pinctrl-0 = <&ir_pins_a>;
 	status = "okay";
 };
+
+&ohci1 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.3.3
