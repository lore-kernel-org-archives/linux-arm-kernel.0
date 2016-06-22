From: diego.dorta@nxp.com (Diego Dorta)
Date: Wed, 22 Jun 2016 16:37:07 -0300
Subject: [PATCH v2 1/4] ARM: dts: imx7d: Add SPI support
Message-ID: <1466624230-16191-1-git-send-email-diego.dorta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ecspi nodes and aliases.

Signed-off-by: Diego Dorta <diego.dorta@nxp.com>
---
Changes since v1:
- Removed "fsl,imx6sx-ecspi" from ecspi node.

 arch/arm/boot/dts/imx7d.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index d70d55d..9f088a8 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -69,6 +69,10 @@
 		serial4 = &uart5;
 		serial5 = &uart6;
 		serial6 = &uart7;
+		spi0 = &ecspi1;
+		spi1 = &ecspi2;
+		spi2 = &ecspi3;
+		spi3 = &ecspi4;
 	};
 
 	cpus {
@@ -608,6 +612,18 @@
 				status = "disabled";
 			};
 
+			ecspi4: ecspi at 30630000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+				reg = <0x30630000 0x10000>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ECSPI4_ROOT_CLK>,
+					<&clks IMX7D_ECSPI4_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			pwm1: pwm at 30660000 {
 				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
 				reg = <0x30660000 0x10000>;
@@ -671,6 +687,42 @@
 			reg = <0x30800000 0x400000>;
 			ranges;
 
+			ecspi1: ecspi at 30820000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+				reg = <0x30820000 0x10000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
+					<&clks IMX7D_ECSPI1_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			ecspi2: ecspi at 30830000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+				reg = <0x30830000 0x10000>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
+					<&clks IMX7D_ECSPI2_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			ecspi3: ecspi at 30840000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+				reg = <0x30840000 0x10000>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
+					<&clks IMX7D_ECSPI3_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
 			uart1: serial at 30860000 {
 				compatible = "fsl,imx7d-uart",
 					     "fsl,imx6q-uart";
-- 
2.7.4
