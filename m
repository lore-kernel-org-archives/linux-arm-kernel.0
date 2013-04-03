From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Wed, 3 Apr 2013 12:36:29 -0300
Subject: [PATCH 2/3] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <1365003390-26964-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1365003390-26964-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1365003390-26964-2-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for CLAA WVGA display for i.MX53 QSB.

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
 arch/arm/boot/dts/imx53-qsb.dtsp |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsip    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb.dtsp b/arch/arm/boot/dts/imx53-qsb.dtsp
index dae8d9f..f9449b0 100644
--- a/arch/arm/boot/dts/imx53-qsb.dtsp
+++ b/arch/arm/boot/dts/imx53-qsb.dtsp
@@ -21,6 +21,32 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
+	display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu 0>;
+		interface-pix-fmt = "rgb565";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+		display-timings {
+			claawvga {
+				native-mode;
+				clock-frequency = <27000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <40>;
+				hfront-porch = <60>;
+				vback-porch = <10>;
+				vfront-porch = <10>;
+				hsync-len = <20>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm/boot/dts/imx53.dtsip b/arch/arm/boot/dts/imx53.dtsip
index 6c73bee..d2cd67e 100644
--- a/arch/arm/boot/dts/imx53.dtsip
+++ b/arch/arm/boot/dts/imx53.dtsip
@@ -441,6 +441,41 @@
 					};
 				};
 
+				ipu_disp1 {
+					pinctrl_ipu_disp1_1: ipudisp1grp-1 {
+						fsl,pins = <
+						MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK 0x5
+						MX53_PAD_DI0_PIN15__IPU_DI0_PIN15 0x5
+						MX53_PAD_DI0_PIN2__IPU_DI0_PIN2 0x5
+						MX53_PAD_DI0_PIN3__IPU_DI0_PIN3  0x5
+						MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0 0x5
+						MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1 0x5
+						MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2 0x5
+						MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3 0x5
+						MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4 0x5
+						MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5 0x5
+						MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6 0x5
+						MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7 0x5
+						MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8 0x5
+						MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9 0x5
+						MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10 0x5
+						MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11 0x5
+						MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12 0x5
+						MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13 0x5
+						MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14 0x5
+						MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15 0x5
+						MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16 0x5
+						MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17 0x5
+						MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18 0x5
+						MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19 0x5
+						MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20 0x5
+						MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21 0x5
+						MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22 0x5
+						MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23 0x5
+						>;
+					};
+				};
+
 				owire {
 					pinctrl_owire_1: owiregrp-1 {
 						fsl,pins = <
-- 
1.7.10.4
