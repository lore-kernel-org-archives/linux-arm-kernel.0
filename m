From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 29 Dec 2014 14:39:24 +0800
Subject: [PATCH RFC v6 17/21] ARM: dtsi: imx6qdl: Add support for MIPI DSI
 host controller
In-Reply-To: <1419835168-9034-1-git-send-email-Ying.Liu@freescale.com>
References: <1419835168-9034-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419835168-9034-18-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for MIPI DSI host controller.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v5->v6:
 * None.

v3->v4:
 * None.

v2->v3:
 * As suggested by Phillip Zabel, change the clocks and the clock-names
   properties to use the pllref and core_cfg clocks only.

v1->v2:
 * None.

 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 96bf2a0..7b1c313 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1006,7 +1006,13 @@
 			mipi_dsi: mipi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
+				compatible = "fsl,imx6q-mipi-dsi";
 				reg = <0x021e0000 0x4000>;
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+				gpr = <&gpr>;
+				clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+					 <&clks IMX6QDL_CLK_MIPI_CORE_CFG>;
+				clock-names = "pllref", "core_cfg";
 				status = "disabled";
 
 				ports {
-- 
2.1.0
