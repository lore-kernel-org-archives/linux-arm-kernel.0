From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:39 +0800
Subject: [PATCH RFC v9 16/20] ARM: dtsi: imx6qdl: Add support for MIPI DSI
 host controller
In-Reply-To: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423720903-24806-17-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for MIPI DSI host controller.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v8->v9:
 * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
 * To address Philipp's comment, mention that a common compatible string
   "snps,dw-mipi-dsi" should be appended.
 * To address Philipp's comment, add a new required clock pclk and clean up
   clock-names.

v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * None.

v3->v4:
 * None.

v2->v3:
 * As suggested by Phillip Zabel, change the clocks and the clock-names
   properties to use the pllref and core_cfg clocks only.

v1->v2:
 * None.

 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 55aced8..0a4d7f7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1020,7 +1020,14 @@
 			mipi_dsi: mipi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
+				compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
 				reg = <0x021e0000 0x4000>;
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+				gpr = <&gpr>;
+				clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+					 <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+					 <&clks IMX6QDL_CLK_MIPI_IPG>;
+				clock-names = "ref", "cfg", "pclk";
 				status = "disabled";
 
 				ports {
-- 
2.1.0
