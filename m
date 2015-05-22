From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 22 May 2015 19:14:27 +0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabrelite: add Okaya LCD display
In-Reply-To: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1432314867-30888-3-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the 7" LCD display available for Sabrelite:
http://boundarydevices.com/product/7-800x480-display/

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index e00c44f..d5a25dc 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -130,6 +130,39 @@
 		status = "okay";
 	};
 
+	lcd_display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_j15>;
+		status = "okay";
+
+		port {
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		display-timings {
+			okaya_800x480 {
+				native-mode;
+				clock-frequency = <30000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				hfront-porch = <40>;
+				vback-porch = <29>;
+				vsync-len = <3>;
+				vfront-porch = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
 	panel {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
@@ -309,6 +342,39 @@
 			>;
 		};
 
+		pinctrl_j15: j15grp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			>;
+		};
+
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT3__PWM1_OUT 0x1b0b1
@@ -377,6 +443,10 @@
 	};
 };
 
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
 &ldb {
 	status = "okay";
 
-- 
2.1.4
