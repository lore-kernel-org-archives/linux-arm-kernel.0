From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Mar 2014 20:17:24 +0100
Subject: [PATCHv3 7/8] ARM: at91/dt: sama5d3: remove useless adc properties
In-Reply-To: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394479045-31852-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver and fix
the atmel,adc-use-external-triggers property name.

Also, add #address-cells, #size-cells and a reg for each trigger to comply to
the ePAPR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi    | 13 +++++++------
 arch/arm/boot/dts/sama5d3xdm.dtsi |  1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 26d7ed510c96..73ad828296b2 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -239,6 +239,8 @@
 			};
 
 			adc0: adc at f8018000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "atmel,at91sam9x5-adc";
 				reg = <0xf8018000 0x100>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
@@ -261,35 +263,34 @@
 				clocks = <&adc_clk>,
 					 <&adc_op_clk>;
 				clock-names = "adc_clk", "adc_op_clk";
-				atmel,adc-channel-base = <0x50>;
 				atmel,adc-channels-used = <0xfff>;
-				atmel,adc-drdy-mask = <0x1000000>;
-				atmel,adc-num-channels = <12>;
 				atmel,adc-startup-time = <40>;
-				atmel,adc-status-register = <0x30>;
-				atmel,adc-trigger-register = <0xc0>;
-				atmel,adc-use-external;
+				atmel,adc-use-external-triggers;
 				atmel,adc-vref = <3000>;
 				atmel,adc-res = <10 12>;
 				atmel,adc-res-names = "lowres", "highres";
 				status = "disabled";
 
 				trigger at 0 {
+					reg = <0>;
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
 				trigger at 1 {
+					reg = <1>;
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
 				trigger at 2 {
+					reg = <2>;
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
 				trigger at 3 {
+					reg = <3>;
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
index 0b8f5d106ff2..035ab72b3990 100644
--- a/arch/arm/boot/dts/sama5d3xdm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xdm.dtsi
@@ -23,7 +23,6 @@
 			};
 
 			adc0: adc at f8018000 {
-				atmel,adc-clock-rate = <1000000>;
 				atmel,adc-ts-wires = <4>;
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "okay";
-- 
1.8.3.2
