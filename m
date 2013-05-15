From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 May 2013 16:03:05 +0200
Subject: [PATCH 5/5] ARM: at91: dt: switch to standard IRQ flag defines
In-Reply-To: <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130515135821.GG22508@game.jcrosoft.org>
 <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1368626585-24425-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  |   45 +++++++++++---------
 arch/arm/boot/dts/at91sam9260.dtsi |   49 ++++++++++++----------
 arch/arm/boot/dts/at91sam9263.dtsi |   43 ++++++++++----------
 arch/arm/boot/dts/at91sam9g45.dtsi |   49 +++++++++++-----------
 arch/arm/boot/dts/at91sam9n12.dtsi |   41 ++++++++++---------
 arch/arm/boot/dts/at91sam9x5.dtsi  |   55 +++++++++++++------------
 arch/arm/boot/dts/sama5d3.dtsi     |   79 ++++++++++++++++++------------------
 7 files changed, 188 insertions(+), 173 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 361a957..4aad0d9 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -12,6 +12,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -79,25 +80,29 @@
 			st: timer at fffffd00 {
 				compatible = "atmel,at91rm9200-st";
 				reg = <0xfffffd00 0x100>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			tcb0: timer at fffa0000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa0000 0x100>;
-				interrupts = <17 4 0 18 4 0 19 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
+					      18 IRQ_TYPE_LEVEL_HIGH 0
+					      19 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at fffa4000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa4000 0x100>;
-				interrupts = <20 4 0 21 4 0 22 4 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0
+					      21 IRQ_TYPE_LEVEL_HIGH 0
+					      22 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			i2c0: i2c at fffb8000 {
 				compatible = "atmel,at91rm9200-i2c";
 				reg = <0xfffb8000 0x4000>;
-				interrupts = <12 4 6>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 6>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_twi>;
 				#address-cells = <1>;
@@ -108,7 +113,7 @@
 			mmc0: mmc at fffb4000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffb4000 0x4000>;
-				interrupts = <10 4 0>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -117,7 +122,7 @@
 			ssc0: ssc at fffd0000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd0000 0x4000>;
-				interrupts = <14 4 5>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disable";
@@ -126,7 +131,7 @@
 			ssc1: ssc at fffd4000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd4000 0x4000>;
-				interrupts = <15 4 5>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disable";
@@ -135,7 +140,7 @@
 			ssc2: ssc at fffd8000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffd8000 0x4000>;
-				interrupts = <16 4 5>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
 				status = "disable";
@@ -144,7 +149,7 @@
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at91rm9200-emac", "cdns,emac";
 				reg = <0xfffbc000 0x4000>;
-				interrupts = <24 4 3>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
 				phy-mode = "rmii";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
@@ -396,7 +401,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -406,7 +411,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -416,7 +421,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -426,7 +431,7 @@
 				pioD: gpio at fffffa00 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <5 4 1>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -437,7 +442,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -446,7 +451,7 @@
 			usart0: serial at fffc0000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc0000 0x200>;
-				interrupts = <6 4 5>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -457,7 +462,7 @@
 			usart1: serial at fffc4000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc4000 0x200>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -468,7 +473,7 @@
 			usart2: serial at fffc8000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc8000 0x200>;
-				interrupts = <8 4 5>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -479,7 +484,7 @@
 			usart3: serial at fffcc000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffcc000 0x200>;
-				interrupts = <23 4 5>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -490,7 +495,7 @@
 			usb1: gadget at fffb0000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffb0000 0x4000>;
-				interrupts = <11 4 2>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
 				status = "disabled";
 			};
 		};
@@ -515,7 +520,7 @@
 		usb0: ohci at 00300000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00300000 0x100000>;
