From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 18:07:13 +0100
Subject: [PATCH 3/3] ARM: mvebu: use input DT defines in Armada 370/XP boards
In-Reply-To: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392138433-12573-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of harcoding keycodes specifications in the Armada 370/XP
boards, use the <dt-bindings/input/input.h> header file and its
keycode definitions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 3 ++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index c28865d..3e2c857 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -12,6 +12,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "armada-370.dtsi"
 
@@ -101,7 +102,7 @@
 				#size-cells = <0>;
 				button at 1 {
 					label = "Software Button";
-					linux,code = <116>;
+					linux,code = <KEY_POWER>;
 					gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 				};
 			};
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index db1ef58..d83d7d6 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -17,6 +17,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "armada-xp-mv78230.dtsi"
 
 / {
@@ -158,7 +159,7 @@
 
 		button at 1 {
 			label = "Factory Reset Button";
-			linux,code = <141>; /* KEY_SETUP */
+			linux,code = <KEY_SETUP>;
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 		};
 	};
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 944acfb..985948c 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "armada-xp-mv78260.dtsi"
 
 / {
@@ -115,7 +116,7 @@
 
 				button at 1 {
 					label = "Init Button";
-					linux,code = <116>;
+					linux,code = <KEY_POWER>;
 					gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 				};
 			};
-- 
1.8.3.2
