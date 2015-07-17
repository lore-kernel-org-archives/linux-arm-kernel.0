From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 17 Jul 2015 13:45:10 +0200
Subject: [PATCH 2/2] drm: sti: adapt DT to fix probe/bind issues in DRM driver
In-Reply-To: <1437133510-13615-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1437133510-13615-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1437133510-13615-2-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STI drm drivers probe and bind using component framework was incorrect.
In addition to drivers fix DT update is needed to make all sub-components
become childs of sti-display-subsystem.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 82 +++++++++++++++++++++---------------------
 arch/arm/boot/dts/stih410.dtsi | 82 +++++++++++++++++++++---------------------
 2 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 3efa3b2..6b914e4 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -103,48 +103,46 @@
 							 <&clk_s_d0_quadfs 0>,
 							 <&clk_s_d2_quadfs 0>,
 							 <&clk_s_d2_quadfs 0>;
-				ranges;
-
-				sti-hdmi at 8d04000 {
-					compatible = "st,stih407-hdmi";
-					reg = <0x8d04000 0x1000>;
-					reg-names = "hdmi-reg";
-					interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
-					interrupt-names	= "irq";
-					clock-names = "pix",
-						      "tmds",
-						      "phy",
-						      "audio",
-						      "main_parent",
-						      "aux_parent";
-
-					clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-						 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-						 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-						 <&clk_s_d0_flexgen CLK_PCM_0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>;
-
-					hdmi,hpd-gpio = <&pio5 3>;
-					reset-names = "hdmi";
-					resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
-					ddc = <&hdmiddc>;
-
-				};
-
-				sti-hda at 8d02000 {
-					compatible = "st,stih407-hda";
-					reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
-					reg-names = "hda-reg", "video-dacs-ctrl";
-					clock-names = "pix",
-						      "hddac",
-						      "main_parent",
-						      "aux_parent";
-					clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-						 <&clk_s_d2_flexgen CLK_HDDAC>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>;
-				};
+			};
+
+			sti-hdmi at 8d04000 {
+				compatible = "st,stih407-hdmi";
+				reg = <0x8d04000 0x1000>;
+				reg-names = "hdmi-reg";
+				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+				interrupt-names	= "irq";
+				clock-names = "pix",
+					      "tmds",
+					      "phy",
+					      "audio",
+					      "main_parent",
+					      "aux_parent";
+
+				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+					 <&clk_s_d0_flexgen CLK_PCM_0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>;
+
+				hdmi,hpd-gpio = <&pio5 3>;
+				reset-names = "hdmi";
+				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
+				ddc = <&hdmiddc>;
+			};
+
+			sti-hda at 8d02000 {
+				compatible = "st,stih407-hda";
+				reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
+				reg-names = "hda-reg", "video-dacs-ctrl";
+				clock-names = "pix",
+					      "hddac",
+					      "main_parent",
+					      "aux_parent";
+				clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+					 <&clk_s_d2_flexgen CLK_HDDAC>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 208b5e8..bd1d66e 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -174,48 +174,46 @@
 							 <&clk_s_d0_quadfs 0>,
 							 <&clk_s_d2_quadfs 0>,
 							 <&clk_s_d2_quadfs 0>;
-				ranges;
-
-				sti-hdmi at 8d04000 {
-					compatible = "st,stih407-hdmi";
-					reg = <0x8d04000 0x1000>;
-					reg-names = "hdmi-reg";
-					interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
-					interrupt-names	= "irq";
-					clock-names = "pix",
-						      "tmds",
-						      "phy",
-						      "audio",
-						      "main_parent",
-						      "aux_parent";
-
-					clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-						 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-						 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-						 <&clk_s_d0_flexgen CLK_PCM_0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>;
-
-					hdmi,hpd-gpio = <&pio5 3>;
-					reset-names = "hdmi";
-					resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
-					ddc = <&hdmiddc>;
-
-				};
-
-				sti-hda at 8d02000 {
-					compatible = "st,stih407-hda";
-					reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
-					reg-names = "hda-reg", "video-dacs-ctrl";
-					clock-names = "pix",
-						      "hddac",
-						      "main_parent",
-						      "aux_parent";
-					clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-						 <&clk_s_d2_flexgen CLK_HDDAC>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>;
-				};
+			};
+
+			sti-hdmi at 8d04000 {
+				compatible = "st,stih407-hdmi";
+				reg = <0x8d04000 0x1000>;
+				reg-names = "hdmi-reg";
+				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+				interrupt-names	= "irq";
+				clock-names = "pix",
+					      "tmds",
+					      "phy",
+					      "audio",
+					      "main_parent",
+					      "aux_parent";
+
+				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+					 <&clk_s_d0_flexgen CLK_PCM_0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>;
+
+				hdmi,hpd-gpio = <&pio5 3>;
+				reset-names = "hdmi";
+				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
+				ddc = <&hdmiddc>;
+			};
+
+			sti-hda at 8d02000 {
+				compatible = "st,stih407-hda";
+				reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
+				reg-names = "hda-reg", "video-dacs-ctrl";
+				clock-names = "pix",
+					      "hddac",
+					      "main_parent",
+					      "aux_parent";
+				clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+					 <&clk_s_d2_flexgen CLK_HDDAC>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>;
 			};
 		};
 	};
-- 
1.9.1
