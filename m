From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Thu,  1 Jun 2017 22:09:26 +0200
Subject: [PATCH] ARM: dts: mvebu: Add PWM properties to .dtsi files
Message-ID: <20170601200926.22453-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add properties to the GPIO nodes for Armada 370/XP to allow them to be
also used as PWM lines.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427294/
[Ralph Sennhauser: Add new compatible string marvell,armada-370-gpio]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

---

Hi Gregory,

I took the commit which is already in next, updated the compatible
string to "marvell,armada-370-gpio" and ammended the commit message
accordingly.

This one is intended to replace the one in next if/when the the change
to the compatible string from "marvell,armada-370-xp-gpio" to
"marvell,armada-370-gpio" is accepted. ("gpio: mvebu: change compatible
string for PWM support")

Ralph
---
 arch/arm/boot/dts/armada-370.dtsi        | 19 ++++++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 16 ++++++++++++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 19 ++++++++++++++-----
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 19 ++++++++++++++-----
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index cc011c8..f9cf127 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -137,29 +137,38 @@
 			};
 
 			gpio0: gpio at 18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio at 18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio at 18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <2>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 07c5090..9f25814 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -202,25 +202,33 @@
 
 		internal-regs {
 			gpio0: gpio at 18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio at 18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <17>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>;
+				clocks = <&coreclk 0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 64e936a..2bfe07a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -285,29 +285,38 @@
 
 		internal-regs {
 			gpio0: gpio at 18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio at 18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio at 18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index d1383dd..6c33935 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -323,29 +323,38 @@
 
 		internal-regs {
 			gpio0: gpio at 18100 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18100 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18100 0x40>, <0x181c0 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <82>, <83>, <84>, <85>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio1: gpio at 18140 {
-				compatible = "marvell,orion-gpio";
-				reg = <0x18140 0x40>;
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
+				reg = <0x18140 0x40>, <0x181c8 0x08>;
+				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				interrupts = <87>, <88>, <89>, <90>;
+				clocks = <&coreclk 0>;
 			};
 
 			gpio2: gpio at 18180 {
-				compatible = "marvell,orion-gpio";
+				compatible = "marvell,armada-370-gpio",
+					     "marvell,orion-gpio";
 				reg = <0x18180 0x40>;
 				ngpios = <3>;
 				gpio-controller;
-- 
2.10.2
