From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 08:42:30 +0900
Subject: [PATCH] ARM: shmobile: Enable GPIO LEDs on Genmai
Message-ID: <20131113234230.1579.9739.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable led1 and led2 on the Genmai board using
the r7s72100 SoC and the GPIO RZ driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-13 22:39:40.000000000 +0900
@@ -9,7 +9,8 @@
  */
 
 /dts-v1/;
-/include/ "r7s72100.dtsi"
+#include "r7s72100.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Genmai";
@@ -28,4 +29,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&p4 10 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			gpios = <&p4 11 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