-			interrupts = <23 4 2>;
+			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7edadf3..a776f50 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -10,6 +10,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -86,19 +87,23 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			tcb0: timer at fffa0000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffa0000 0x100>;
-				interrupts = <17 4 0 18 4 0 19 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
+					      18 IRQ_TYPE_LEVEL_HIGH 0
+					      19 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at fffdc000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffdc000 0x100>;
-				interrupts = <26 4 0 27 4 0 28 4 0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0
+					      27 IRQ_TYPE_LEVEL_HIGH 0
+					      28 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			pinctrl at fffff400 {
@@ -345,7 +350,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -355,7 +360,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -365,7 +370,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -376,7 +381,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -385,7 +390,7 @@
 			usart0: serial at fffb0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb0000 0x200>;
-				interrupts = <6 4 5>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -396,7 +401,7 @@
 			usart1: serial at fffb4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb4000 0x200>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -407,7 +412,7 @@
 			usart2: serial at fffb8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
-				interrupts = <8 4 5>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -418,7 +423,7 @@
 			usart3: serial at fffd0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd0000 0x200>;
-				interrupts = <23 4 5>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -429,7 +434,7 @@
 			uart0: serial at fffd4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd4000 0x200>;
-				interrupts = <24 4 5>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -440,7 +445,7 @@
 			uart1: serial at fffd8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd8000 0x200>;
-				interrupts = <25 4 5>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -451,7 +456,7 @@
 			macb0: ethernet at fffc4000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffc4000 0x100>;
-				interrupts = <21 4 3>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
@@ -460,14 +465,14 @@
 			usb1: gadget at fffa4000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffa4000 0x4000>;
-				interrupts = <10 4 2>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
 				status = "disabled";
 			};
 
 			i2c0: i2c at fffac000 {
 				compatible = "atmel,at91sam9260-i2c";
 				reg = <0xfffac000 0x100>;
-				interrupts = <11 4 6>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -476,7 +481,7 @@
 			mmc0: mmc at fffa8000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffa8000 0x600>;
-				interrupts = <9 4 0>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -485,7 +490,7 @@
 			ssc0: ssc at fffbc000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfffbc000 0x4000>;
-				interrupts = <14 4 5>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -496,7 +501,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfffc8000 0x200>;
-				interrupts = <12 4 3>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -507,7 +512,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfffcc000 0x200>;
-				interrupts = <13 4 3>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
@@ -516,7 +521,7 @@
 			adc0: adc at fffe0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
-				interrupts = <5 4 0>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xf>;
 				atmel,adc-vref = <3300>;
@@ -579,7 +584,7 @@
 		usb0: ohci at 00500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
-			interrupts = <20 4 2>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index bb4d7ca..d9cf51a 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -8,6 +8,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -74,13 +75,13 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			tcb0: timer at fff7c000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
-				interrupts = <19 4 0>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			rstc at fffffd00 {
@@ -326,7 +327,7 @@
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -336,7 +337,7 @@
 				pioB: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -346,7 +347,7 @@
 				pioC: gpio at fffff600 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -356,7 +357,7 @@
 				pioD: gpio at fffff800 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -366,7 +367,7 @@
 				pioE: gpio at fffffa00 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -377,7 +378,7 @@
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -386,7 +387,7 @@
 			usart0: serial at fff8c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff8c000 0x200>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -397,7 +398,7 @@
 			usart1: serial at fff90000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff90000 0x200>;
-				interrupts = <8 4 5>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -408,7 +409,7 @@
 			usart2: serial at fff94000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff94000 0x200>;
-				interrupts = <9 4 5>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -419,7 +420,7 @@
 			ssc0: ssc at fff98000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff98000 0x4000>;
-				interrupts = <16 4 5>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -428,7 +429,7 @@
 			ssc1: ssc at fff9c000 {
 				compatible = "atmel,at91rm9200-ssc";
 				reg = <0xfff9c000 0x4000>;
-				interrupts = <17 4 5>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disabled";
@@ -437,7 +438,7 @@
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
-				interrupts = <21 4 3>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
@@ -446,14 +447,14 @@
 			usb1: gadget at fff78000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfff78000 0x4000>;
-				interrupts = <24 4 2>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 2>;
 				status = "disabled";
 			};
 
 			i2c0: i2c at fff88000 {
 				compatible = "atmel,at91sam9263-i2c";
 				reg = <0xfff88000 0x100>;
-				interrupts = <13 4 6>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -462,7 +463,7 @@
 			mmc0: mmc at fff80000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
-				interrupts = <10 4 0>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -471,7 +472,7 @@
 			mmc1: mmc at fff84000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff84000 0x600>;
-				interrupts = <11 4 0>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -488,7 +489,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfffa4000 0x200>;
-				interrupts = <14 4 3>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -499,7 +500,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xfffa8000 0x200>;
-				interrupts = <15 4 3>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
@@ -527,7 +528,7 @@
 		usb0: ohci at 00a00000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
-			interrupts = <29 4 2>;
+			interrupts = <29 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 8ba4c71..f0091af 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -11,6 +11,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -85,7 +86,7 @@
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 
@@ -97,19 +98,19 @@
 			tcb0: timer at fff7c000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
-				interrupts = <18 4 0>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at fffd4000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfffd4000 0x100>;
-				interrupts = <18 4 0>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
-				interrupts = <21 4 0>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
@@ -346,7 +347,7 @@
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -356,7 +357,7 @@
 				pioB: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -366,7 +367,7 @@
 				pioC: gpio at fffff600 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <4 4 1>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -376,7 +377,7 @@
 				pioD: gpio at fffff800 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <5 4 1>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -386,7 +387,7 @@
 				pioE: gpio at fffffa00 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <5 4 1>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -397,7 +398,7 @@
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -406,7 +407,7 @@
 			usart0: serial at fff8c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff8c000 0x200>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -417,7 +418,7 @@
 			usart1: serial at fff90000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff90000 0x200>;
-				interrupts = <8 4 5>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -428,7 +429,7 @@
 			usart2: serial at fff94000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff94000 0x200>;
-				interrupts = <9 4 5>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -439,7 +440,7 @@
 			usart3: serial at fff98000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff98000 0x200>;
-				interrupts = <10 4 5>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
@@ -450,7 +451,7 @@
 			macb0: ethernet at fffbc000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xfffbc000 0x100>;
-				interrupts = <25 4 3>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
 				status = "disabled";
@@ -459,7 +460,7 @@
 			i2c0: i2c at fff84000 {
 				compatible = "atmel,at91sam9g10-i2c";
 				reg = <0xfff84000 0x100>;
-				interrupts = <12 4 6>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -468,7 +469,7 @@
 			i2c1: i2c at fff88000 {
 				compatible = "atmel,at91sam9g10-i2c";
 				reg = <0xfff88000 0x100>;
-				interrupts = <13 4 6>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -477,7 +478,7 @@
 			ssc0: ssc at fff9c000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfff9c000 0x4000>;
-				interrupts = <16 4 5>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -486,7 +487,7 @@
 			ssc1: ssc at fffa0000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xfffa0000 0x4000>;
-				interrupts = <17 4 5>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disabled";
@@ -495,7 +496,7 @@
 			adc0: adc at fffb0000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffb0000 0x100>;
-				interrupts = <20 4 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xff>;
 				atmel,adc-vref = <3300>;
@@ -535,7 +536,7 @@
 			mmc0: mmc at fff80000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfff80000 0x600>;
-				interrupts = <11 4 0>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma 1 0>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -546,7 +547,7 @@
 			mmc1: mmc at fffd0000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffd0000 0x600>;
-				interrupts = <29 4 0>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma 1 13>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -604,14 +605,14 @@
 		usb0: ohci at 00700000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00700000 0x100000>;
-			interrupts = <22 4 2>;
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 
 		usb1: ehci at 00800000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00800000 0x100000>;
-			interrupts = <22 4 2>;
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index e166e0c..566af32 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -9,6 +9,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -79,7 +80,7 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			shdwc at fffffe10 {
@@ -90,7 +91,7 @@
 			mmc0: mmc at f0008000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
-				interrupts = <12 4 0>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma 1 0>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -101,19 +102,19 @@
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
-				interrupts = <17 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at f800c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
-				interrupts = <17 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
-				interrupts = <20 4 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
@@ -287,7 +288,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -297,7 +298,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -307,7 +308,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -317,7 +318,7 @@
 				pioD: gpio at fffffa00 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -328,7 +329,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -337,7 +338,7 @@
 			ssc0: ssc at f0010000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
-				interrupts = <28 4 5>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -346,7 +347,7 @@
 			usart0: serial at f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x4000>;
-				interrupts = <5 4 5>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -355,7 +356,7 @@
 			usart1: serial at f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x4000>;
-				interrupts = <6 4 5>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -364,7 +365,7 @@
 			usart2: serial at f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x4000>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -373,7 +374,7 @@
 			usart3: serial at f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x4000>;
-				interrupts = <8 4 5>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
@@ -382,7 +383,7 @@
 			i2c0: i2c at f8010000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
-				interrupts = <9 4 6>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma 1 13>,
 				       <&dma 1 14>;
 				dma-names = "tx", "rx";
@@ -394,7 +395,7 @@
 			i2c1: i2c at f8014000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
-				interrupts = <10 4 6>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma 1 15>,
 				       <&dma 1 16>;
 				dma-names = "tx", "rx";
@@ -408,7 +409,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0000000 0x100>;
-				interrupts = <13 4 3>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -419,7 +420,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
-				interrupts = <14 4 3>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
@@ -450,7 +451,7 @@
 		usb0: ohci at 00500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
-			interrupts = <22 4 2>;
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cfbf923..af91599 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -11,6 +11,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -87,32 +88,32 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 
 			tcb0: timer at f8008000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
-				interrupts = <17 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			tcb1: timer at f800c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
-				interrupts = <17 4 0>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			dma0: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
-				interrupts = <20 4 0>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
 			dma1: dma-controller at ffffee00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffee00 0x200>;
-				interrupts = <21 4 0>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
@@ -416,7 +417,7 @@
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -426,7 +427,7 @@
 				pioB: gpio at fffff600 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x200>;
-					interrupts = <2 4 1>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					#gpio-lines = <19>;
@@ -437,7 +438,7 @@
 				pioC: gpio at fffff800 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -447,7 +448,7 @@
 				pioD: gpio at fffffa00 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x200>;
-					interrupts = <3 4 1>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					#gpio-lines = <22>;
@@ -459,7 +460,7 @@
 			ssc0: ssc at f0010000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
-				interrupts = <28 4 5>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -468,7 +469,7 @@
 			mmc0: mmc at f0008000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf0008000 0x600>;
-				interrupts = <12 4 0>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 1 0>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -479,7 +480,7 @@
 			mmc1: mmc at f000c000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf000c000 0x600>;
-				interrupts = <26 4 0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma1 1 0>;
 				dma-names = "rxtx";
 				#address-cells = <1>;
@@ -490,7 +491,7 @@
 			dbgu: serial at fffff200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -499,7 +500,7 @@
 			usart0: serial at f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x200>;
-				interrupts = <5 4 5>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -508,7 +509,7 @@
 			usart1: serial at f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x200>;
-				interrupts = <6 4 5>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -517,7 +518,7 @@
 			usart2: serial at f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x200>;
-				interrupts = <7 4 5>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -526,7 +527,7 @@
 			macb0: ethernet at f802c000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
-				interrupts = <24 4 3>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_rmii>;
 				status = "disabled";
@@ -535,14 +536,14 @@
 			macb1: ethernet at f8030000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf8030000 0x100>;
-				interrupts = <27 4 3>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 3>;
 				status = "disabled";
 			};
 
 			i2c0: i2c at f8010000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8010000 0x100>;
-				interrupts = <9 4 6>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma0 1 7>,
 				       <&dma0 1 8>;
 				dma-names = "tx", "rx";
@@ -556,7 +557,7 @@
 			i2c1: i2c at f8014000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8014000 0x100>;
-				interrupts = <10 4 6>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma1 1 5>,
 				       <&dma1 1 6>;
 				dma-names = "tx", "rx";
@@ -570,7 +571,7 @@
 			i2c2: i2c at f8018000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf8018000 0x100>;
-				interrupts = <11 4 6>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma0 1 9>,
 				       <&dma0 1 10>;
 				dma-names = "tx", "rx";
@@ -584,7 +585,7 @@
 			adc0: adc at f804c000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf804c000 0x100>;
-				interrupts = <19 4 0>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
 				atmel,adc-use-external;
 				atmel,adc-channels-used = <0xffff>;
 				atmel,adc-vref = <3300>;
@@ -627,7 +628,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0000000 0x100>;
-				interrupts = <13 4 3>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
 				status = "disabled";
@@ -638,7 +639,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91rm9200-spi";
 				reg = <0xf0004000 0x100>;
-				interrupts = <14 4 3>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
 				status = "disabled";
@@ -647,7 +648,7 @@
 			rtc at fffffeb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffeb0 0x40>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				status = "disabled";
 			};
 		};
@@ -676,14 +677,14 @@
 		usb0: ohci at 00600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
-			interrupts = <22 4 2>;
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 
 		usb1: ehci at 00700000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
-			interrupts = <22 4 2>;
+			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 05a3380..c00e158 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -10,6 +10,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -61,7 +62,7 @@
 			mmc0: mmc at f0000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf0000000 0x600>;
-				interrupts = <21 4 0>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 2 0>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
@@ -76,7 +77,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91sam9x5-spi";
 				reg = <0xf0004000 0x100>;
-				interrupts = <24 4 3>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
 				cs-gpios = <&pioD 13 0
 					    &pioD 14 0 /* conflicts with SCK0 and CANRX0 */
 					    &pioD 15 0 /* conflicts with CTS0 and CANTX0 */
@@ -90,7 +91,7 @@
 			ssc0: ssc@f0008000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0008000 0x4000>;
-				interrupts = <38 4 4>;
+				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 4>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
@@ -99,7 +100,7 @@
 			can0: can at f000c000 {
 				compatible = "atmel,at91sam9x5-can";
 				reg = <0xf000c000 0x300>;
-				interrupts = <40 4 3>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_rx_tx>;
 				status = "disabled";
@@ -108,13 +109,13 @@
 			tcb0: timer at f0010000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf0010000 0x100>;
-				interrupts = <26 4 0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			i2c0: i2c at f0014000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0014000 0x4000>;
-				interrupts = <18 4 6>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma0 2 7>,
 				       <&dma0 2 8>;
 				dma-names = "tx", "rx";
@@ -128,7 +129,7 @@
 			i2c1: i2c at f0018000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf0018000 0x4000>;
-				interrupts = <19 4 6>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma0 2 9>,
 				       <&dma0 2 10>;
 				dma-names = "tx", "rx";
@@ -142,7 +143,7 @@
 			usart0: serial at f001c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf001c000 0x100>;
-				interrupts = <12 4 5>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
 				status = "disabled";
@@ -151,7 +152,7 @@
 			usart1: serial at f0020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf0020000 0x100>;
-				interrupts = <13 4 5>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
 				status = "disabled";
@@ -160,7 +161,7 @@
 			macb0: ethernet at f0028000 {
 				compatible = "cnds,pc302-gem", "cdns,gem";
 				reg = <0xf0028000 0x100>;
-				interrupts = <34 4 3>;
+				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_data_rgmii &pinctrl_macb0_signal_rgmii>;
 				status = "disabled";
@@ -169,14 +170,14 @@
 			isi: isi at f0034000 {
 				compatible = "atmel,at91sam9g45-isi";
 				reg = <0xf0034000 0x4000>;
-				interrupts = <37 4 5>;
+				interrupts = <37 IRQ_TYPE_LEVEL_HIGH 5>;
 				status = "disabled";
 			};
 
 			mmc1: mmc at f8000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf8000000 0x600>;
-				interrupts = <22 4 0>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma1 2 0>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
@@ -189,7 +190,7 @@
 			mmc2: mmc at f8004000 {
 				compatible = "atmel,hsmci";
 				reg = <0xf8004000 0x600>;
-				interrupts = <23 4 0>;
+				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma1 2 1>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
@@ -204,7 +205,7 @@
 				#size-cells = <0>;
 				compatible = "atmel,at91sam9x5-spi";
 				reg = <0xf8008000 0x100>;
-				interrupts = <25 4 3>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 3>;
 				cs-gpios = <&pioC 25 0
 					    &pioC 26 0 /* conflitcs with TWD1 and ISI_D11 */
 					    &pioC 27 0 /* conflitcs with TWCK1 and ISI_D10 */
@@ -218,7 +219,7 @@
 			ssc1: ssc@f800c000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf800c000 0x4000>;
-				interrupts = <39 4 4>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 4>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				status = "disabled";
@@ -227,7 +228,7 @@
 			can1: can at f8010000 {
 				compatible = "atmel,at91sam9x5-can";
 				reg = <0xf8010000 0x300>;
-				interrupts = <41 4 3>;
+				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_rx_tx>;
 			};
@@ -235,13 +236,13 @@
 			tcb1: timer at f8014000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8014000 0x100>;
-				interrupts = <27 4 0>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			adc0: adc at f8018000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf8018000 0x100>;
-				interrupts = <29 4 5>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <
 					&pinctrl_adc0_adtrg
@@ -295,7 +296,7 @@
 			tsadcc: tsadcc@f8018000 {
 				compatible = "atmel,at91sam9x5-tsadcc";
 				reg = <0xf8018000 0x4000>;
-				interrupts = <29 4 5>;
+				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,tsadcc_clock = <300000>;
 				atmel,filtering_average = <0x03>;
 				atmel,pendet_debounce = <0x08>;
@@ -307,7 +308,7 @@
 			i2c2: i2c at f801c000 {
 				compatible = "atmel,at91sam9x5-i2c";
 				reg = <0xf801c000 0x4000>;
-				interrupts = <20 4 6>;
+				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 6>;
 				dmas = <&dma1 2 11>,
 				       <&dma1 2 12>;
 				dma-names = "tx", "rx";
@@ -319,7 +320,7 @@
 			usart2: serial at f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x100>;
-				interrupts = <14 4 5>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
 				status = "disabled";
@@ -328,7 +329,7 @@
 			usart3: serial at f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x100>;
-				interrupts = <15 4 5>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
 				status = "disabled";
@@ -337,7 +338,7 @@
 			macb1: ethernet at f802c000 {
 				compatible = "cdns,at32ap7000-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
-				interrupts = <35 4 3>;
+				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb1_rmii>;
 				status = "disabled";
@@ -346,7 +347,7 @@
 			sha at f8034000 {
 				compatible = "atmel,sam9g46-sha";
 				reg = <0xf8034000 0x100>;
-				interrupts = <42 4 0>;
+				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			aes at f8038000 {
@@ -358,20 +359,20 @@
 			tdes at f803c000 {
 				compatible = "atmel,sam9g46-tdes";
 				reg = <0xf803c000 0x100>;
-				interrupts = <44 4 0>;
+				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
 			};
 
 			dma0: dma-controller at ffffe600 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
-				interrupts = <30 4 0>;
+				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
 			dma1: dma-controller at ffffe800 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe800 0x200>;
-				interrupts = <31 4 0>;
+				interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
 			};
 
@@ -383,7 +384,7 @@
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-				interrupts = <2 4 7>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				status = "disabled";
@@ -817,7 +818,7 @@
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x100>;
-					interrupts = <6 4 1>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -827,7 +828,7 @@
 				pioB: gpio at fffff400 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x100>;
-					interrupts = <7 4 1>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -837,7 +838,7 @@
 				pioC: gpio at fffff600 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff600 0x100>;
-					interrupts = <8 4 1>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -847,7 +848,7 @@
 				pioD: gpio at fffff800 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffff800 0x100>;
-					interrupts = <9 4 1>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -857,7 +858,7 @@
 				pioE: gpio at fffffa00 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfffffa00 0x100>;
-					interrupts = <10 4 1>;
+					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
 					#gpio-cells = <2>;
 					gpio-controller;
 					interrupt-controller;
@@ -878,7 +879,7 @@
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-				interrupts = <3 4 5>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
 			};
 
 			watchdog at fffffe40 {
@@ -890,7 +891,7 @@
 			rtc at fffffeb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffeb0 0x30>;
-				interrupts = <1 4 7>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
 		};
 
@@ -900,7 +901,7 @@
 			compatible = "atmel,at91sam9rl-udc";
 			reg = <0x00500000 0x100000
 			       0xf8030000 0x4000>;
-			interrupts = <33 4 2>;
+			interrupts = <33 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 
 			ep0 {
@@ -1012,14 +1013,14 @@
 		usb1: ohci at 00600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
-			interrupts = <32 4 2>;
+			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 
 		usb2: ehci at 00700000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
-			interrupts = <32 4 2>;
+			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
 			status = "disabled";
 		};
 
@@ -1035,7 +1036,7 @@
 				0xffffc000 0x00000070	/* NFC HSMC regs */
 				0x00200000 0x00100000	/* NFC SRAM banks */
 				>;
-			interrupts = <5 4 6>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
 			atmel,nand-addr-offset = <21>;
 			atmel,nand-cmd-offset = <22>;
 			pinctrl-names = "default";
-- 
1.7.10.4
