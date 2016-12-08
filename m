From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Dec 2016 16:57:42 -0800
Subject: [PATCH 01/12] ARM: dts: imx6qdl: Add compatible, clocks,
 irqs to MIPI CSI-2 node
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1481158673-15937-2-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to the MIPI CSI2 receiver node: compatible string, interrupt sources,
clocks.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2..e01e5d5 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1121,7 +1121,14 @@
 			};
 
 			mipi_csi: mipi at 021dc000 {
+				compatible = "fsl,imx-mipi-csi2";
 				reg = <0x021dc000 0x4000>;
+				interrupts = <0 100 0x04>, <0 101 0x04>;
+				clocks = <&clks IMX6QDL_CLK_HSI_TX>,
+					 <&clks IMX6QDL_CLK_VIDEO_27M>,
+					 <&clks IMX6QDL_CLK_EIM_SEL>;
+				clock-names = "dphy_clk", "cfg_clk", "pix_clk";
+				status = "disabled";
 			};
 
 			mipi_dsi: mipi at 021e0000 {
-- 
2.7.4
