From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 17 May 2018 16:40:22 +0800
Subject: [PATCH 2/2] ARM: dts: imx7: correct enet clock settings
In-Reply-To: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
References: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1526546422-7431-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects ENET "ipg" and "enet_out"
clock settings according to clock driver's changes.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 4 ++--
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..92022ea 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -120,11 +120,11 @@
 			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		clocks = <&clks IMX7D_ENET2_IPG_ROOT_CLK>,
 			<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 			<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
 			<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-			<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+			<&clks IMX7D_ENET_PHY_REF_ROOT_DIV>;
 		clock-names = "ipg", "ahb", "ptp",
 			"enet_clk_ref", "enet_out";
 		fsl,num-tx-queues=<3>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..cf4ba53 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1091,11 +1091,11 @@
 					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+				clocks = <&clks IMX7D_ENET1_IPG_ROOT_CLK>,
 					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 					<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
 					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-					<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+					<&clks IMX7D_ENET_PHY_REF_ROOT_DIV>;
 				clock-names = "ipg", "ahb", "ptp",
 					"enet_clk_ref", "enet_out";
 				fsl,num-tx-queues=<3>;
-- 
2.7.4
