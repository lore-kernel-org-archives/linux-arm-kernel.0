From: b38611@freescale.com (Fugang Duan)
Date: Mon, 7 Sep 2015 10:55:01 +0800
Subject: [PATCH v3 3/4] ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d
 soc
In-Reply-To: <1441594502-19236-1-git-send-email-b38611@freescale.com>
References: <1441594502-19236-1-git-send-email-b38611@freescale.com>
Message-ID: <1441594502-19236-4-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fec1 and fec2 nodes for i.MX7d soc.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b738ce0..7631492 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -729,6 +729,42 @@
 				bus-width = <4>;
 				status = "disabled";
 			};
+
+			fec1: ethernet at 30be0000 {
+				compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
+				reg = <0x30be0000 0x10000>;
+				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
+					<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
+					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
+					<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+				clock-names = "ipg", "ahb", "ptp",
+					"enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<3>;
+				fsl,num-rx-queues=<3>;
+				status = "disabled";
+			};
+
+			fec2: ethernet at 30bf0000 {
+				compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
+				reg = <0x30bf0000 0x10000>;
+				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
+					<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
+					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
+					<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+				clock-names = "ipg", "ahb", "ptp",
+					"enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<3>;
+				fsl,num-rx-queues=<3>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.9.1
