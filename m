From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 18:07:12 +0100
Subject: [PATCH 2/3] ARM: mvebu: use GPIO DT defines in Armada 370/XP boards
In-Reply-To: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392138433-12573-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of harcoding 0 and 1 for the gpio specifications in the Armada
370/XP boards, use the <dt-bindings/gpio/gpio.h> header file and its
GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW definitions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts         | 7 ++++---
 arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 3 ++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 9 +++++----
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 944e878..2354fe0 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-370.dtsi"
 
 / {
@@ -73,19 +74,19 @@
 
 				green_pwr_led {
 					label = "mirabox:green:pwr";
-					gpios = <&gpio1 31 1>;
+					gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
 					default-state = "keep";
 				};
 
 				blue_stat_led {
 					label = "mirabox:blue:stat";
-					gpios = <&gpio2 0 1>;
+					gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 					default-state = "off";
 				};
 
 				green_stat_led {
 					label = "mirabox:green:stat";
-					gpios = <&gpio2 1 1>;
+					gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 					default-state = "off";
 				};
 			};
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index abbb807..c28865d 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -12,6 +12,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-370.dtsi"
 
 / {
@@ -101,7 +102,7 @@
 				button at 1 {
 					label = "Software Button";
 					linux,code = <116>;
-					gpios = <&gpio0 6 1>;
+					gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index c5fe572..db1ef58 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -16,6 +16,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-xp-mv78230.dtsi"
 
 / {
@@ -158,7 +159,7 @@
 		button at 1 {
 			label = "Factory Reset Button";
 			linux,code = <141>; /* KEY_SETUP */
-			gpios = <&gpio1 1 1>;
+			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 99bcf76..944acfb 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -11,6 +11,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-xp-mv78260.dtsi"
 
 / {
@@ -90,19 +91,19 @@
 
 				red_led {
 					label = "red_led";
-					gpios = <&gpio1 17 1>;
+					gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 					default-state = "off";
 				};
 
 				yellow_led {
 					label = "yellow_led";
-					gpios = <&gpio1 19 1>;
+					gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 					default-state = "off";
 				};
 
 				green_led {
 					label = "green_led";
-					gpios = <&gpio1 21 1>;
+					gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 					default-state = "keep";
 				};
 			};
@@ -115,7 +116,7 @@
 				button at 1 {
 					label = "Init Button";
 					linux,code = <116>;
-					gpios = <&gpio1 28 0>;
+					gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 				};
 			};
 
-- 
1.8.3.2
