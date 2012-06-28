From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:44:58 +0800
Subject: [PATCH 02/11] ARM: dts: mxs: add hog-gpios for imx23-evk and imx28-evk
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before gpio_request can directly ask pinctrl system to configure the
requested pin into gpio mode, we use "hog" entry (pinctrl state of
pin controller itself) to configure gpios.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |   17 +++++++++++++++++
 arch/arm/boot/dts/imx28-evk.dts |   21 +++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 70bffa9..6a0912b 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -30,6 +30,23 @@
 				wp-gpios = <&gpio1 30 0>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1123 /* MX23_PAD_LCD_RESET__GPIO_1_18 */
+						0x11d3 /* MX23_PAD_PWM3__GPIO_1_29 */
+						0x11e3 /* MX23_PAD_PWM4__GPIO_1_30 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
 		};
 
 		apbx at 80040000 {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 319c75a..505ae5e 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -44,6 +44,27 @@
 				wp-gpios = <&gpio0 28 0>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x20d3 /* MX28_PAD_SSP1_CMD__GPIO_2_13 */
+						0x20f3 /* MX28_PAD_SSP1_DATA3__GPIO_2_15 */
+						0x40d3 /* MX28_PAD_ENET0_RX_CLK__GPIO_4_13 */
+						0x20c3 /* MX28_PAD_SSP1_SCK__GPIO_2_12 */
+						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
+						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
+						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
 		};
 
 		apbx at 80040000 {
-- 
1.7.5.4
