From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:24 +0800
Subject: [PATCH RFC 11/15] ARM: dtsi: imx6qdl: Add support for MIPI DSI host
 controller
In-Reply-To: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418200648-32656-12-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for MIPI DSI host controller.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 5d92ad7..4769767 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1006,7 +1006,14 @@
 			mipi_dsi: mipi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
+				compatible = "fsl,imx6q-mipi-dsi";
 				reg = <0x021e0000 0x4000>;
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+				gpr = <&gpr>;
+				clocks = <&clks IMX6QDL_CLK_VIDEO_27M>,
+					 <&clks IMX6QDL_CLK_HSI_TX>,
+					 <&clks IMX6QDL_CLK_HSI_TX>;
+				clock-names = "pllref", "pllref_gate", "core_cfg";
 				status = "disabled";
 
 				port at 0 {
-- 
2.1.0
