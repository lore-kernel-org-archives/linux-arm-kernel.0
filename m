From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 24 May 2017 17:29:20 -0700
Subject: [PATCH v7 05/34] ARM: dts: imx6qdl: Add compatible, clocks,
 irqs to MIPI CSI-2 node
In-Reply-To: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1495672189-29164-6-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to the MIPI CSI2 receiver node: compatible strings,
interrupt sources, and clocks.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 50534dd..dd9917c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1140,7 +1140,14 @@
 			};
 
 			mipi_csi: mipi at 021dc000 {
+				compatible = "fsl,imx6-mipi-csi2", "snps,dw-mipi-csi2";
 				reg = <0x021dc000 0x4000>;
+				interrupts = <0 100 0x04>, <0 101 0x04>;
+				clocks = <&clks IMX6QDL_CLK_HSI_TX>,
+					 <&clks IMX6QDL_CLK_VIDEO_27M>,
+					 <&clks IMX6QDL_CLK_EIM_PODF>;
+				clock-names = "dphy", "ref", "pix";
+				status = "disabled";
 			};
 
 			mipi_dsi: mipi at 021e0000 {
-- 
2.7.4
