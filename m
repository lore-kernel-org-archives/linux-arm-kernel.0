From: shachimi@adeneo-embedded.com (HACHIMI Samir)
Date: Mon, 27 Aug 2012 17:34:31 +0200
Subject: [PATCH v2 1/2] imx6q: pwm: Add device tree support
In-Reply-To: <1346081672-27866-1-git-send-email-shachimi@adeneo-embedded.com>
References: <1346081672-27866-1-git-send-email-shachimi@adeneo-embedded.com>
Message-ID: <3465D313FDFB824F9A9C8CD24FA4F6BCB4ACFD@frontmail.adetel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samir Hachimi <shachimi@adeneo-embedded.com>

 Add clock look-up for pwm.
 Add the pinmux support for pwm.
 Several pin can be set to PwmO for the same Pwm.

Signed-off-by: Samir Hachimi <shachimi@adeneo-embedded.com>
---
 arch/arm/boot/dts/imx6q.dtsi |   68 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 925da33..346ae9c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -268,23 +268,43 @@
 			};
 
 			pwm at 02080000 { /* PWM1 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 0x04>;
+				clocks = <&clks 145>;
+				clock-names = "pwm";
+				status = "disabled";
 			};
 
 			pwm at 02084000 { /* PWM2 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 0x04>;
+				clocks = <&clks 146>;
+				clock-names = "pwm";
+				status = "disabled";
 			};
 
 			pwm at 02088000 { /* PWM3 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 0x04>;
+				clocks = <&clks 147>;
+				clock-names = "pwm";
+				status = "disabled";
 			};
 
 			pwm at 0208c000 { /* PWM4 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 0x04>;
+				clocks = <&clks 148>;
+				clock-names = "pwm";
+				status = "disabled";
 			};
 
 			flexcan at 02090000 { /* CAN1 */
@@ -584,6 +604,54 @@
 					};
 				};
 
+				pwm1 {
+				     	pinctrl_pwm1_1: pwm1grp-1 {
+						fsl,pins = <1543 0x80000000>;	/* MX6Q_PAD_SD1_DAT3__PWM1_PWMO */
+					};
+
+				     	pinctrl_pwm1_2: pwm1grp-2 {
+						fsl,pins = <971 0x80000000>;	/* MX6Q_PAD_GPIO_9__PWM1_PWMO */
+					};
+
+				     	pinctrl_pwm1_3: pwm1grp-3 {
+						fsl,pins = <574 0x80000000>;	/* MX6Q_PAD_DISP0_DAT8__PWM1_PWMO */
+					};
+				};
+
+				pwm2 {
+				     	pinctrl_pwm2_1: pwm2grp-1 {
+						fsl,pins = <1557 0x80000000>;	/* MX6Q_PAD_SD1_DAT2__PWM2_PWMO */
+					};
+
+				     	pinctrl_pwm2_2: pwm2grp-2 {
+						fsl,pins = <963 0x80000000>;	/* MX6Q_PAD_GPIO_1__PWM2_PWMO */
+					};
+
+				     	pinctrl_pwm2_3: pwm2grp-3 {
+						fsl,pins = <582 0x80000000>;	/* MX6Q_PAD_DISP0_DAT8__PWM2_PWMO */
+					};
+				};
+
+				pwm3 {
+				     	pinctrl_pwm3_1: pwm3grp-1 {
+						fsl,pins = <1471 0x80000000>;	/* MX6Q_PAD_SD4_DAT1__PWM3_PWMO */
+					};
+
+				     	pinctrl_pwm3_2: pwm3grp-2 {
+						fsl,pins = <1526 0x80000000>;	/* MX6Q_PAD_SD1_DAT1__PWM3_PWMO */
+					};
+				};
+
+				pwm4 {
+				     	pinctrl_pwm4_1: pwm4grp-1 {
+						fsl,pins = <1479 0x80000000>;	/* MX6Q_PAD_SD4_DAT2__PWM4_PWMO */
+					};
+
+				     	pinctrl_pwm4_2: pwm4grp-2 {
+						fsl,pins = <1550 0x80000000>;	/* MX6Q_PAD_SD1_CMD__PWM4_PWMO */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.1
