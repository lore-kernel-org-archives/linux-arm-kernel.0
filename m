From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:04:01 +0100
Subject: [PATCHv2 5/8] ARM: dts: imx6-tx6: remove container node around
 pinctrl nodes
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457424244-14549-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function node around the pinctrl nodes that was obsoleted
by commit 5fcdf6a7ed95 ("pinctrl: imx: Allow parsing DT without
function nodes"), we can save this container node.

Also move the iomux node to the bottom of the file to improve
readability of the file.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts       |  18 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts |  30 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts        |  30 +-
 arch/arm/boot/dts/imx6q-tx6q-1110.dts        |  18 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           | 551 ++++++++++++++-------------
 5 files changed, 321 insertions(+), 326 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
index a1b755a..5e0c6bb 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -111,16 +111,6 @@
 	};
 };
 
-&iomuxc {
-	imx6dl-tx6u-811x {
-		pinctrl_eeti: eetigrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-			>;
-		};
-	};
-};
-
 &kpp {
 	status = "disabled"; /* pad conflict with backlight1 PWM */
 };
@@ -178,3 +168,11 @@
 &pwm1 {
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_eeti: eetigrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index 19231a0..9ed243b 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -124,22 +124,6 @@
 	status = "disabled";
 };
 
-&iomuxc {
-	imx6qdl-tx6 {
-		pinctrl_usdhc4: usdhc4grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
-				MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
-				MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
-				MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
-				MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
-				MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
-				MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
-			>;
-		};
-	};
-};
-
 &ipu1_di0_disp0 {
 	remote-endpoint = <&display0_in>;
 };
@@ -164,3 +148,17 @@
 	fsl,wp-controller;
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
index 4217282..347b531 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
@@ -210,22 +210,6 @@
 	status = "disabled";
 };
 
-&iomuxc {
-	imx6qdl-tx6 {
-		pinctrl_usdhc4: usdhc4grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
-				MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
-				MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
-				MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
-				MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
-				MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
-				MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
-			>;
-		};
-	};
-};
-
 &ipu1_di0_disp0 {
 	remote-endpoint = <&display0_in>;
 };
@@ -238,3 +222,17 @@
 	fsl,wp-controller;
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 45ceee7..0433e22 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -111,16 +111,6 @@
 	};
 };
 
-&iomuxc {
-	imx6q-tx6q-1110 {
-		pinctrl_eeti: eetigrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-			>;
-		};
-	};
-};
-
 &kpp {
 	status = "disabled"; /* pad conflict with backlight1 PWM */
 };
@@ -182,3 +172,11 @@
 &sata {
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_eeti: eetigrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 9509b44..dc813c2 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -316,310 +316,313 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-tx6 {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x1b0b1 /* LED */
-				MX6QDL_PAD_SD3_DAT2__GPIO7_IO06		0x1b0b1 /* ETN PHY RESET */
-				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b1 /* ETN PHY INT */
-				MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b1 /* PWR BTN */
-			>;
-		};
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x1b0b1 /* LED */
+			MX6QDL_PAD_SD3_DAT2__GPIO7_IO06		0x1b0b1 /* ETN PHY RESET */
+			MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1b0b1 /* ETN PHY INT */
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b1 /* PWR BTN */
+		>;
+	};
 
-		pinctrl_audmux: audmuxgrp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW1__AUD5_RXD		0x130b0 /* SSI1_RXD */
-				MX6QDL_PAD_KEY_ROW0__AUD5_TXD		0x110b0 /* SSI1_TXD */
-				MX6QDL_PAD_KEY_COL0__AUD5_TXC		0x130b0 /* SSI1_CLK */
-				MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0 /* SSI1_FS */
-			>;
-		};
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW1__AUD5_RXD		0x130b0 /* SSI1_RXD */
+			MX6QDL_PAD_KEY_ROW0__AUD5_TXD		0x110b0 /* SSI1_TXD */
+			MX6QDL_PAD_KEY_COL0__AUD5_TXC		0x130b0 /* SSI1_CLK */
+			MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0 /* SSI1_FS */
+		>;
+	};
 
-		pinctrl_disp0_1: disp0grp-1 {
-			fsl,pins = <
-				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
-				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
-				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
-				/* PAD DISP0_DAT0 is used for the Flexcan transceiver control */
-				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
-			>;
-		};
+	pinctrl_disp0_1: disp0grp-1 {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+			/* PAD DISP0_DAT0 is used for the Flexcan transceiver control */
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+		>;
+	};
 
-		pinctrl_disp0_2: disp0grp-2 {
-			fsl,pins = <
-				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
-				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
-				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
-				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
-				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
-			>;
-		};
+	pinctrl_disp0_2: disp0grp-2 {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+		>;
+	};
 
