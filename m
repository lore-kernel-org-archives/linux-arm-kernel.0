From: b38611@freescale.com (Fugang Duan)
Date: Fri, 17 Jul 2015 16:38:23 +0800
Subject: [PATCH v1 3/4] ARM: dts: imx: add fec1 and fec2 nodes for SOC i.MX6UL
In-Reply-To: <1437122304-20598-1-git-send-email-b38611@freescale.com>
References: <1437122304-20598-1-git-send-email-b38611@freescale.com>
Message-ID: <1437122304-20598-4-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SOC i.MX6UL has two ethernet MACs, add fec1 and fec2 support for i.MX6UL.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index dc0f5b4..3190e6c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -14,6 +14,8 @@
 
 / {
 	aliases {
+		ethernet0 = &fec1;
+		ethernet1 = &fec2;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
@@ -293,6 +295,23 @@
 				#interrupt-cells = <2>;
 			};
 
+			fec2: ethernet at 020b4000 {
+				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
+				reg = <0x020b4000 0x4000>;
+				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ENET>,
+					 <&clks IMX6UL_CLK_ENET_AHB>,
+					 <&clks IMX6UL_CLK_ENET_PTP>,
+					 <&clks IMX6UL_CLK_ENET2_REF_125M>,
+					 <&clks IMX6UL_CLK_ENET2_REF_125M>;
+				clock-names = "ipg", "ahb", "ptp",
+					      "enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<1>;
+				fsl,num-rx-queues=<1>;
+				status = "disabled";
+			};
+
 			wdog1: wdog at 020bc000 {
 				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
@@ -484,6 +503,24 @@
 			reg = <0x02100000 0x100000>;
 			ranges;
 
+			fec1: ethernet at 02188000 {
+				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
+				reg = <0x02188000 0x4000>;
+				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ENET>,
+					 <&clks IMX6UL_CLK_ENET_AHB>,
+					 <&clks IMX6UL_CLK_ENET_PTP>,
+					 <&clks IMX6UL_CLK_ENET_REF>,
+					 <&clks IMX6UL_CLK_ENET_REF>;
+				clock-names = "ipg", "ahb", "ptp",
+					      "enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<1>;
+				fsl,num-rx-queues=<1>;
+				status = "disabled";
+			};
+
+
 			usdhc1: usdhc at 02190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
-- 
1.9.1
