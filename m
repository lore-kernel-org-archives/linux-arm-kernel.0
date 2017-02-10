From: fugang.duan@nxp.com (Andy Duan)
Date: Fri, 10 Feb 2017 22:27:44 +0800
Subject: [PATCH v1 2/2] ARM: dts: imx7d: correct enet ipg and enet_out clock
In-Reply-To: <1486736864-21908-1-git-send-email-fugang.duan@nxp.com>
References: <1486736864-21908-1-git-send-email-fugang.duan@nxp.com>
Message-ID: <1486736864-21908-3-git-send-email-fugang.duan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enet ipg clocks should be IMX7D_ENET1_IPG_ROOT_CLK/IMX7D_ENET2_IPG_ROOT_CLK
that has the same parent clock as IMX7D_ENET_AXI_ROOT_CLK, but different CCGR
clock gate. enet_out clock should be IMX7D_ENET_PHY_REF_ROOT_DIV according
to i.MX7D RM CCM clock tree.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx7d.dtsi | 4 ++--
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f6dee41..9ea3ba3 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -116,11 +116,11 @@
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
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
index 5d3a43b..14b175b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -984,11 +984,11 @@
 				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
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
1.9.1
