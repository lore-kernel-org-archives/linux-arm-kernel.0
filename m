From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 23 Mar 2014 20:35:01 +0100
Subject: [PATCH 1/2] ARM: shmobile: armadillo-reference dts: Use KEY_* macros
 for gpio-keys
Message-ID: <1395603302-32056-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 95a849bf921f..97342a4820cf 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "r8a7740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 
@@ -77,26 +78,26 @@
 
 		power-key {
 			gpios = <&pfc 99 GPIO_ACTIVE_LOW>;
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			label = "SW3";
 			gpio-key,wakeup;
 		};
 
 		back-key {
 			gpios = <&pfc 100 GPIO_ACTIVE_LOW>;
-			linux,code = <158>;
+			linux,code = <KEY_BACK>;
 			label = "SW4";
 		};
 
 		menu-key {
 			gpios = <&pfc 97 GPIO_ACTIVE_LOW>;
-			linux,code = <139>;
+			linux,code = <KEY_MENU>;
 			label = "SW5";
 		};
 
 		home-key {
 			gpios = <&pfc 98 GPIO_ACTIVE_LOW>;
-			linux,code = <102>;
+			linux,code = <KEY_HOME>;
 			label = "SW6";
 		};
 	};
-- 
1.7.9.5
