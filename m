From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  4 Jun 2014 17:30:19 +0100
Subject: [PATCH v3 05/10] ARM: STi: DT: Add sdhci pin configuration for stih415
In-Reply-To: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1401899424-1365-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required pin config for the sdhci controller
present in the stih415 SoC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index caeac7e..eee2373 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -429,6 +429,27 @@
 					};
 				};
 			};
+
+			mmc0 {
+				pinctrl_mmc0: mmc0 {
+					st,pins {
+						mmcclk = <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
+						data0  = <&PIO14 4 ALT4 BIDIR_PU BYPASS 0>;
+						data1  = <&PIO14 5 ALT4 BIDIR_PU BYPASS 0>;
+						data2  = <&PIO14 6 ALT4 BIDIR_PU BYPASS 0>;
+						data3  = <&PIO14 7 ALT4 BIDIR_PU BYPASS 0>;
+						cmd    = <&PIO15 1 ALT4 BIDIR_PU BYPASS 0>;
+						wp     = <&PIO15 3 ALT4 IN>;
+						data4  = <&PIO16 4 ALT4 BIDIR_PU BYPASS 0>;
+						data5  = <&PIO16 5 ALT4 BIDIR_PU BYPASS 0>;
+						data6  = <&PIO16 6 ALT4 BIDIR_PU BYPASS 0>;
+						data7  = <&PIO16 7 ALT4 BIDIR_PU BYPASS 0>;
+						pwr    = <&PIO17 1 ALT4 OUT>;
+						cd     = <&PIO17 2 ALT4 IN>;
+						led    = <&PIO17 3 ALT4 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-left {
-- 
1.9.1
