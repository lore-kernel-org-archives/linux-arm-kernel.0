From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 14 Jan 2016 16:38:15 +0100
Subject: [PATCH v3 3/5] ARM: at91/dt: sama5d2: add adc device
In-Reply-To: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1452785897-16270-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ADC device, and remove the adc_op_clk which is useless since the
adc sampling frequency is configured with sysfs.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 3f750f6..46dd430 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -88,12 +88,6 @@
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
-
-		adc_op_clk: adc_op_clk{
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <1000000>;
-		};
 	};
 
 	ns_sram: sram at 00200000 {
@@ -1085,6 +1079,18 @@
 				status = "disabled";
 			};
 
+			adc: adc at fc030000 {
+				compatible = "atmel,sama5d2-adc";
+				reg = <0xfc030000 0x100>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&adc_clk>;
+				clock-names = "adc_clk";
+				atmel,min-sample-rate-hz = <200000>;
+				atmel,max-sample-rate-hz = <20000000>;
+				atmel,startup-time-ms = <4>;
+				status = "disabled";
+			};
+
 			pioA: pinctrl at fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.5.0
