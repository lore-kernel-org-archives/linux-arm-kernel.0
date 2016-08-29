From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:27:06 +0200
Subject: [PATCH v3 14/14] ARM: DT: STi: STiH410: clock configuration to
 address 720p and 1080p
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-15-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

It is necessary to properly configure these clocks in order
to address 720p and 1080p HDMI resolution.

Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih410.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 18ed1ad..7eec729 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -103,7 +103,10 @@
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
@@ -113,14 +116,21 @@
 
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
