From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Jul 2016 22:30:20 +0200
Subject: [PATCH 1/3] ARM: dts: drop function device nodes for pinctrl-imx
 nodes
In-Reply-To: <1467749993-14533-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1467749993-14533-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160705203020.GR16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 05, 2016 at 10:19:51PM +0200, Uwe Kleine-K?nig wrote:
> Since commit v4.2-rc1~128^2~88 ("pinctrl: imx: Allow parsing DT without
> function nodes") the imx pinctrl driver supports the more sensible
> format without function device nodes. It's time to switch all
> devicetrees to this easier format.

This patch hit a filter because it's to big. For reference here is the
diff with whitespace changes ignored (git diff -b):

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index af4eee5794aa..c4883138e79d 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -93,7 +93,6 @@
 };
 
 &iomuxc {
-	imx1-ads {
 	pinctrl_cspi1: cspi1grp {
 		fsl,pins = <
 			MX1_PAD_SPI1_MISO__SPI1_MISO	0x0
@@ -148,5 +147,4 @@
 			MX1_PAD_LBA__LBA		0x0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index 07d92fb40e6f..d30ed3b90603 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -74,7 +74,6 @@
 };
 
 &iomuxc {
-	imx1-apf9328 {
 	pinctrl_eth: ethgrp {
 		fsl,pins = <
 			MX1_PAD_SIM_SVEN__GPIO2_14	0x0
@@ -125,5 +124,4 @@
 			MX1_PAD_LBA__LBA		0x0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index d6f27641c0ef..f024a84bd37b 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -41,7 +41,6 @@
 };
 
 &iomuxc {
-	imx25-eukrea-cpuimx25 {
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX25_PAD_FEC_MDC__FEC_MDC		0x80000000
@@ -62,7 +61,6 @@
 			MX25_PAD_I2C1_DAT__I2C1_DAT		0x80000000
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 68d0834a2d1e..184778f4335f 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -58,11 +58,9 @@
 };
 
 &iomuxc {
-	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga {
 	pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
 		fsl,pins = <MX25_PAD_PWM__GPIO_1_26 0x80000000>;
 	};
-	};
 };
 
 &lcdc {
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index cda6907a27b9..9efcdad20e73 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -76,7 +76,6 @@
 };
 
 &iomuxc {
-	imx25-eukrea-mbimxsd25-baseboard {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX25_PAD_KPP_COL3__AUD5_TXFS		0xe0
@@ -150,7 +149,6 @@
 			MX25_PAD_UART2_CTS__UART2_CTS		0x80000000
 		>;
 	};
-	};
 };
 
 &ssi1 {
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 9351296356dc..8b00cfca18ea 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -145,7 +145,6 @@
 };
 
 &iomuxc {
-	imx25-pdk {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX25_PAD_RW__AUD4_TXFS			0xe0
@@ -248,7 +247,6 @@
 			MX25_PAD_UART1_RXD__UART1_RXD		0xc0
 		>;
 	};
-	};
 };
 
 &lcdc {
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f5e539..7037777646d1 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -36,7 +36,6 @@
 };
 
 &iomuxc {
-	imx27-apf27 {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX27_PAD_SD3_CMD__FEC_TXD0 0x0
@@ -66,7 +65,6 @@
 			MX27_PAD_UART1_RXD__UART1_RXD 0x0
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index bba3f41b89ef..cda7b3ee21bc 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -137,7 +137,6 @@
 };
 
 &iomuxc {
-	imx27-apf27dev {
 	pinctrl_cspi1: cspi1grp {
 		fsl,pins = <
 			MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0
@@ -247,7 +246,6 @@
 	pinctrl_sdhc2_cd: sdhc2cdgrp {
 		fsl,pins = <MX27_PAD_TOUT__GPIO3_14 0x0>;
 	};
-	};
 };
 
 &sdhci2 {
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index e2242638ea0b..a1d1b138974f 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -166,7 +166,6 @@
 };
 
 &iomuxc {
-	imx27-eukrea-cpuimx27 {
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX27_PAD_SD3_CMD__FEC_TXD0		0x0
@@ -292,5 +291,4 @@
 			MX27_PAD_USBOTG_DATA7__USBOTG_DATA7	0x0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 2ab65fc4c1e1..585699775f24 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -161,7 +161,6 @@
 };
 
 &iomuxc {
-	imx27-eukrea-cpuimx27-baseboard {
 	pinctrl_cspi1: cspi1grp {
 		fsl,pins = <
 			MX27_PAD_CSPI1_MISO__CSPI1_MISO	0x0
@@ -269,5 +268,4 @@
 			MX27_PAD_UART3_RTS__UART3_RTS	0x0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 49450dbbcab8..b82432357621 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -122,7 +122,6 @@
 };
 
 &iomuxc {
-	imx27-pdk {
 	pinctrl_cspi2: cspi2grp {
 		fsl,pins = <
 			MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0
@@ -193,5 +192,4 @@
 			MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 7c869fe3c30b..ef5370d7bbf9 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -78,7 +78,6 @@
 };
 
 &iomuxc {
-	imx27-phycard-s-rdk {
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX27_PAD_I2C2_SDA__I2C2_SDA 0x0
@@ -130,7 +129,6 @@
 			MX27_PAD_UART3_RTS__UART3_RTS 0x0
 		>;
 	};
-	};
 };
 
 &owire {
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
index 1b6248079682..27315828f534 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
@@ -48,7 +48,6 @@
 };
 
 &iomuxc {
-	imx27-phycard-s-som {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX27_PAD_SD3_CMD__FEC_TXD0 0x0
@@ -90,7 +89,6 @@
 			MX27_PAD_NFWE_B__NFWE_B 0x0
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 538568b0de26..133c511f27bb 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -100,7 +100,6 @@
 };
 
 &iomuxc {
-	imx27_phycore_rdk {
 	pinctrl_csien: csiengrp {
 		fsl,pins = <
 			MX27_PAD_USB_OC_B__GPIO2_24 0x0
@@ -213,7 +212,6 @@
 			MX27_PAD_SD1_D1__GPIO5_19	0x0 /* CAN IRQ */
 		>;
 	};
-	};
 };
 
 &owire {
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index b4e955e3be8d..49b0e30cafc8 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -211,7 +211,6 @@
 };
 
 &iomuxc {
-	imx27_phycore_som {
 	pinctrl_cspi1: cspi1grp {
 		fsl,pins = <
 			MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0
@@ -295,7 +294,6 @@
 			MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index 9c2b715ab8bf..4524391cd5bc 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -51,7 +51,6 @@
 };
 
 &iomuxc {
-	imx35-eukrea {
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX35_PAD_FEC_TX_CLK__FEC_TX_CLK		0x80000000
@@ -85,7 +84,6 @@
 	pinctrl_tsc2007_1: tsc2007grp-1 {
 		fsl,pins = <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
index 4727bbb804e1..3f41b13cbfd4 100644
--- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -77,7 +77,6 @@
 };
 
 &iomuxc {
-	imx35-eukrea {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS	0x80000000
@@ -128,7 +127,6 @@
 			MX35_PAD_CTS2__UART2_CTS		0x1c5
 		>;
 	};
-	};
 };
 
 &ssi1 {
diff --git a/arch/arm/boot/dts/imx35-pdk.dts b/arch/arm/boot/dts/imx35-pdk.dts
index 8d715523708f..369016f78a98 100644
--- a/arch/arm/boot/dts/imx35-pdk.dts
+++ b/arch/arm/boot/dts/imx35-pdk.dts
@@ -30,7 +30,6 @@
 };
 
 &iomuxc {
-	imx35-pdk {
 	pinctrl_esdhc1: esdhc1grp {
 		fsl,pins = <
 			MX35_PAD_SD1_CMD__ESDHC1_CMD		0x80000000
@@ -50,7 +49,6 @@
 			MX35_PAD_RTS1__UART1_RTS		0x1c5
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 27d763c7a307..04cefa7c950f 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -59,7 +59,6 @@
 };
 
 &iomuxc {
-	imx50-evk {
 	pinctrl_cspi: cspigrp {
 		fsl,pins = <
 			MX50_PAD_CSPI_SCLK__CSPI_SCLK		0x00
@@ -93,7 +92,6 @@
 			MX50_PAD_UART1_CTS__UART1_CTS		0x1e4
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index e88b2a6be079..aa5861610834 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -42,7 +42,6 @@
 };
 
 &iomuxc {
-	imx51-apf51 {
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX51_PAD_DI_GP3__FEC_TX_ER		0x80000000
@@ -72,7 +71,6 @@
 			MX51_PAD_UART3_TXD__UART3_TXD		0x1c5
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 0f3fe29b816e..d43843220c9a 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -121,7 +121,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx51-apf51dev {
 	pinctrl_backlight: bl1grp {
 		fsl,pins = <
 			MX51_PAD_DI1_D1_CS__GPIO3_4 0x1F5
@@ -217,7 +216,6 @@
 			MX51_PAD_DI1_PIN3__DI1_PIN3		0x5
 		>;
 	};
-	};
 };
 
 &ipu_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 018d24eb9965..636a61491e5f 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -422,7 +422,6 @@
 };
 
 &iomuxc {
-	imx51-babbage {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX51_PAD_AUD3_BB_TXD__AUD3_TXD		0x80000000
@@ -651,5 +650,4 @@
 			MX51_PAD_GPIO1_7__GPIO1_7		0x85
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
index 1db517d3d497..b72b63406a47 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
@@ -60,7 +60,6 @@
 };
 
 &iomuxc {
-	imx51-digi-connectcore-jsk {
 	pinctrl_owire: owiregrp {
 		fsl,pins = <
 			MX51_PAD_OWIRE_LINE__OWIRE_LINE		0x40000000
@@ -104,5 +103,4 @@
 			MX51_PAD_USBH1_STP__USBH1_STP		0x1e5
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 16fc69c69ab2..deb6b560cb85 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -231,7 +231,6 @@
 };
 
 &iomuxc {
-	imx51-digi-connectcore-som {
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
 			MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
@@ -373,5 +372,4 @@
 			MX51_PAD_EIM_CS5__EIM_CS5		0x80000000 /* CS5 */
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index 63164266af83..5aa9e95e2ba0 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -56,7 +56,6 @@
 };
 
 &iomuxc {
-	imx51-eukrea {
 	pinctrl_tsc2007_1: tsc2007grp-1 {
 		fsl,pins = <
 			MX51_PAD_GPIO_NAND__GPIO_NAND 0x1f5
@@ -93,7 +92,6 @@
 			MX51_PAD_SD2_CLK__I2C1_SDA		0x400001ed
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index d270df3e5891..7002a66d51e0 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -139,7 +139,6 @@
 };
 
 &iomuxc {
-	imx51-eukrea {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX51_PAD_AUD3_BB_TXD__AUD3_TXD		0x80000000
@@ -250,7 +249,6 @@
 			MX51_PAD_EIM_CS3__GPIO2_28 0x1f5
 		>;
 	};
-	};
 };
 
 &ssi2 {
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 4486bc47d140..f41e6f91b0c3 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -112,7 +112,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-ard {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX53_PAD_GPIO_1__GPIO1_1             0x80000000
@@ -173,7 +172,6 @@
 			MX53_PAD_PATA_DMACK__UART1_RXD_MUX	0x1e4
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index 87a7fc709c2d..443f6eccace8 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -93,7 +93,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-m53evk {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x80000000
@@ -128,7 +127,6 @@
 			MX53_PAD_PATA_DATA7__EMI_NANDF_D_7	0xa4
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index dcee1e0f968f..bd33bd60ebc8 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -169,7 +169,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-m53evk {
 	pinctrl_usb: usbgrp {
 		fsl,pins = <
 			MX53_PAD_GPIO_2__GPIO1_2		0x80000000
@@ -318,7 +317,6 @@
 			MX53_PAD_PATA_DA_2__UART3_RTS		0x1e4
 		>;
 	};
-	};
 };
 
 &ipu_di1_disp1 {
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 2e44d2aba14e..fa6438141747 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -89,7 +89,6 @@
 };
 
 &iomuxc {
-	lvds1 {
 	pinctrl_lvds1_1: lvds1-grp1 {
 		fsl,pins = <
 			MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3 0x80000000
@@ -109,9 +108,7 @@
 			MX53_PAD_LVDS1_TX0_P__LDB_LVDS1_TX0 0x80000000
 		>;
 	};
-	};
 
-	disp1 {
 	pinctrl_disp1_1: disp1-grp1 {
 		fsl,pins = <
 			MX53_PAD_EIM_A16__IPU_DI1_DISP_CLK 0x80000000 /* DISP1_CLK */
@@ -144,9 +141,7 @@
 			MX53_PAD_EIM_DA9__IPU_DISP1_DAT_0  0x80000000
 		>;
 	};
-	};
 
-	tve {
 	pinctrl_vga_sync_1: vgasync-grp1 {
 		fsl,pins = <
 			/* VGA_VSYNC, HSYNC with max drive strength */
@@ -154,7 +149,6 @@
 			MX53_PAD_EIM_DA15__IPU_DI1_PIN4	   0xe6
 		>;
 	};
-	};
 };
 
 &ipu_di1_disp1 {
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index c05e7cfd0cbc..baebcd3a0515 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -157,7 +157,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-qsb {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x80000000
@@ -290,7 +289,6 @@
 			MX53_PAD_CSI0_DAT11__UART1_RXD_MUX	0x1e4
 		>;
 	};
-	};
 };
 
 &tve {
diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
index 96d7eede412e..0bda292893e0 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -20,13 +20,11 @@
 };
 
 &iomuxc {
-	imx53-qsrb {
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX53_PAD_CSI0_DAT5__GPIO5_23	0x1e4 /* IRQ */
 		>;
 	};
-	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 542ab9e697fb..105b5e0972ff 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -104,7 +104,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-smd {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX53_PAD_PATA_DATA14__GPIO2_14 0x80000000
@@ -213,7 +212,6 @@
 			MX53_PAD_PATA_DA_2__UART3_RTS		0x1e4
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index e03373a58760..244842e8152a 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -74,7 +74,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-tqma53 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			 MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x80000000 /* SSI_MCLK */
@@ -212,7 +211,6 @@
 			MX53_PAD_PATA_CS_1__UART3_RXD_MUX	0x1e4
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0ecb43d88522..bc799aa896b3 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -236,7 +236,6 @@
 };
 
 &iomuxc {
-	imx53-tx53-x03x {
 	pinctrl_edt_ft5x06_1: edt-ft5x06grp-1 {
 		fsl,pins = <
 			MX53_PAD_NANDF_CS2__GPIO6_15 0x1f0 /* Interrupt */
@@ -296,7 +295,6 @@
 			MX53_PAD_EIM_D26__GPIO3_26 0x1f0 /* Interrupt */
 		>;
 	};
-	};
 };
 
 &ipu_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 3cf682a681f4..73487c4b49b0 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -131,7 +131,6 @@
 };
 
 &iomuxc {
-	imx53-tx53-x13x {
 	pinctrl_i2c2: i2c2-grp1 {
 		fsl,pins = <
 			MX53_PAD_KEY_ROW3__I2C2_SDA		0xc0000000
@@ -174,7 +173,6 @@
 			MX53_PAD_EIM_D23__GPIO3_23 0x1f0 /* Interrupt */
 		>;
 	};
-	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index bd3dfefa5778..13deaa664eb8 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -234,7 +234,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-tx53 {
 	pinctrl_hog: hoggrp {
 		/* pins not in use by any device on the Starterkit board series */
 		fsl,pins = <
@@ -475,7 +474,6 @@
 			MX53_PAD_GPIO_8__GPIO1_8 0x100 /* OC */
 		>;
 	};
-	};
 };
 
 &ipu {
diff --git a/arch/arm/boot/dts/imx53-voipac-bsb.dts b/arch/arm/boot/dts/imx53-voipac-bsb.dts
index fc51b87ad208..bf06e659436f 100644
--- a/arch/arm/boot/dts/imx53-voipac-bsb.dts
+++ b/arch/arm/boot/dts/imx53-voipac-bsb.dts
@@ -48,7 +48,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-voipac {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* SD2_CD */
@@ -107,7 +106,6 @@
 			MX53_PAD_GPIO_6__I2C3_SDA		0xc0000000
 		>;
 	};
-	};
 };
 
 &audmux {
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index ba689fbd0e41..1ad10374b3c5 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -55,7 +55,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx53-voipac {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* Make DA9053 regulator functional */
@@ -123,7 +122,6 @@
 			MX53_PAD_PATA_DATA7__EMI_NANDF_D_7	0xa4
 		>;
 	};
-	};
 };
 
 &ecspi1 {
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index bfbed52ce1bd..2309b050525f 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -331,7 +331,6 @@
 &iomuxc {
 	pinctrl-names = "default";
 
-	imx6-riotboard {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
@@ -534,5 +533,4 @@
 			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x17059	/* SD4 RST (eMMC) */
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index d6515f7a56c4..1ef2ca4251b0 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -68,7 +68,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-arm2 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x80000000
@@ -176,7 +175,6 @@
 			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 		>;
 	};
-	};
 };
 
 &fec {
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 99b46f8030ad..21c513f6980e 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -47,7 +47,6 @@
 };
 
 &iomuxc {
-	imx6q-cm-fx6 {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
@@ -97,7 +96,6 @@
 			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
-	};
 };
 
 &uart4 {
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 364578d707a5..84046ad7ab16 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -298,7 +298,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-dmo-edmqmx6 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_A16__GPIO2_IO22 0x80000000
@@ -430,7 +429,6 @@
 			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 		>;
 	};
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index b715deb4ea46..46a6a7d2df34 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -80,7 +80,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-gk802 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* Recovery button, active-low */
@@ -132,7 +131,6 @@
 			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
 		>;
 	};
-	};
 };
 
 &uart2 {
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 0511137d1e23..2e40c7e2f870 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -398,8 +398,6 @@
 };
 
 &iomuxc {
-	imx6q-gw5400-a {
-
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
@@ -520,5 +518,4 @@
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index 3f8013c85fb9..bc22cc31119c 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -228,7 +228,6 @@
 };
 
 &iomuxc {
-
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
index 86cf09364664..60277d75b207 100644
--- a/arch/arm/boot/dts/imx6q-sbc6x.dts
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -26,7 +26,6 @@
 };
 
 &iomuxc {
-	imx6q-sbc6x {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
@@ -71,7 +70,6 @@
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx6qdl-apf6.dtsi b/arch/arm/boot/dts/imx6qdl-apf6.dtsi
index 1ebf29f43a24..82387f72005f 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6.dtsi
@@ -94,7 +94,6 @@
 };
 
 &iomuxc {
-	apf6 {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
@@ -154,5 +153,4 @@
 			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index 865c9a264a43..e289a30b7872 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -302,7 +302,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpios>;
 
-	apf6dev {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
@@ -475,5 +474,4 @@
 			MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03 0x1b0b0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index ecbc6eba6a2c..f7e6803992ee 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -189,7 +189,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog &pinctrl_gpio>;
 
-	imx6qdl-aristainetos {
 	pinctrl_aristainetos_usbh1_vbus: aristainetos-usbh1-vbus {
 		fsl,pins = <MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x130b0>;
 	};
@@ -414,5 +413,4 @@
 			MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x1b0b0
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index ff41f83551de..a238420015cb 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -146,7 +146,6 @@
 };
 
 &iomuxc {
-	cubox_i {
 	pinctrl_cubox_i_hdmi: cubox-i-hdmi {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
@@ -227,7 +226,6 @@
 			MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
 		>;
 	};
-	};
 };
 
 &pwm1 {
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index da1341d47b14..80682d506f8f 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -55,7 +55,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-dfi-fs700-m60 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
@@ -152,7 +151,6 @@
 			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
 		>;
 	};
-	};
 };
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 9d7ab6cdc9a6..5e829c650a56 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -229,7 +229,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw51xx {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
@@ -364,5 +363,4 @@
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 7191b84770b9..78b53ff4aa17 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -354,7 +354,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw52xx {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
@@ -549,5 +548,4 @@
 			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 40d06b09deba..8788afc25709 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -352,7 +352,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw53xx {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
@@ -539,5 +538,4 @@
 			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index d6dbe2a88ee6..8ceaf527b58e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -454,7 +454,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw54xx {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
@@ -654,5 +653,4 @@
 			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 118bea524dab..51307ae3dbc0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -240,7 +240,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw51xx {
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
@@ -333,5 +332,4 @@
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index f27f184558fb..623b6e6037b5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -198,7 +198,6 @@
 };
 
 &iomuxc {
-	imx6qdl-gw552x {
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
@@ -286,5 +285,4 @@
 			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index d6c2358ffad4..3c5f268b6c37 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -157,7 +157,6 @@
 };
 
 &iomuxc {
-	hummingboard {
 	pinctrl_hummingboard_flexcan1: hummingboard-flexcan1 {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
@@ -247,7 +246,6 @@
 			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
 		>;
 	};
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index 469ef58ce4bc..631fa6eacc79 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -51,7 +51,6 @@
 };
 
 &iomuxc {
-	enet {
 	pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
@@ -95,5 +94,4 @@
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x03000
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
index 86460e46d055..d26626c842c4 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom.dtsi
@@ -74,7 +74,6 @@
 };
 
 &iomuxc {
-	microsom {
 	pinctrl_microsom_brcm_bt: microsom-brcm-bt {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x40013070
@@ -130,7 +129,6 @@
 			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index e456b5cc1b03..1a4a244c31f9 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -317,7 +317,6 @@
 	pinctrl-0 = <&pinctrl_j10>;
 	pinctrl-1 = <&pinctrl_j28>;
 
-	imx6dl-nit6xlite {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
@@ -529,7 +528,6 @@
 			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
 		>;
 	};
-	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 657da6b6ccd2..762b2a934978 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -446,7 +446,6 @@
 };
 
 &iomuxc {
-	imx6q-nitrogen6_max {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
@@ -727,7 +726,6 @@
 			MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT	0x000b0
 		>;
 	};
-	};
 };
 
 &ipu1_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 73915db704a0..c9a337deb7cd 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -348,7 +348,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-nitrogen6x {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* SGTL5000 sys_mclk */
@@ -568,7 +567,6 @@
 			MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT	0x000b0
 		>;
 	};
-	};
 };
 
 &ipu1_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index d6d98d426384..afffd1b0f158 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -208,7 +208,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-phytec-pfla02 {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
@@ -369,7 +368,6 @@
 			MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
 		>;
 	};
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index cacf5933707d..f8d49899f6e8 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -155,7 +155,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-rex {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* SGTL5000 sys_mclk */
@@ -302,7 +301,6 @@
 			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1f0b0
 		>;
 	};
-	};
 };
 
 &ssi1 {
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index d354d406954d..cab748c7483f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -317,7 +317,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-sabreauto {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
@@ -541,7 +540,6 @@
 			MX6QDL_PAD_EIM_DA0__EIM_AD00		0xb0b1
 		>;
 	};
-	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index c47fe6c79b36..9b9999499930 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -314,7 +314,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6q-sabrelite {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* SGTL5000 sys_mclk */
@@ -513,7 +512,6 @@
 			MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x1b0b0	/* CD */
 		>;
 	};
-	};
 };
 
 &ipu1_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 5248e7bd2b06..7ab9249b6144 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -343,7 +343,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-sabresd {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x1b0b0
@@ -501,15 +500,12 @@
 			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 		>;
 	};
-	};
 
-	gpio_leds {
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x1b0b0
 		>;
 	};
-	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 3bee2f910067..42caca66ef04 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -129,7 +129,6 @@
 };
 
 &iomuxc {
-	imx6q-udoo {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
@@ -233,7 +232,6 @@
 			MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
 		>;
 	};
-	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index ef7fa62b9898..d92c5a4f07d9 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -14,7 +14,6 @@
 &iomuxc {
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-wandboard {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
@@ -31,7 +30,6 @@
 			MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x80000000	/* BT_HOST_WAKE */				
 		>;
 	};
-	};
 };
 
 &usdhc2 {
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index 8d893a78cdf0..ca4bfb2aa218 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -14,7 +14,6 @@
 &iomuxc {
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6qdl-wandboard {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
@@ -31,7 +30,6 @@
 			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
 		>;
 	};
-	};
 };
 
 &usdhc2 {
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 8e7c40e114dd..dff0eab40f79 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -94,8 +94,6 @@
 &iomuxc {
 	pinctrl-names = "default";
 
-	imx6qdl-wandboard {
-
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
@@ -201,7 +199,6 @@
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
 		>;
 	};
-	};
 };
 
 &fec {
diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
index 5ce3840d83d3..05490830b9eb 100644
--- a/arch/arm/boot/dts/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
@@ -60,7 +60,6 @@
 };
 
 &iomuxc {
-	imx6qdl-sabreauto {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL1__ENET_MDIO          0x1b0b0
@@ -81,7 +80,6 @@
 			MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 		>;
 	};
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index b23458062f5e..acf4f9ac064c 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -55,7 +55,6 @@
 };
 
 &iomuxc {
-	imx6qdl-sabresd {
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
@@ -85,7 +84,6 @@
 			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
-	};
 };
 
 &pcie {
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index be118820e9f7..57e5de05b28a 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -272,7 +272,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx6sl-evk {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6SL_PAD_KEY_ROW7__GPIO4_IO07    0x17059
@@ -525,7 +524,6 @@
 			MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
 		>;
 	};
-	};
 };
 
 &kpp {
diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 058bcdceb81a..3513170eea8d 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -124,7 +124,6 @@
 };
 
 &iomuxc {
-	imx6sl-warp {
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x41b0b1
@@ -229,5 +228,4 @@
 			MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x4170f9
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 96ea936eeeb0..5ebd53682b3f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -69,7 +69,6 @@
 };
 
 &iomuxc {
-	imx6x-sabreauto {
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -142,5 +141,4 @@
 			MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index e5eafe4d9a70..ce77e5b65217 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -323,7 +323,6 @@
 };
 
 &iomuxc {
-	imx6x-sdb {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6SX_PAD_CSI_DATA00__AUDMUX_AUD6_TXC	0x130b0
@@ -588,5 +587,4 @@
 			MX6SX_PAD_SD4_DATA6__GPIO6_IO_20	0x17059 /* WP */
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index b267f79e3059..b38c643ba8d2 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -318,7 +318,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
-	imx7d-sdb {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
@@ -511,6 +510,4 @@
 			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
 		>;
 	};
-
-	};
 };
diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index a8a8e434fb27..b3160b4449b7 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -167,11 +167,9 @@
 };
 
 &iomuxc {
-	vf610-colibri {
 	pinctrl_can_int: can_int {
 		fsl,pins = <
 			VF610_PAD_PTB21__GPIO_43	0x22ed
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index b7417094dc11..7c9895e75a79 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -199,7 +199,6 @@
 };
 
 &iomuxc {
-	vf610-colibri {
 	pinctrl_flexcan0: can0grp {
 		fsl,pins = <
 			VF610_PAD_PTB14__CAN0_RX	0x31F1
@@ -367,5 +366,4 @@
 			VF610_PAD_PTD4__GPIO_83			0x22ed
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index 1a8a0efa19a6..22bf1a42d7b2 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -75,7 +75,6 @@
 };
 
 &iomuxc {
-	vf610-colibri {
 	pinctrl_touchctrl_idle: touchctrl_idle {
 		fsl,pins = <
 			VF610_PAD_PTA18__GPIO_8		0x006d
@@ -100,5 +99,4 @@
 			VF610_PAD_PTA11__GPIO_4		0x22e9
 			>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-cosmic.dts
index 5447f2594659..6248f838866d 100644
--- a/arch/arm/boot/dts/vf610-cosmic.dts
+++ b/arch/arm/boot/dts/vf610-cosmic.dts
@@ -50,7 +50,6 @@
 };
 
 &iomuxc {
-	vf610-cosmic {
 	pinctrl_esdhc1: esdhc1grp {
 		fsl,pins = <
 			VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
@@ -83,7 +82,6 @@
 			VF610_PAD_PTB5__UART1_RX		0x21a1
 		>;
 	};
-	};
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index cdc100732514..821b0ae367b2 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -209,7 +209,6 @@
 };
 
 &iomuxc {
-	vf610-twr {
 	pinctrl_adc0_ad5: adc0ad5grp {
 		fsl,pins = <
 			VF610_PAD_PTC30__ADC0_SE5		0xa1
@@ -334,7 +333,6 @@
 			VF610_PAD_PTB7__UART2_RX		0x21a1
 		>;
 	};
-	};
 };
 
 &nfc {
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 2931a80caccb..7f55a32b4d94 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -86,7 +86,6 @@
 };
 
 &iomuxc {
-	vf610-colibri {
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			VF610_PAD_PTD0__UART2_TX		0x21a2
@@ -95,5 +94,4 @@
 			VF610_PAD_PTD3__UART2_CTS		0x21a1
 		>;
 	};
-	};
 };
diff --git a/arch/arm/boot/dts/vf610m4-cosmic.dts b/arch/arm/boot/dts/vf610m4-cosmic.dts
index 8944a2d2054c..ad08fe083d4b 100644
--- a/arch/arm/boot/dts/vf610m4-cosmic.dts
+++ b/arch/arm/boot/dts/vf610m4-cosmic.dts
@@ -79,12 +79,10 @@
 };
 
 &iomuxc {
-	vf610-cosmic {
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
 			VF610_PAD_PTA20__UART3_TX		0x21a2
 			VF610_PAD_PTA21__UART3_RX		0x21a1
 		>;
 	};
-	};
 };

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
