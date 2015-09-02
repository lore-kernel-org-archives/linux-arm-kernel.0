From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Sep 2015 15:16:20 -0300
Subject: [PATCH 1/3] ARM: dts: imx7d: Add PWM support
Message-ID: <1441217782-6304-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add the PWM1-4 nodes.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b738ce0..15c2193 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -570,6 +570,58 @@
 			};
 		};
 
+		aips2: aips-bus at 30400000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x30400000 0x400000>;
+			ranges;
+
+			pwm1: pwm at 30660000 {
+				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
+				reg = <0x30660000 0x10000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
+					 <&clks IMX7D_PWM1_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm2: pwm at 30670000 {
+				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
+				reg = <0x30670000 0x10000>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_PWM2_ROOT_CLK>,
+					 <&clks IMX7D_PWM2_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm3: pwm at 30680000 {
+				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
+				reg = <0x30680000 0x10000>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_PWM3_ROOT_CLK>,
+					 <&clks IMX7D_PWM3_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm4: pwm at 30690000 {
+				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
+				reg = <0x30690000 0x10000>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_PWM4_ROOT_CLK>,
+					 <&clks IMX7D_PWM4_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+		};
+
 		aips3: aips-bus at 30800000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
