From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 21 Dec 2015 10:24:10 +0100
Subject: [PATCH 3/5] ARM: at91/dt: sama5d2: add adc device
In-Reply-To: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1450689852-22763-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ADC device.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 545264b..91c6e42 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -92,7 +92,7 @@
 		adc_op_clk: adc_op_clk{
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <1000000>;
+			clock-frequency = <6000000>;
 		};
 	};
 
@@ -1061,6 +1061,15 @@
 				status = "disabled";
 			};
 
+			adc: adc at fc030000 {
+				compatible = "atmel,sama5d2-adc";
+				reg = <0xfc030000 0x100>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&adc_clk>, <&adc_op_clk>;
+				clock-names = "adc_clk", "adc_op_clk";
+				status = "disabled";
+			};
+
 			pioA: pinctrl at fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.5.0
