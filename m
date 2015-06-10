From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:04:04 +0100
Subject: [PATCH 7/9] ARM: STi: DT: Add STiH407 family tsout0 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tsout0 channel can be configured for either serial or parallel
data transfer. Both pin configurations are provided.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 87d0722..85cd9fc 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -567,6 +567,34 @@
 					};
 				};
 			};
+
+			tsout0 {
+				pinctrl_tsout0_parallel: tsout0_parallel {
+					st,pins {
+						DATA7 = <&pio12 0 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA6 = <&pio12 1 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA5 = <&pio12 2 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA4 = <&pio12 3 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA3 = <&pio12 4 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA2 = <&pio12 5 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA1 = <&pio12 6 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						DATA0 = <&pio12 7 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio11 7 ALT3 OUT NICLK 0 CLK_A>;
+						VALID = <&pio11 5 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio11 4 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio11 6 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+				pinctrl_tsout0_serial: tsout0_serial {
+					st,pins {
+						DATA7 = <&pio12 0 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio11 7 ALT3 OUT NICLK 0 CLK_A>;
+						VALID = <&pio11 5 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio11 4 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio11 6 ALT3 OUT SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
-- 
1.9.1
