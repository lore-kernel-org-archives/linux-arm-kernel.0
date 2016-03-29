From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 00:30:43 +0200
Subject: [PATCH 4/7] ARM: dts: lpc4357-ea4357: fix unit name warnings from dtc
In-Reply-To: <1459290646-3592-1-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
Message-ID: <1459290646-3592-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings from dtc by either adding or removing
the unit name from the node.

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /soc/flash-controller at 40003000/flash at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_joystick/button at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_joystick/button at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_joystick/button at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_joystick/button at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_joystick/button at 4 has a unit name, but no reg property

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index a211b6e..9b5fad6 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -33,7 +33,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 28000000 {
 		device_type = "memory";
 		reg = <0x28000000 0x2000000>; /* 32 MB */
 	};
@@ -62,31 +62,31 @@
 		poll-interval = <100>;
 		autorepeat;
 
-		button at 0 {
+		button0 {
 			label = "joy_enter";
 			linux,code = <KEY_ENTER>;
 			gpios = <&gpio LPC_GPIO(4,8) GPIO_ACTIVE_LOW>;
 		};
 
-		button at 1 {
+		button1 {
 			label = "joy_left";
 			linux,code = <KEY_LEFT>;
 			gpios = <&gpio LPC_GPIO(4,9) GPIO_ACTIVE_LOW>;
 		};
 
-		button at 2 {
+		button2 {
 			label = "joy_up";
 			linux,code = <KEY_UP>;
 			gpios = <&gpio LPC_GPIO(4,10) GPIO_ACTIVE_LOW>;
 		};
 
-		button at 3 {
+		button3 {
 			label = "joy_right";
 			linux,code = <KEY_RIGHT>;
 			gpios = <&gpio LPC_GPIO(4,12) GPIO_ACTIVE_LOW>;
 		};
 
-		button at 4 {
+		button4 {
 			label = "joy_down";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpio LPC_GPIO(4,13) GPIO_ACTIVE_LOW>;
@@ -584,7 +584,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spifi_pins>;
 
-	flash at 0 {
+	flash {
 		compatible = "jedec,spi-nor";
 		spi-cpol;
 		spi-cpha;
-- 
2.7.4
