From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 17 Dec 2014 11:02:24 +0100
Subject: [PATCH 2/2] ARM: DT: STiH407: Specify default clocks for HDMI devices
In-Reply-To: <1418810544-11405-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1418810544-11405-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1418810544-11405-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify default clocks for HDMI devices to ensure a maximum of
compatible frequencies.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5fd3c96..a7eb76c 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -292,6 +292,27 @@
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			assigned-clocks	= <&clk_s_d2_quadfs 0>,
+					  <&clk_s_d2_quadfs 0>,
+					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
+					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
+					  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
+					  <&clk_s_d2_flexgen CLK_PIX_GDP2>,
+					  <&clk_s_d2_flexgen CLK_PIX_GDP3>,
+					  <&clk_s_d2_flexgen CLK_PIX_GDP4>;
+
+			assigned-clock-parents = <0>,
+						 <0>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d2_quadfs 0>;
+
+			assigned-clock-rates = <297000000>, <297000000>;
+
 			ranges;
 
 			sti-compositor at 9d11000 {
@@ -334,6 +355,20 @@
 				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+
+				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+						  <&clk_s_d0_flexgen CLK_PCM_0>,
+						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+						  <&clk_s_d2_flexgen CLK_HDDAC>;
+
+				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
+							 <&clk_tmdsout_hdmi>,
+							 <&clk_s_d2_quadfs 0>,
+							 <&clk_s_d0_quadfs 0>,
+							 <&clk_s_d2_quadfs 0>,
+							 <&clk_s_d2_quadfs 0>;
 				ranges;
 
 				sti-hdmi at 8d04000 {
-- 
1.9.1
