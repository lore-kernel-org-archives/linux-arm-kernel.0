From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Aug 2012 13:25:32 -0300
Subject: [PATCH 2/3] ARM: mxs: Let mmc0 pin detect be generic
In-Reply-To: <1345652733-13265-1-git-send-email-festevam@gmail.com>
References: <1345652733-13265-1-git-send-email-festevam@gmail.com>
Message-ID: <1345652733-13265-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of assigning SSP1_DETECT inside mmc0_4bit_pins_a, let the board dts
handle this setup.

Not every board will use MX23_PAD_SSP1_DETECT as SSP1 functionality. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-evk.dts |    1 +
 arch/arm/boot/dts/imx23.dtsi    |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 1093dd5..035c13f 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -48,6 +48,7 @@
 						0x1123 /* MX23_PAD_LCD_RESET__GPIO_1_18 */
 						0x11d3 /* MX23_PAD_PWM3__GPIO_1_29 */
 						0x11e3 /* MX23_PAD_PWM4__GPIO_1_30 */
+						0x2010 /* MX23_PAD_SSP1_DETECT__SSP1_DETECT */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 9700872..b00f3cf 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -194,7 +194,6 @@
 						0x2040 /* MX23_PAD_SSP1_DATA2__SSP1_DATA2 */
 						0x2050 /* MX23_PAD_SSP1_DATA3__SSP1_DATA3 */
 						0x2000 /* MX23_PAD_SSP1_CMD__SSP1_CMD */
-						0x2010 /* MX23_PAD_SSP1_DETECT__SSP1_DETECT */
 						0x2060 /* MX23_PAD_SSP1_SCK__SSP1_SCK */
 					>;
 					fsl,drive-strength = <1>;
-- 
1.7.9.5
