From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:24 +0100
Subject: [PATCH 07/14] ARM: dts: imx6ul: add pwm[1-4] nodes
In-Reply-To: <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 863777e..40ea5f0 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -248,6 +248,50 @@
 				status = "disabled";
 			};
 
+			pwm1: pwm at 02080000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02080000 0x4000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM1>,
+					 <&clks IMX6UL_CLK_PWM1>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm2: pwm at 02084000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02084000 0x4000>;
+				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM2>,
+					 <&clks IMX6UL_CLK_PWM2>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm3: pwm at 02088000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02088000 0x4000>;
+				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM3>,
+					 <&clks IMX6UL_CLK_PWM3>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm4: pwm at 0208c000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x0208c000 0x4000>;
+				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM4>,
+					 <&clks IMX6UL_CLK_PWM4>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
 			gpt1: gpt at 02098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
-- 
2.1.4
