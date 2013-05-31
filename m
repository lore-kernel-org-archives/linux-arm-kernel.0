From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 14:42:20 +0200
Subject: [PATCH 2/4] ARM: dts: AM33XX: Use existing constants for GPIOs
In-Reply-To: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
References: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1370004142-30506-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use standard GPIO constants to enhance the readability of DT GPIOs.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/am335x-bone.dts  |    8 ++++----
 arch/arm/boot/dts/am335x-evm.dts   |   14 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts |   16 ++++++++--------
 arch/arm/boot/dts/am33xx.dtsi      |    2 ++
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 0365e56..5bfb7dd 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -88,27 +88,27 @@
 
 		led at 2 {
 			label = "beaglebone:green:heartbeat";
-			gpios = <&gpio1 21 0>;
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		led at 3 {
 			label = "beaglebone:green:mmc0";
-			gpios = <&gpio1 22 0>;
+			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led at 4 {
 			label = "beaglebone:green:usr2";
-			gpios = <&gpio1 23 0>;
+			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
 		led at 5 {
 			label = "beaglebone:green:usr3";
-			gpios = <&gpio1 24 0>;
+			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 629476e..0fbecfd 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -159,12 +159,12 @@
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
 
-		row-gpios = <&gpio1 25 0	/* Bank1, pin25 */
-			     &gpio1 26 0	/* Bank1, pin26 */
-			     &gpio1 27 0>;	/* Bank1, pin27 */
+		row-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH		/* Bank1, pin25 */
+			     &gpio1 26 GPIO_ACTIVE_HIGH		/* Bank1, pin26 */
+			     &gpio1 27 GPIO_ACTIVE_HIGH>;	/* Bank1, pin27 */
 
-		col-gpios = <&gpio1 21 0	/* Bank1, pin21 */
-			     &gpio1 22 0>;	/* Bank1, pin22 */
+		col-gpios = <&gpio1 21 GPIO_ACTIVE_HIGH		/* Bank1, pin21 */
+			     &gpio1 22 GPIO_ACTIVE_HIGH>;	/* Bank1, pin22 */
 
 		linux,keymap = <0x0000008b	/* MENU */
 				0x0100009e	/* BACK */
@@ -183,14 +183,14 @@
 		switch@9 {
 			label = "volume-up";
 			linux,code = <115>;
-			gpios = <&gpio0 2 1>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			gpio-key,wakeup;
 		};
 
 		switch at 10 {
 			label = "volume-down";
 			linux,code = <114>;
-			gpios = <&gpio0 3 1>;
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 			gpio-key,wakeup;
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index a339a76..289ba2c 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -144,26 +144,26 @@
 
 		led at 1 {
 			label = "evmsk:green:usr0";
-			gpios = <&gpio1 4 0>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
 		led at 2 {
 			label = "evmsk:green:usr1";
-			gpios = <&gpio1 5 0>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
 		led at 3 {
 			label = "evmsk:green:mmc0";
-			gpios = <&gpio1 6 0>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		led at 4 {
 			label = "evmsk:green:heartbeat";
-			gpios = <&gpio1 7 0>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
@@ -177,26 +177,26 @@
 		switch at 1 {
 			label = "button0";
 			linux,code = <0x100>;
-			gpios = <&gpio2 3 0>;
+			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
 		};
 
 		switch at 2 {
 			label = "button1";
 			linux,code = <0x101>;
-			gpios = <&gpio2 2 0>;
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		switch at 3 {
 			label = "button2";
 			linux,code = <0x102>;
-			gpios = <&gpio0 30 0>;
+			gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
 			gpio-key,wakeup;
 		};
 
 		switch at 4 {
 			label = "button3";
 			linux,code = <0x103>;
-			gpios = <&gpio2 5 0>;
+			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 016c460..f116c79 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
-- 
1.7.5.4
