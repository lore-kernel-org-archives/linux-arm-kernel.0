From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:43 +0900
Subject: [PATCH 15/33] ARM: shmobile: armadillo-reference dts: Use KEY_*
 macros for gpio-keys
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <c9b60e922c7551ff1c477a121ad09f3790c1a575.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 95a849b..97342a4 100644
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
1.8.5.2
