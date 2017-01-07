From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri,  6 Jan 2017 18:11:20 -0800
Subject: [PATCH v3 02/24] ARM: dts: imx6qdl: Add compatible, clocks,
 irqs to MIPI CSI-2 node
In-Reply-To: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1483755102-24785-3-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to the MIPI CSI2 receiver node: compatible string, interrupt sources,
clocks.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 53e6e63..42926e9 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1125,7 +1125,14 @@
 			};
 
 			mipi_csi: mipi at 021dc000 {
+				compatible = "fsl,imx6-mipi-csi2";
 				reg = <0x021dc000 0x4000>;
+				interrupts = <0 100 0x04>, <0 101 0x04>;
+				clocks = <&clks IMX6QDL_CLK_HSI_TX>,
+					 <&clks IMX6QDL_CLK_VIDEO_27M>,
+					 <&clks IMX6QDL_CLK_EIM_SEL>;
+				clock-names = "dphy", "cfg", "pix";
+				status = "disabled";
 			};
 
 			mipi_dsi: mipi at 021e0000 {
-- 
2.7.4
