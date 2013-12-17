From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Dec 2013 14:03:14 +0900
Subject: [PATCH 03/04] ARM: shmobile: Genmai LED1 and LED2 support
In-Reply-To: <20131217050232.727.9552.sendpatchset@w520>
References: <20131217050232.727.9552.sendpatchset@w520>
Message-ID: <20131217050314.727.29564.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for Genmai board LED1 and LED2 via gpio-leds.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-27 15:49:27.000000000 +0900
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
+			gpios = <&port4 10 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
