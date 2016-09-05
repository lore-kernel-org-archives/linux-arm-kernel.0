From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  5 Sep 2016 22:00:10 +0300
Subject: [PATCH] dt-binding: mrvl-gpio: remove orion-gpio description
Message-ID: <9d76063cb0b0a0ff96cfd6f389f3697db7734015.1473102010.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orion GPIO controller binding description in mrvl-gpio.txt is obsolete, and
duplicates the description in gpio-mvebu.txt.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/gpio/mrvl-gpio.txt         | 23 ----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index 98d198396956..c3d016532d8e 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -44,26 +44,3 @@ Example for a PXA3xx platform:
 		interrupt-controller;
 		#interrupt-cells = <0x2>;
 	};
-
-* Marvell Orion GPIO Controller
-
-Required properties:
-- compatible         : Should be "marvell,orion-gpio"
-- reg                : Address and length of the register set for controller.
-- gpio-controller    : So we know this is a gpio controller.
-- ngpio              : How many gpios this controller has.
-- interrupts	     : Up to 4 Interrupts for the controller.
-
-Optional properties:
-- mask-offset        : For SMP Orions, offset for Nth CPU
-
-Example:
-
-		gpio0: gpio at 10100 {
-			compatible = "marvell,orion-gpio";
-			#gpio-cells = <2>;
-			gpio-controller;
-			reg = <0x10100 0x40>;
-			ngpio = <32>;
-			interrupts = <35>, <36>, <37>, <38>;
-		};
-- 
2.9.3
