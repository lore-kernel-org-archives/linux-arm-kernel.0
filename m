From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:03:58 +0100
Subject: [PATCH 1/9] ARM: STi: DT: Add STiH407 family tsin0 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tsin0 and be configured as either serial or parallel. This patch
adds the pinctrl config for both possiblities. On B2120 reference
design tsin0 is brought out as TSA on the NIMA slot of the B2004A
daughter board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 402844c..c8c8e84 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -438,6 +438,34 @@
 					};
 				};
 			};
+
+			tsin0 {
+				pinctrl_tsin0_parallel: tsin0_parallel {
+					st,pins {
+						DATA7 = <&pio10 4 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA6 = <&pio10 5 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA5 = <&pio10 6 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA4 = <&pio10 7 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA3 = <&pio11 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA2 = <&pio11 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA1 = <&pio11 2 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						DATA0 = <&pio11 3 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio10 3 ALT1 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio10 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio10 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio10 2 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+				pinctrl_tsin0_serial: tsin0_serial {
+					st,pins {
+						DATA7 = <&pio10 4 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio10 3 ALT1 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio10 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio10 0 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio10 2 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
-- 
1.9.1
