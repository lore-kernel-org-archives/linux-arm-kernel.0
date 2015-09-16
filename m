From: plaes@plaes.org (Priit Laes)
Date: Wed, 16 Sep 2015 10:59:37 +0300
Subject: [PATCH 1/4] ARM: dts: sun4i: gemei-g9: Add accelerometer (bma250) IRQ
Message-ID: <1442390380-1406-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index ad4b65c..c0006b8 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -47,6 +47,7 @@
 #include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Gemei G9 Tablet";
@@ -64,7 +65,7 @@
 /*
  * TODO:
  *   2x cameras via CSI
- *   bma250 IRQs
+ *   audio
  *   AXP battery management
  *   NAND
  *   OTG
@@ -108,12 +109,8 @@
 	bma250 at 18 {
 		compatible = "bosch,bma250";
 		reg = <0x18>;
-
-		/*
-		 * TODO: interrupt pins:
-		 * int1 - PH00
-		 * int2 - PI10
-		 */
+		interrupt-parent = <&pio>;
+		interrupts = <7 0 IRQ_TYPE_EDGE_RISING>; /* PH00 / EINT0 */
 	};
 };
 
-- 
2.5.2
