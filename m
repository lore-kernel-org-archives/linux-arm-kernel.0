From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 12:20:59 +0100
Subject: [PATCH 3/3] ARM i.MX6: Add pwm support
In-Reply-To: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
References: <1353496859-29164-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1353496859-29164-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 69fe8f4..d907d06 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -268,23 +268,39 @@
 			};
 
 			pwm at 02080000 { /* PWM1 */
+				#pwm-cells = <2>;
+				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 0x04>;
+				clocks = <&clks 62>, <&clks 145>;
+				clock-names = "ipg", "per";
 			};
 
 			pwm at 02084000 { /* PWM2 */
+				#pwm-cells = <2>;
+				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 0x04>;
+				clocks = <&clks 62>, <&clks 146>;
+				clock-names = "ipg", "per";
 			};
 
 			pwm at 02088000 { /* PWM3 */
+				#pwm-cells = <2>;
+				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 0x04>;
+				clocks = <&clks 62>, <&clks 147>;
+				clock-names = "ipg", "per";
 			};
 
 			pwm at 0208c000 { /* PWM4 */
+				#pwm-cells = <2>;
+				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 0x04>;
+				clocks = <&clks 62>, <&clks 148>;
+				clock-names = "ipg", "per";
 			};
 
 			flexcan at 02090000 { /* CAN1 */
-- 
1.7.10.4
