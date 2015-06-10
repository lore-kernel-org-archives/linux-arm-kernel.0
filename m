From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:04:03 +0100
Subject: [PATCH 6/9] ARM: STi: DT: Add STiH407 family tsin5 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tsin5 can only be configured for serial data transfer. However
depending on board design, two alternate tsin5 pin configurations
are available, both in pin-controller-front0.

pinctrl_tsin5_serial_alt1 is brought out on B2120 reference
design as TSD on NIMB slot of the B2004A daughter board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 702f42d..87d0722 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -546,6 +546,27 @@
 					};
 				};
 			};
+
+			tsin5 {
+				pinctrl_tsin5_serial_alt1: tsin5_serial_alt1 {
+					st,pins {
+						DATA7 = <&pio18 4 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio18 3 ALT1 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio18 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio18 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio18 2 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+				pinctrl_tsin5_serial_alt2: tsin5_serial_alt2 {
+					st,pins {
+						DATA7 = <&pio19 4 ALT2 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio19 3 ALT2 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio19 1 ALT2 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio19 0 ALT2 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio19 2 ALT2 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
-- 
1.9.1
