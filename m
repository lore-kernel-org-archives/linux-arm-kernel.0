From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Feb 2015 13:10:10 -0200
Subject: [PATCH] ARM: dts: imx25-pdk: Add LCD support
Message-ID: <1424531410-25768-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add support for the CLAA057VC01CW display.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 9c21b15..4a72978 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -21,6 +21,27 @@
 		reg = <0x80000000 0x4000000>;
 	};
 
+	wvga: display {
+		model = "CLAA057VC01CW";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfa208b80>;
+		bus-width = <18>;
+		native-mode = <&wvga_timings>;
+		display-timings {
+			wvga_timings: 640x480 {
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <45>;
+				hfront-porch = <114>;
+				hsync-len = <1>;
+				vback-porch = <33>;
+				vfront-porch = <11>;
+				vsync-len = <1>;
+				clock-frequency = <25200000>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -98,6 +119,16 @@
 	status = "okay";
 };
 
+&lcdc {
+	display = <&wvga>;
+	fsl,lpccr = <0x00a903ff>;
+	fsl,lscr1 = <0x00120300>;
+	fsl,dmacr = <0x00020010>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd>;
+	status = "okay";
+};
+
 &fec {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
@@ -170,6 +201,36 @@
 			>;
 		};
 
+		pinctrl_lcd: lcdgrp {
+			fsl,pins = <
+				MX25_PAD_LD0__LD0		0xe0
+				MX25_PAD_LD1__LD1		0xe0
+				MX25_PAD_LD2__LD2		0xe0
+				MX25_PAD_LD3__LD3		0xe0
+				MX25_PAD_LD4__LD4		0xe0
+				MX25_PAD_LD5__LD5		0xe0
+				MX25_PAD_LD6__LD6		0xe0
+				MX25_PAD_LD7__LD7		0xe0
+				MX25_PAD_LD8__LD8		0xe0
+				MX25_PAD_LD9__LD9		0xe0
+				MX25_PAD_LD10__LD10		0xe0
+				MX25_PAD_LD11__LD11		0xe0
+				MX25_PAD_LD12__LD12		0xe0
+				MX25_PAD_LD13__LD13		0xe0
+				MX25_PAD_LD14__LD14		0xe0
+				MX25_PAD_LD15__LD15		0xe0
+				MX25_PAD_GPIO_E__LD16		0xe0
+				MX25_PAD_GPIO_F__LD17		0xe0
+				MX25_PAD_HSYNC__HSYNC		0xe0
+				MX25_PAD_VSYNC__VSYNC		0xe0
+				MX25_PAD_LSCLK__LSCLK		0xe0
+				MX25_PAD_OE_ACD__OE_ACD		0xe0
+				MX25_PAD_CONTRAST__CONTRAST	0xe0
+			>;
+		};
+
+
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX25_PAD_I2C1_CLK__I2C1_CLK		0x80000000
-- 
1.9.1
