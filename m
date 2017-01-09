From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 9 Jan 2017 10:07:13 +0100
Subject: [PATCH v2 3/3] ARM: dts: stm32: Use clock DT binding definition on
 stm32f429 family
In-Reply-To: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
References: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1483952833-14704-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch uses clock DT binding definition instead numerical values
for stm32f429 board.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts |  2 +-
 arch/arm/boot/dts/stm32f429.dtsi     | 66 +++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 76f7206..4e31881 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -107,7 +107,7 @@
 	usbotg_hs_phy: usbphy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
-		clocks = <&rcc 0 30>;
+		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
 		clock-names = "main_clk";
 	};
 };
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 041e3fc..1bacdfb 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -49,6 +49,7 @@
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 #include <dt-bindings/clock/stm32fx-clock.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -82,7 +83,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
 			interrupts = <28>;
-			clocks = <&rcc 0 128>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM2)>;
 			status = "disabled";
 		};
 
@@ -90,7 +91,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000400 0x400>;
 			interrupts = <29>;
-			clocks = <&rcc 0 129>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM3)>;
 			status = "disabled";
 		};
 
@@ -98,7 +99,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000800 0x400>;
 			interrupts = <30>;
-			clocks = <&rcc 0 130>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM4)>;
 			status = "disabled";
 		};
 
@@ -106,14 +107,14 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
 			interrupts = <50>;
-			clocks = <&rcc 0 131>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM5)>;
 		};
 
 		timer6: timer at 40001000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40001000 0x400>;
 			interrupts = <54>;
-			clocks = <&rcc 0 132>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM6)>;
 			status = "disabled";
 		};
 
@@ -121,7 +122,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40001400 0x400>;
 			interrupts = <55>;
-			clocks = <&rcc 0 133>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM7)>;
 			status = "disabled";
 		};
 
@@ -129,7 +130,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
-			clocks =  <&rcc 0 145>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART2)>;
 			status = "disabled";
 		};
 
@@ -137,7 +138,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004800 0x400>;
 			interrupts = <39>;
-			clocks = <&rcc 0 146>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART3)>;
 			status = "disabled";
 			dmas = <&dma1 1 4 0x400 0x0>,
 			       <&dma1 3 4 0x400 0x0>;
@@ -148,7 +149,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40004c00 0x400>;
 			interrupts = <52>;
-			clocks = <&rcc 0 147>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART4)>;
 			status = "disabled";
 		};
 
@@ -156,7 +157,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40005000 0x400>;
 			interrupts = <53>;
-			clocks = <&rcc 0 148>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART5)>;
 			status = "disabled";
 		};
 
@@ -164,7 +165,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
 			interrupts = <82>;
-			clocks = <&rcc 0 158>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART7)>;
 			status = "disabled";
 		};
 
@@ -172,7 +173,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007c00 0x400>;
 			interrupts = <83>;
-			clocks = <&rcc 0 159>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(UART8)>;
 			status = "disabled";
 		};
 
@@ -180,7 +181,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
-			clocks = <&rcc 0 164>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(USART1)>;
 			status = "disabled";
 			dmas = <&dma2 2 4 0x400 0x0>,
 			       <&dma2 7 4 0x400 0x0>;
@@ -191,7 +192,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011400 0x400>;
 			interrupts = <71>;
-			clocks = <&rcc 0 165>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(USART6)>;
 			status = "disabled";
 		};
 
@@ -226,7 +227,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&rcc 0 0>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
 			};
 
@@ -234,7 +235,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x400 0x400>;
-				clocks = <&rcc 0 1>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
 			};
 
@@ -242,7 +243,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x800 0x400>;
-				clocks = <&rcc 0 2>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
 			};
 
@@ -250,7 +251,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0xc00 0x400>;
-				clocks = <&rcc 0 3>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
 			};
 
@@ -258,7 +259,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1000 0x400>;
-				clocks = <&rcc 0 4>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
 			};
 
@@ -266,7 +267,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1400 0x400>;
-				clocks = <&rcc 0 5>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
 			};
 
@@ -274,7 +275,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1800 0x400>;
-				clocks = <&rcc 0 6>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
 			};
 
@@ -282,7 +283,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1c00 0x400>;
-				clocks = <&rcc 0 7>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
 			};
 
@@ -290,7 +291,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2000 0x400>;
-				clocks = <&rcc 0 8>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
 			};
 
@@ -298,7 +299,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2400 0x400>;
-				clocks = <&rcc 0 9>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
 			};
 
@@ -306,7 +307,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2800 0x400>;
-				clocks = <&rcc 0 10>;
+				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
 			};
 
@@ -384,7 +385,7 @@
 				     <16>,
 				     <17>,
 				     <47>;
-			clocks = <&rcc 0 21>;
+			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(DMA1)>;
 			#dma-cells = <4>;
 		};
 
@@ -399,7 +400,7 @@
 				     <68>,
 				     <69>,
 				     <70>;
-			clocks = <&rcc 0 22>;
+			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(DMA2)>;
 			#dma-cells = <4>;
 			st,mem2mem;
 		};
@@ -411,7 +412,9 @@
 			interrupts = <61>;
 			interrupt-names = "macirq";
 			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
-			clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
+			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(ETHMAC)>,
+					<&rcc 0 STM32F4_AHB1_CLOCK(ETHMACTX)>,
+					<&rcc 0 STM32F4_AHB1_CLOCK(ETHMACRX)>;
 			st,syscon = <&syscfg 0x4>;
 			snps,pbl = <8>;
 			snps,mixed-burst;
@@ -422,7 +425,7 @@
 			compatible = "snps,dwc2";
 			reg = <0x40040000 0x40000>;
 			interrupts = <77>;
-			clocks = <&rcc 0 29>;
+			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHS)>;
 			clock-names = "otg";
 			status = "disabled";
 		};
@@ -431,12 +434,13 @@
 			compatible = "st,stm32-rng";
 			reg = <0x50060800 0x400>;
 			interrupts = <80>;
-			clocks = <&rcc 0 38>;
+			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(RNG)>;
+
 		};
 	};
 };
 
 &systick {
-	clocks = <&rcc 1 0>;
+	clocks = <&rcc 1 SYSTICK>;
 	status = "okay";
 };
-- 
1.9.1
