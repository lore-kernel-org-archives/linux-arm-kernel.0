From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Mar 2016 21:53:22 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Orangepi plus gpio keys fixes and
 improvements
In-Reply-To: <1458680002-15021-1-git-send-email-hdegoede@redhat.com>
References: <1458680002-15021-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458680002-15021-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following issues with the gpio_keys node:
1) Use of undocumented input-name property
2) Use of a unit-address on the sw2 node
3) Having "PL03" in the pinctrl node which does not exist, this should
   be "PL3"

And add support for the sw2 button on the board.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 3d9996f..94f8b0b 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -79,12 +79,16 @@
 
 	r_gpio_keys {
 		compatible = "gpio-keys";
-		input-name = "sw4";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&sw_r_opc>;
 
-		sw4 at 0 {
+		sw2 {
+			label = "sw2";
+			linux,code = <BTN_1>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
+		};
+
+		sw4 {
 			label = "sw4";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
@@ -187,7 +191,7 @@
 	};
 
 	sw_r_opc: key_pins at 0 {
-		allwinner,pins = "PL03";
+		allwinner,pins = "PL3", "PL4";
 		allwinner,function = "gpio_in";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.7.3