-		pinctrl_ecspi1: ecspi1grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x0b0b0
-				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x0b0b0
-				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x0b0b0
-				MX6QDL_PAD_GPIO_19__ECSPI1_RDY		0x0b0b0
-				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x0b0b0 /* SPI CS0 */
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x0b0b0 /* SPI CS1 */
-			>;
-		};
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x0b0b0
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x0b0b0
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x0b0b0
+			MX6QDL_PAD_GPIO_19__ECSPI1_RDY		0x0b0b0
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x0b0b0 /* SPI CS0 */
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x0b0b0 /* SPI CS1 */
+		>;
+	};
 
-		pinctrl_edt_ft5x06: edt-ft5x06grp {
-			fsl,pins = <
-				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0 /* Interrupt */
-				MX6QDL_PAD_EIM_A16__GPIO2_IO22  	0x1b0b0 /* Reset */
-				MX6QDL_PAD_EIM_A17__GPIO2_IO21  	0x1b0b0 /* Wake */
-			>;
-		};
+	pinctrl_edt_ft5x06: edt-ft5x06grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0 /* Interrupt */
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22  	0x1b0b0 /* Reset */
+			MX6QDL_PAD_EIM_A17__GPIO2_IO21  	0x1b0b0 /* Wake */
+		>;
+	};
 
-		pinctrl_enet: enetgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
-				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
-				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
-				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
-				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
-				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
-				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
-			>;
-		};
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+		>;
+	};
 
-		pinctrl_etnphy_power: etnphy-pwrgrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b1 /* ETN PHY POWER */
-			>;
-		};
+	pinctrl_enet_mdio: enet-mdiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+		>;
+	};
 
-		pinctrl_flexcan1: flexcan1grp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
-				MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x1b0b0
-			>;
-		};
+	pinctrl_etnphy_power: etnphy-pwrgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b1 /* ETN PHY POWER */
+		>;
+	};
 
-		pinctrl_flexcan2: flexcan2grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b0b0
-				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b0b0
-			>;
-		};
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x1b0b0
+		>;
+	};
 
-		pinctrl_flexcan_xcvr: flexcan-xcvrgrp {
-			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT0__GPIO4_IO21	0x1b0b0 /* Flexcan XCVR enable */
-			>;
-		};
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b0b0
+		>;
+	};
 
-		pinctrl_gpmi_nand: gpminandgrp {
-			fsl,pins = <
-				MX6QDL_PAD_NANDF_CLE__NAND_CLE    	0x0b0b1
-				MX6QDL_PAD_NANDF_ALE__NAND_ALE    	0x0b0b1
-				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B  	0x0b0b1
-				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
-				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B  	0x0b0b1
-				MX6QDL_PAD_SD4_CMD__NAND_RE_B     	0x0b0b1
-				MX6QDL_PAD_SD4_CLK__NAND_WE_B     	0x0b0b1
-				MX6QDL_PAD_NANDF_D0__NAND_DATA00  	0x0b0b1
-				MX6QDL_PAD_NANDF_D1__NAND_DATA01  	0x0b0b1
-				MX6QDL_PAD_NANDF_D2__NAND_DATA02  	0x0b0b1
-				MX6QDL_PAD_NANDF_D3__NAND_DATA03  	0x0b0b1
-				MX6QDL_PAD_NANDF_D4__NAND_DATA04  	0x0b0b1
-				MX6QDL_PAD_NANDF_D5__NAND_DATA05  	0x0b0b1
-				MX6QDL_PAD_NANDF_D6__NAND_DATA06  	0x0b0b1
-				MX6QDL_PAD_NANDF_D7__NAND_DATA07  	0x0b0b1
-			>;
-		};
+	pinctrl_flexcan_xcvr: flexcan-xcvrgrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT0__GPIO4_IO21	0x1b0b0 /* Flexcan XCVR enable */
+		>;
+	};
 
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
-			>;
-		};
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE    	0x0b0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE    	0x0b0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B  	0x0b0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B  	0x0b0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B     	0x0b0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B     	0x0b0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00  	0x0b0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01  	0x0b0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02  	0x0b0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03  	0x0b0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04  	0x0b0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05  	0x0b0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06  	0x0b0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07  	0x0b0b1
+		>;
+	};
 
-		pinctrl_i2c3: i2c3grp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
-				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
-			>;
-		};
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+		>;
+	};
 
-		pinctrl_kpp: kppgrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_9__KEY_COL6		0x1b0b1
-				MX6QDL_PAD_GPIO_4__KEY_COL7		0x1b0b1
-				MX6QDL_PAD_KEY_COL2__KEY_COL2		0x1b0b1
-				MX6QDL_PAD_KEY_COL3__KEY_COL3		0x1b0b1
-				MX6QDL_PAD_GPIO_2__KEY_ROW6		0x1b0b1
-				MX6QDL_PAD_GPIO_5__KEY_ROW7		0x1b0b1
-				MX6QDL_PAD_KEY_ROW2__KEY_ROW2		0x1b0b1
-				MX6QDL_PAD_KEY_ROW3__KEY_ROW3		0x1b0b1
-			>;
-		};
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+		>;
+	};
 
