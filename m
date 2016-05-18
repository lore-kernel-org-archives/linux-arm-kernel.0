From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 18 May 2016 10:41:31 +0200
Subject: [PATCH 10/11] ARM: DT: STi: STiH407: clock configuration to address
 720p and 1080p
In-Reply-To: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1463560892-7209-11-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is necessary to properly configure these clocks in order
to address 720p and 1080p HDMI resolution.

Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index d60f0d8..291ffac 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -16,7 +16,10 @@
 			#size-cells = <1>;
 
 			assigned-clocks	= <&clk_s_d2_quadfs 0>,
-					  <&clk_s_d2_quadfs 0>,
+					  <&clk_s_d2_quadfs 1>,
+					  <&clk_s_c0_pll1 0>,
+					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
 					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
 					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
 					  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
@@ -26,14 +29,21 @@
 
 			assigned-clock-parents = <0>,
 						 <0>,
+						 <0>,
+						 <&clk_s_c0_pll1 0>,
+						 <&clk_s_c0_pll1 0>,
 						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 1>,
 						 <&clk_s_d2_quadfs 0>,
 						 <&clk_s_d2_quadfs 0>,
 						 <&clk_s_d2_quadfs 0>,
 						 <&clk_s_d2_quadfs 0>;
 
-			assigned-clock-rates = <297000000>, <297000000>;
+			assigned-clock-rates = <297000000>,
+					       <108000000>,
+					       <0>,
+					       <400000000>,
+					       <400000000>;
 
 			ranges;
 
-- 
1.9.1
