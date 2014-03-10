From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Mar 2014 20:17:21 +0100
Subject: [PATCHv3 4/8] ARM: at91/dt: at91sam9260: remove useless adc properties
In-Reply-To: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394479045-31852-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Also, add #address-cells, #size-cells and a reg for each trigger to comply to
the ePAPR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 997901f7ed73..366fc2cbcd64 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -608,37 +608,38 @@
 			};
 
 			adc0: adc at fffe0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xf>;
 				atmel,adc-vref = <3300>;
-				atmel,adc-num-channels = <4>;
 				atmel,adc-startup-time = <15>;
-				atmel,adc-channel-base = <0x30>;
-				atmel,adc-drdy-mask = <0x10000>;
-				atmel,adc-status-register = <0x1c>;
-				atmel,adc-trigger-register = <0x04>;
 				atmel,adc-res = <8 10>;
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
 				trigger at 0 {
+					reg = <0>;
 					trigger-name = "timer-counter-0";
 					trigger-value = <0x1>;
 				};
 				trigger at 1 {
+					reg = <1>;
 					trigger-name = "timer-counter-1";
 					trigger-value = <0x3>;
 				};
 
 				trigger at 2 {
+					reg = <2>;
 					trigger-name = "timer-counter-2";
 					trigger-value = <0x5>;
 				};
 
 				trigger at 3 {
+					reg = <3>;
 					trigger-name = "external";
 					trigger-value = <0x13>;
 					trigger-external;
-- 
1.8.3.2
