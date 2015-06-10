From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:04:02 +0100
Subject: [PATCH 5/9] ARM: STi: DT: Add STiH407 family tsin4 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tsin4 can only be configured for serial data transfer. However
depending on board design, two alternate pin configurations
are available. One in pin-controller-front0 and the other in
pin-controller-front1.

pinctrl_tsin4_serial_alt3 is brought out on B2120 reference
design as TSC on NIMA slot of the B2004A daughter board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 13b469c..702f42d 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -534,6 +534,18 @@
 					};
 				};
 			};
+
+			tsin4 {
+				pinctrl_tsin4_serial_alt3: tsin4_serial_alt3 {
+					st,pins {
+						DATA7 = <&pio14 6 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio14 5 ALT3 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio14 3 ALT3 IN SE_NICLK_IO 0 CLK_B>;
+						ERROR = <&pio14 2 ALT3 IN SE_NICLK_IO 0 CLK_B>;
+						PKCLK = <&pio14 4 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
@@ -547,6 +559,18 @@
 			interrupts-names = "irqmux";
 			ranges = <0 0x09210000 0x10000>;
 
+			tsin4 {
+				pinctrl_tsin4_serial_alt1: tsin4_serial_alt1 {
+					st,pins {
+						DATA7 = <&pio20 4 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio20 3 ALT1 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio20 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio20 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio20 2 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
+
 			pio20: pio at 09210000 {
 				gpio-controller;
 				#gpio-cells = <1>;
-- 
1.9.1
