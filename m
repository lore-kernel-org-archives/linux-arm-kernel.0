From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 18 May 2018 09:01:06 +0800
Subject: [PATCH V2 3/3] ARM: dts: imx7: correct enet ipg clock
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1526605266-18464-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ENET "ipg" clock should be IMX7D_ENETx_IPG_ROOT_CLK
rather than IMX7D_ENET_AXI_ROOT_CLK which is for ENET bus
clock.

Based on Andy Duan's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 2 +-
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..d74dd7f 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -120,7 +120,7 @@
 			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+		clocks = <&clks IMX7D_ENET2_IPG_ROOT_CLK>,
 			<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 			<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
 			<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..b90769d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1091,7 +1091,7 @@
 					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+				clocks = <&clks IMX7D_ENET1_IPG_ROOT_CLK>,
 					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 					<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
 					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-- 
2.7.4
