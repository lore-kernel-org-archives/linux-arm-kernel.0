From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 13 Jul 2018 14:49:04 +0200
Subject: [PATCH 3/3] ARM: dts: imx6sx-nitrogen6sx: remove obsolete display
 configuration
In-Reply-To: <20180713124904.9285-1-gary.bisson@boundarydevices.com>
References: <20180713124904.9285-1-gary.bisson@boundarydevices.com>
Message-ID: <20180713124904.9285-4-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This display configuration isn't working as-is as it depends on the
tfp410 LCD to HDMI bridge. This will need to be updated later once
the DRM MXSFB driver will be the default.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts | 71 ------------------------
 1 file changed, 71 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index f81ddfa46ace..adb5cc7d8ce2 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -11,11 +11,6 @@
 	model = "Boundary Devices i.MX6 SoloX Nitrogen6sx Board";
 	compatible = "boundary,imx6sx-nitrogen6sx", "fsl,imx6sx";
 
-	aliases {
-		fb-lcd = &lcdif1;
-		t-lcd = &t_lcd;
-	};
-
 	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
@@ -225,38 +220,6 @@
 	status = "okay";
 };
 
-&lcdif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif1>;
-	lcd-supply = <&reg_3p3v>;
-	display = <&display0>;
-	status = "okay";
-
-	display0: display0 {
-		bits-per-pixel = <16>;
-		bus-width = <24>;
-
-		display-timings {
-			native-mode = <&t_lcd>;
-			t_lcd: t_lcd_default {
-				clock-frequency = <74160000>;
-				hactive = <1280>;
-				vactive = <720>;
-				hback-porch = <220>;
-				hfront-porch = <110>;
-				vback-porch = <20>;
-				vfront-porch = <5>;
-				hsync-len = <40>;
-				vsync-len = <5>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-		};
-	};
-};
-
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
@@ -488,40 +451,6 @@
 		>;
 	};
 
-	pinctrl_lcdif1: lcdif1grp {
-		fsl,pins = <
-			MX6SX_PAD_LCD1_CLK__LCDIF1_CLK		0x4001b0b0
-			MX6SX_PAD_LCD1_ENABLE__LCDIF1_ENABLE	0x4001b0b0
-			MX6SX_PAD_LCD1_HSYNC__LCDIF1_HSYNC	0x4001b0b0
-			MX6SX_PAD_LCD1_VSYNC__LCDIF1_VSYNC	0x4001b0b0
-			MX6SX_PAD_LCD1_RESET__GPIO3_IO_27	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA00__LCDIF1_DATA_0	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA01__LCDIF1_DATA_1	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA02__LCDIF1_DATA_2	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA03__LCDIF1_DATA_3	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA04__LCDIF1_DATA_4	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA05__LCDIF1_DATA_5	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA06__LCDIF1_DATA_6	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA07__LCDIF1_DATA_7	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA08__LCDIF1_DATA_8	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA09__LCDIF1_DATA_9	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA10__LCDIF1_DATA_10	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA11__LCDIF1_DATA_11	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA12__LCDIF1_DATA_12	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA13__LCDIF1_DATA_13	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA14__LCDIF1_DATA_14	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA15__LCDIF1_DATA_15	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA16__LCDIF1_DATA_16	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA17__LCDIF1_DATA_17	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA18__LCDIF1_DATA_18	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA19__LCDIF1_DATA_19	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA20__LCDIF1_DATA_20	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA21__LCDIF1_DATA_21	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA22__LCDIF1_DATA_22	0x4001b0b0
-			MX6SX_PAD_LCD1_DATA23__LCDIF1_DATA_23	0x4001b0b0
-		>;
-	};
-
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6SX_PAD_NAND_DATA05__GPIO4_IO_9	0xb0b0
-- 
2.18.0
