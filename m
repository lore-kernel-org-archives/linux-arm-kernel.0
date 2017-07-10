From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 10 Jul 2017 08:12:05 +0200
Subject: [PATCH v2] ARM: dts: at91: sama5d2_xplained: use pin macros instead
 of numbers
In-Reply-To: <201707090720.uyYcbj17%fengguang.wu@intel.com>
References: <201707090720.uyYcbj17%fengguang.wu@intel.com>
Message-ID: <20170710061205.12921-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pin macros instead of magic numbers to ease interpretation.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

I have remove the unexpected brace removal from the first version of this patch.

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 2e2c3d1a1fa2..6eec8dc5143e 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -68,7 +68,7 @@
 
 	ahb {
 		usb0: gadget at 00300000 {
-			atmel,vbus-gpio = <&pioA 31 GPIO_ACTIVE_HIGH>;
+			atmel,vbus-gpio = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
@@ -76,8 +76,8 @@
 
 		usb1: ohci at 00400000 {
 			num-ports = <3>;
-			atmel,vbus-gpio = <0 /* &pioA 41 GPIO_ACTIVE_HIGH */
-					   &pioA 42 GPIO_ACTIVE_HIGH
+			atmel,vbus-gpio = <0 /* &pioA PIN_PB9 GPIO_ACTIVE_HIGH */
+					   &pioA PIN_PB10 GPIO_ACTIVE_HIGH
 					   0
 					  >;
 			pinctrl-names = "default";
@@ -127,7 +127,7 @@
 				ethernet-phy at 1 {
 					reg = <0x1>;
 					interrupt-parent = <&pioA>;
-					interrupts = <73 IRQ_TYPE_LEVEL_LOW>;
+					interrupts = <PIN_PC9 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 
@@ -160,9 +160,9 @@
 					compatible = "active-semi,act8945a";
 					reg = <0x5b>;
 					active-semi,vsel-high;
-					active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-					active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-					active-semi,irq_gpios = <&pioA 45 GPIO_ACTIVE_LOW>;
+					active-semi,chglev-gpios = <&pioA PIN_PA12 GPIO_ACTIVE_HIGH>;
+					active-semi,lbo-gpios = <&pioA PIN_PC8 GPIO_ACTIVE_LOW>;
+					active-semi,irq_gpios = <&pioA PIN_PB13 GPIO_ACTIVE_LOW>;
 					active-semi,input-voltage-threshold-microvolt = <6600>;
 					active-semi,precondition-timeout = <40>;
 					active-semi,total-timeout = <3>;
@@ -504,7 +504,7 @@
 
 		bp1 {
 			label = "PB_USER";
-			gpios = <&pioA 41 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
 			linux,code = <0x104>;
 		};
 	};
@@ -517,17 +517,18 @@
 
 		red {
 			label = "red";
-			gpios = <&pioA 38 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB6 GPIO_ACTIVE_LOW>;
 		};
 
+
 		green {
 			label = "green";
-			gpios = <&pioA 37 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB5 GPIO_ACTIVE_LOW>;
 		};
 
 		blue {
 			label = "blue";
-			gpios = <&pioA 32 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.12.2
