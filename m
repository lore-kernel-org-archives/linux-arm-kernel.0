From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 25 Aug 2014 16:44:47 +0200
Subject: [RESEND PATCH 3/4] ARM: STi: DT: STiH407: 407 DT Entry for clockgen
 D0/D2/D3
In-Reply-To: <1408977888-10473-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1408977888-10473-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1408977888-10473-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds DT entries for clockgen D0/D2/D3

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 126 +++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 85cc135..6e59011 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -139,5 +139,131 @@
 						     "clk-compo-dvp";
 			};
 		};
+
+		clk_s_d0_quadfs: clk-s-d0-quadfs at 9104000 {
+			#clock-cells = <1>;
+			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			reg = <0x9104000 0x1000>;
+
+			clocks = <&clk_sysin>;
+
+			clock-output-names = "clk-s-d0-fs0-ch0",
+					     "clk-s-d0-fs0-ch1",
+					     "clk-s-d0-fs0-ch2",
+					     "clk-s-d0-fs0-ch3";
+		};
+
+		clockgen-d0 at 09104000 {
+			compatible = "st,clkgen-c32";
+			reg = <0x9104000 0x1000>;
+
+			clk_s_d0_flexgen: clk-s-d0-flexgen {
+				#clock-cells = <1>;
+				compatible = "st,flexgen";
+
+				clocks = <&clk_s_d0_quadfs 0>,
+					 <&clk_s_d0_quadfs 1>,
+					 <&clk_s_d0_quadfs 2>,
+					 <&clk_s_d0_quadfs 3>,
+					 <&clk_sysin>;
+
+				clock-output-names = "clk-pcm-0",
+						     "clk-pcm-1",
+						     "clk-pcm-2",
+						     "clk-spdiff";
+			};
+		};
+
+		clk_s_d2_quadfs: clk-s-d2-quadfs at 9106000 {
+			#clock-cells = <1>;
+			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			reg = <0x9106000 0x1000>;
+
+			clocks = <&clk_sysin>;
+
+			clock-output-names = "clk-s-d2-fs0-ch0",
+					     "clk-s-d2-fs0-ch1",
+					     "clk-s-d2-fs0-ch2",
+					     "clk-s-d2-fs0-ch3";
+		};
+
+		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		clockgen-d2 at x9106000 {
+			compatible = "st,clkgen-c32";
+			reg = <0x9106000 0x1000>;
+
+			clk_s_d2_flexgen: clk-s-d2-flexgen {
+				#clock-cells = <1>;
+				compatible = "st,flexgen";
+
+				clocks = <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>,
+					 <&clk_s_d2_quadfs 2>,
+					 <&clk_s_d2_quadfs 3>,
+					 <&clk_sysin>,
+					 <&clk_sysin>,
+					 <&clk_tmdsout_hdmi>;
+
+				clock-output-names = "clk-pix-main-disp",
+						     "clk-pix-pip",
+						     "clk-pix-gdp1",
+						     "clk-pix-gdp2",
+						     "clk-pix-gdp3",
+						     "clk-pix-gdp4",
+						     "clk-pix-aux-disp",
+						     "clk-denc",
+						     "clk-pix-hddac",
+						     "clk-hddac",
+						     "clk-sddac",
+						     "clk-pix-dvo",
+						     "clk-dvo",
+						     "clk-pix-hdmi",
+						     "",
+						     "clk-ref-hdmiphy";
+						     };
+		};
+
+		clk_s_d3_quadfs: clk-s-d3-quadfs at 9107000 {
+			#clock-cells = <1>;
+			compatible = "st,stih407-quadfs660-D", "st,quadfs";
+			reg = <0x9107000 0x1000>;
+
+			clocks = <&clk_sysin>;
+
+			clock-output-names = "clk-s-d3-fs0-ch0",
+					     "clk-s-d3-fs0-ch1",
+					     "clk-s-d3-fs0-ch2",
+					     "clk-s-d3-fs0-ch3";
+		};
+
+		clockgen-d3 at 9107000 {
+			compatible = "st,clkgen-c32";
+			reg = <0x9107000 0x1000>;
+
+			clk_s_d3_flexgen: clk-s-d3-flexgen {
+				#clock-cells = <1>;
+				compatible = "st,flexgen";
+
+				clocks = <&clk_s_d3_quadfs 0>,
+					 <&clk_s_d3_quadfs 1>,
+					 <&clk_s_d3_quadfs 2>,
+					 <&clk_s_d3_quadfs 3>,
+					 <&clk_sysin>;
+
+				clock-output-names = "clk-stfe-frc1",
+						     "clk-tsout-0",
+						     "clk-tsout-1",
+						     "clk-mchi",
+						     "clk-vsens-compo",
+						     "clk-frc1-remote",
+						     "clk-lpc-0",
+						     "clk-lpc-1";
+			};
+		};
 	};
 };
-- 
1.9.1
