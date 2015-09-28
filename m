From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:46 +0100
Subject: [PATCH v2 10/11] ARM: DT: STiH407: Add RMII pinctrl support
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-11-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the RMII pinctrl support for the Synopsys
MAC on STiH407 SoCs.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 9daab1f..881e94a 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -256,6 +256,33 @@
 						phyclk = <&pio2 3 ALT1 OUT NICLK 0 CLK_A>;
 					};
 				};
+
+				pinctrl_rmii1: rmii1-0 {
+					st,pins {
+						txd0 = <&pio0 0 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						txd1 = <&pio0 1 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						txen = <&pio0 5 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						mdio = <&pio1 0 ALT1 OUT BYPASS 0>;
+						mdc = <&pio1 1 ALT1 OUT NICLK 0 CLK_A>;
+						mdint = <&pio1 3 ALT1 IN BYPASS 0>;
+						rxd0 = <&pio1 4 ALT1 IN SE_NICLK_IO 0 CLK_B>;
+						rxd1 = <&pio1 5 ALT1 IN SE_NICLK_IO 0 CLK_B>;
+						rxdv = <&pio2 0 ALT1 IN SE_NICLK_IO 0 CLK_B>;
+						rx_er = <&pio2 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+
+				pinctrl_rmii1_phyclk: rmii1_phyclk {
+					st,pins {
+						phyclk = <&pio2 3 ALT1 OUT NICLK 0 CLK_A>;
+					};
+				};
+
+				pinctrl_rmii1_phyclk_ext: rmii1_phyclk_ext {
+					st,pins {
+						phyclk = <&pio2 3 ALT2 IN NICLK 0 CLK_A>;
+					};
+				};
 			};
 
 			pwm1 {
-- 
1.9.1
