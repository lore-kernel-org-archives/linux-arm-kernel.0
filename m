From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 11 Sep 2017 23:55:29 +0800
Subject: [PATCH 4/4] ARM: sunxi: h3/h5: add simplefb nodes
In-Reply-To: <20170911155529.62891-1-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
Message-ID: <20170911155529.62891-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3/H5 SoCs have a HDMI output and a TV Composite output.

Add simplefb nodes for these outputs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 76a4cbc99bdb..13850752dfda 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -53,6 +53,35 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer-hdmi {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer0-lcd0-hdmi";
+			clocks = <&display_clocks CLK_BUS_MIXER0>,
+				 <&ccu CLK_BUS_TCON0>, <&ccu CLK_BUS_HDMI>,
+				 <&display_clocks CLK_MIXER0>,
+				 <&ccu CLK_TCON0>, <&ccu CLK_HDMI>,
+				 <&ccu CLK_HDMI_DDC>;
+			status = "disabled";
+		};
+
+		framebuffer-tve {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer1-lcd1-tve";
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&ccu CLK_BUS_TCON1>, <&ccu CLK_BUS_TVE>,
+				 <&display_clocks CLK_MIXER1>,
+				 <&ccu CLK_TVE>;
+			status = "disabled";
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.13.5
