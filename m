From: diego.dorta@nxp.com (Diego Dorta)
Date: Fri, 17 Jun 2016 17:09:41 -0300
Subject: [PATCH 2/4] ARM: dts: imx7d-sdb: Add display support
In-Reply-To: <1466194183-31076-1-git-send-email-diego.dorta@nxp.com>
References: <1466194183-31076-1-git-send-email-diego.dorta@nxp.com>
Message-ID: <1466194183-31076-2-git-send-email-diego.dorta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the LCD8000-43T display.

Signed-off-by: Diego Dorta <diego.dorta@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index d6da506..c9cf9b0 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -272,6 +272,45 @@
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+
+			timing0: timing0 {
+				clock-frequency = <9200000>;
+				hactive = <480>;
+				vactive = <272>;
+				hfront-porch = <8>;
+				hback-porch = <4>;
+				hsync-len = <41>;
+				vback-porch = <2>;
+				vfront-porch = <4>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -396,6 +435,51 @@
 			>;
 		};
 
+		pinctrl_lcdif_dat: lcdifdatgrp {
+			fsl,pins = <
+				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			>;
+		};
+
+		pinctrl_lcdif_ctrl: lcdifctrlgrp {
+			fsl,pins = <
+				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+			>;
+		};
+
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO01__PWM1_OUT		0x110b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.7.4