-		pinctrl_lcd0_pwr: lcd0-pwrgrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b1 /* LCD Reset */
-			>;
-		};
+	pinctrl_kpp: kppgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__KEY_COL6		0x1b0b1
+			MX6QDL_PAD_GPIO_4__KEY_COL7		0x1b0b1
+			MX6QDL_PAD_KEY_COL2__KEY_COL2		0x1b0b1
+			MX6QDL_PAD_KEY_COL3__KEY_COL3		0x1b0b1
+			MX6QDL_PAD_GPIO_2__KEY_ROW6		0x1b0b1
+			MX6QDL_PAD_GPIO_5__KEY_ROW7		0x1b0b1
+			MX6QDL_PAD_KEY_ROW2__KEY_ROW2		0x1b0b1
+			MX6QDL_PAD_KEY_ROW3__KEY_ROW3		0x1b0b1
+		>;
+	};
 
-		pinctrl_lcd1_pwr: lcd1-pwrgrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x1b0b1 /* LCD Power Enable */
-			>;
-		};
+	pinctrl_lcd0_pwr: lcd0-pwrgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b1 /* LCD Reset */
+		>;
+	};
 
-		pinctrl_pwm1: pwm1grp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b1
-			>;
-		};
+	pinctrl_lcd1_pwr: lcd-pwrgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x1b0b1 /* LCD Power Enable */
+		>;
+	};
 
-		pinctrl_pwm2: pwm2grp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__PWM2_OUT		0x1b0b1
-			>;
-		};
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b1
+		>;
+	};
 
-		pinctrl_tsc2007: tsc2007grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x1b0b0 /* Interrupt */
-			>;
-		};
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__PWM2_OUT		0x1b0b1
+		>;
+	};
 
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
-			>;
-		};
+	pinctrl_tsc2007: tsc2007grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x1b0b0 /* Interrupt */
+		>;
+	};
 
-		pinctrl_uart1_rtscts: uart1_rtsctsgrp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_DAT1__UART1_RTS_B	0x1b0b1
-				MX6QDL_PAD_SD3_DAT0__UART1_CTS_B	0x1b0b1
-			>;
-		};
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+		>;
+	};
 
-		pinctrl_uart2: uart2grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
-				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
-			>;
-		};
+	pinctrl_uart1_rtscts: uart1_rtsctsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT1__UART1_RTS_B	0x1b0b1
+			MX6QDL_PAD_SD3_DAT0__UART1_CTS_B	0x1b0b1
+		>;
+	};
 
-		pinctrl_uart2_rtscts: uart2_rtsctsgrp {
-			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
-				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
-			>;
-		};
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+		>;
+	};
 
-		pinctrl_uart3: uart3grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
-			>;
-		};
+	pinctrl_uart2_rtscts: uart2_rtsctsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
+			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
+		>;
+	};
 
-		pinctrl_uart3_rtscts: uart3_rtsctsgrp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_DAT3__UART3_CTS_B	0x1b0b1
-				MX6QDL_PAD_SD3_RST__UART3_RTS_B		0x1b0b1
-			>;
-		};
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+		>;
+	};
 
-		pinctrl_usbh1_vbus: usbh1-vbusgrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x1b0b0 /* USBH1_VBUSEN */
-			>;
-		};
+	pinctrl_uart3_rtscts: uart3_rtsctsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT3__UART3_CTS_B	0x1b0b1
+			MX6QDL_PAD_SD3_RST__UART3_RTS_B		0x1b0b1
+		>;
+	};
 
-		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x17059
-			>;
-		};
+	pinctrl_usbh1_vbus: usbh1-vbusgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x1b0b0 /* USBH1_VBUSEN */
+		>;
+	};
 
-		pinctrl_usbotg_vbus: usbotg-vbusgrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0 /* USBOTG_VBUSEN */
-			>;
-		};
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x17059
+		>;
+	};
 
-		pinctrl_usdhc1: usdhc1grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x070b1
-				MX6QDL_PAD_SD1_CLK__SD1_CLK		0x070b1
-				MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x070b1
-				MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x070b1
-				MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x070b1
-				MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x070b1
-				MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
-			>;
-		};
+	pinctrl_usbotg_vbus: usbotg-vbusgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0 /* USBOTG_VBUSEN */
+		>;
+	};
 
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x070b1
-				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x070b1
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x070b1
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x070b1
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x070b1
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x070b1
-				MX6QDL_PAD_SD3_CLK__GPIO7_IO03		0x170b0 /* SD2 CD */
-			>;
-		};
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x070b1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x070b1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x070b1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x070b1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x070b1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x070b1
+			MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x070b1
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x070b1
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x070b1
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x070b1
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x070b1
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x070b1
+			MX6QDL_PAD_SD3_CLK__GPIO7_IO03		0x170b0 /* SD2 CD */
+		>;
 	};
 };
 
-- 
2.1.4
