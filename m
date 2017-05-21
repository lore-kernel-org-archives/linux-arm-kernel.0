From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:59 +0200
Subject: [PATCH 10/13] ARM: dts: armada-385-linksys: group pins in pinctrl
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-11-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A pin group per node is sufficient, further specialisation only serves
as documentation which can be a comment just as well. This simplifies
configuring pins for nodes in dependants.

Also use labels which end up right by the node they are intended for.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 485abff..1bb974a 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -83,7 +83,7 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		pinctrl-0 = <&keys_pin>;
+		pinctrl-0 = <&gpio_keys_pins>;
 		pinctrl-names = "default";
 
 		button at 1 {
@@ -101,7 +101,7 @@
 
 	gpio_leds: gpio-leds {
 		compatible = "gpio-leds";
-		pinctrl-0 = <&power_led_pin &sata_led_pin>;
+		pinctrl-0 = <&gpio_leds_pins>;
 		pinctrl-names = "default";
 
 		power {
@@ -247,18 +247,15 @@
 };
 
 &pinctrl {
-	keys_pin: keys-pin {
+	gpio_keys_pins: gpio-keys-pins {
+		/* mpp24: wps, mpp29: reset */
 		marvell,pins = "mpp24", "mpp29";
 		marvell,function = "gpio";
 	};
 
-	power_led_pin: power-led-pin {
-		marvell,pins = "mpp55";
-		marvell,function = "gpio";
-	};
-
-	sata_led_pin: sata-led-pin {
-		marvell,pins = "mpp54";
+	gpio_leds_pins: gpio-leds-pins {
+		/* mpp54: sata, mpp55: power */
+		marvell,pins = "mpp54", "mpp55";
 		marvell,function = "gpio";
 	};
 
-- 
2.10.2
