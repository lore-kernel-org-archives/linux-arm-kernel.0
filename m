From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:04:06 +0100
Subject: [PATCH 9/9] ARM: STi: DT: Add STiH407 family mtsin0 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtsin0 channel can only be configured for parallel data transfer.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index af7f5f7..9494b35 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -607,6 +607,25 @@
 					};
 				};
 			};
+
+			mtsin0 {
+				pinctrl_mtsin0_parallel: mtsin0_parallel {
+					st,pins {
+						DATA7 = <&pio10 4 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA6 = <&pio10 5 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA5 = <&pio10 6 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA4 = <&pio10 7 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA3 = <&pio11 0 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA2 = <&pio11 1 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA1 = <&pio11 2 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						DATA0 = <&pio11 3 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio10 3 ALT3 IN CLKNOTDATA 0 CLK_A>;
+						VALID = <&pio10 1 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio10 0 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio10 2 ALT3 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
-- 
1.9.1
