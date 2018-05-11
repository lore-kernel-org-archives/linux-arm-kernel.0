From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 May 2018 21:16:49 -0300
Subject: [PATCH 2/3] ARM: dts: imx28: Remove unit-address from pinctrl
In-Reply-To: <1525997810-10964-1-git-send-email-festevam@gmail.com>
References: <1525997810-10964-1-git-send-email-festevam@gmail.com>
Message-ID: <1525997810-10964-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unit-address and reg property from pinctrl subnodes to fix
the following DTC warnings with W=1:

arch/arm/boot/dts/imx28-apf28dev.dtb: Warning (unique_unit_address): /apb at 80000000/apbh at 80000000/pinctrl at 80018000/hog at 0: duplicate unit-address (also used in node /apb at 80000000/apbh at 80000000

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts           |   9 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts         |  12 +-
 arch/arm/boot/dts/imx28-cfa10036.dts           |  12 +-
 arch/arm/boot/dts/imx28-cfa10037.dts           |   6 +-
 arch/arm/boot/dts/imx28-cfa10049.dts           |  36 ++---
 arch/arm/boot/dts/imx28-cfa10055.dts           |  12 +-
 arch/arm/boot/dts/imx28-cfa10056.dts           |   9 +-
 arch/arm/boot/dts/imx28-cfa10057.dts           |   9 +-
 arch/arm/boot/dts/imx28-cfa10058.dts           |   6 +-
 arch/arm/boot/dts/imx28-duckbill-2-485.dts     |  12 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts |  15 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts     |  15 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts         |  12 +-
 arch/arm/boot/dts/imx28-duckbill.dts           |   9 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts   |   3 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts   |   3 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi   |  24 ++--
 arch/arm/boot/dts/imx28-evk.dts                |  12 +-
 arch/arm/boot/dts/imx28-m28cu3.dts             |   9 +-
 arch/arm/boot/dts/imx28-m28evk.dts             |   6 +-
 arch/arm/boot/dts/imx28-sps1.dts               |   3 +-
 arch/arm/boot/dts/imx28-ts4600.dts             |   3 +-
 arch/arm/boot/dts/imx28-tx28.dts               |  33 ++---
 arch/arm/boot/dts/imx28.dtsi                   | 191 ++++++++-----------------
 24 files changed, 153 insertions(+), 308 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index c4fadbc..53ed2e2 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -38,8 +38,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_apf28dev>;
 
-				hog_pins_apf28dev: hog at 0 {
-					reg = <0>;
+				hog_pins_apf28dev: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D16__GPIO_1_16
 						MX28_PAD_LCD_D17__GPIO_1_17
@@ -55,8 +54,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_apf28dev: lcdif-apf28dev at 0 {
-					reg = <0>;
+				lcdif_pins_apf28dev: lcdif-apf28dev {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
@@ -68,8 +66,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usb0_otg_apf28dev: otg-apf28dev at 0 {
-					reg = <0>;
+				usb0_otg_apf28dev: otg-apf28dev {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D23__GPIO_1_23
 					>;
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 96faa53..e8447af 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -38,8 +38,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_CE1N__GPIO_0_17
 						MX28_PAD_GPMI_RDY1__GPIO_0_21
@@ -54,8 +53,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_apx4: lcdif-apx4 at 0 {
-					reg = <0>;
+				lcdif_pins_apx4: lcdif-apx4 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
@@ -67,8 +65,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc2_4bit_pins_apx4: mmc2-4bit-apx4 at 0 {
-					reg = <0>;
+				mmc2_4bit_pins_apx4: mmc2-4bit-apx4 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA4__SSP2_D0
 						MX28_PAD_SSP0_DATA5__SSP2_D3
@@ -82,8 +79,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc2_sck_cfg_apx4: mmc2-sck-cfg-apx4 at 0 {
-					reg = <0>;
+				mmc2_sck_cfg_apx4: mmc2-sck-cfg-apx4 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__SSP2_SCK
 					>;
diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index e54f5ab..cc0205b 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -23,8 +23,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				ssd1306_cfa10036: ssd1306-10036 at 0 {
-					reg = <0>;
+				ssd1306_cfa10036: ssd1306-10036 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__GPIO_2_7
 					>;
@@ -33,8 +32,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins_cfa10036: leds-10036 at 0 {
-					reg = <0>;
+				led_pins_cfa10036: leds-10036 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__GPIO_3_4
 					>;
@@ -43,8 +41,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usb0_otg_cfa10036: otg-10036 at 0 {
-					reg = <0>;
+				usb0_otg_cfa10036: otg-10036 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDY0__USB0_ID
 					>;
@@ -53,8 +50,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc_pwr_cfa10036: mmc_pwr_cfa10036 at 0 {
-					reg = <0>;
+				mmc_pwr_cfa10036: mmc_pwr_cfa10036 {
 					fsl,pinmux-ids = <
 						0x31c3 /*
 						MX28_PAD_PWM3__GPIO_3_28 */
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index 3d13b32..e373aee 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -22,8 +22,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				usb_pins_cfa10037: usb-10037@0 {
-					reg = <0>;
+				usb_pins_cfa10037: usb-10037 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7
 					>;
@@ -32,8 +31,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_pins_cfa10037: mac0-10037 at 0 {
-					reg = <0>;
+				mac0_pins_cfa10037: mac0-10037 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS2__GPIO_2_21
 					>;
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 60e5c7f..fbc4cb4 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -87,8 +87,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				usb_pins_cfa10049: usb-10049 at 0 {
-					reg = <0>;
+				usb_pins_cfa10049: usb-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7
 					>;
@@ -97,8 +96,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				i2cmux_pins_cfa10049: i2cmux-10049 at 0 {
-					reg = <0>;
+				i2cmux_pins_cfa10049: i2cmux-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D22__GPIO_1_22
 						MX28_PAD_LCD_D23__GPIO_1_23
@@ -108,8 +106,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_pins_cfa10049: mac0-10049 at 0 {
-					reg = <0>;
+				mac0_pins_cfa10049: mac0-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS2__GPIO_2_21
 					>;
@@ -118,8 +115,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				pca_pins_cfa10049: pca-10049 at 0 {
-					reg = <0>;
+				pca_pins_cfa10049: pca-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS0__GPIO_2_19
 					>;
@@ -128,8 +124,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				rotary_pins_cfa10049: rotary-10049 at 0 {
-					reg = <0>;
+				rotary_pins_cfa10049: rotary-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_I2C0_SCL__GPIO_3_24
 						MX28_PAD_I2C0_SDA__GPIO_3_25
@@ -139,8 +134,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				rotary_btn_pins_cfa10049: rotary-btn-10049 at 0 {
-					reg = <0>;
+				rotary_btn_pins_cfa10049: rotary-btn-10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF1_SDATA0__GPIO_3_26
 					>;
@@ -149,8 +143,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				spi2_pins_cfa10049: spi2-cfa10049 at 0 {
-					reg = <0>;
+				spi2_pins_cfa10049: spi2-cfa10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__GPIO_2_16
 						MX28_PAD_SSP2_MOSI__GPIO_2_17
@@ -162,8 +155,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				spi3_pins_cfa10049: spi3-cfa10049 at 0 {
-					reg = <0>;
+				spi3_pins_cfa10049: spi3-cfa10049 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDN__GPIO_0_24
 						MX28_PAD_GPMI_RESETN__GPIO_0_28
@@ -176,8 +168,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				lcdif_18bit_pins_cfa10049: lcdif-18bit at 0 {
-					reg = <0>;
+				lcdif_18bit_pins_cfa10049: lcdif-18bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -203,8 +194,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10049: lcdif-evk at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10049: lcdif-evk {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
@@ -216,8 +206,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10049_pullup: lcdif-10049-pullup at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10049_pullup: lcdif-10049-pullup {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RESET__GPIO_3_30
 					>;
@@ -226,8 +215,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				w1_gpio_pins: w1-gpio at 0 {
-					reg = <0>;
+				w1_gpio_pins: w1-gpio {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D21__GPIO_1_21
 					>;
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index 6a34114..1edcc49 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -23,8 +23,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				spi2_pins_cfa10055: spi2-cfa10055 at 0 {
-					reg = <0>;
+				spi2_pins_cfa10055: spi2-cfa10055 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__GPIO_2_16
 						MX28_PAD_SSP2_MOSI__GPIO_2_17
@@ -36,8 +35,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				lcdif_18bit_pins_cfa10055: lcdif-18bit at 0 {
-					reg = <0>;
+				lcdif_18bit_pins_cfa10055: lcdif-18bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -63,8 +61,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10055: lcdif-evk at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10055: lcdif-evk {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
@@ -76,8 +73,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10055_pullup: lcdif-10055-pullup at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10055_pullup: lcdif-10055-pullup {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RESET__GPIO_3_30
 					>;
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
index ba6495c..5ac3a12 100644
--- a/arch/arm/boot/dts/imx28-cfa10056.dts
+++ b/arch/arm/boot/dts/imx28-cfa10056.dts
@@ -22,8 +22,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				spi2_pins_cfa10056: spi2-cfa10056 at 0 {
-					reg = <0>;
+				spi2_pins_cfa10056: spi2-cfa10056 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__GPIO_2_16
 						MX28_PAD_SSP2_MOSI__GPIO_2_17
@@ -35,8 +34,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				lcdif_pins_cfa10056: lcdif-10056 at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10056: lcdif-10056 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
@@ -48,8 +46,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10056_pullup: lcdif-10056-pullup at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10056_pullup: lcdif-10056-pullup {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RESET__GPIO_3_30
 					>;
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index c606791..de48936 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -23,8 +23,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				usb_pins_cfa10057: usb-10057 at 0 {
-					reg = <0>;
+				usb_pins_cfa10057: usb-10057 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7
 					>;
@@ -33,8 +32,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_18bit_pins_cfa10057: lcdif-18bit at 0 {
-					reg = <0>;
+				lcdif_18bit_pins_cfa10057: lcdif-18bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -60,8 +58,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10057: lcdif-evk at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10057: lcdif-evk {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index 70c7bb4..26c3a0e 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -23,8 +23,7 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				usb_pins_cfa10058: usb-10058@0 {
-					reg = <0>;
+				usb_pins_cfa10058: usb-10058 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7
 					>;
@@ -33,8 +32,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_cfa10058: lcdif-10058 at 0 {
-					reg = <0>;
+				lcdif_pins_cfa10058: lcdif-10058 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
index 97084e4..0fd07fe 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-485.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
@@ -50,8 +50,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
 					>;
@@ -60,8 +59,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_reset_pin: mac0-phy-reset at 0 {
-					reg = <0>;
+				mac0_phy_reset_pin: mac0-phy-reset {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
 					>;
@@ -70,8 +68,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_int_pin: mac0-phy-int at 0 {
-					reg = <0>;
+				mac0_phy_int_pin: mac0-phy-int {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
 					>;
@@ -80,8 +77,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins: leds at 0 {
-					reg = <0>;
+				led_pins: leds {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__GPIO_3_20
 						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
index 7f8d40a..c241546 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -51,8 +51,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
 					>;
@@ -61,8 +60,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_reset_pin: mac0-phy-reset at 0 {
-					reg = <0>;
+				mac0_phy_reset_pin: mac0-phy-reset {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
 					>;
@@ -71,8 +69,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_int_pin: mac0-phy-int at 0 {
-					reg = <0>;
+				mac0_phy_int_pin: mac0-phy-int {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
 					>;
@@ -81,8 +78,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins: leds at 0 {
-					reg = <0>;
+				led_pins: leds {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__GPIO_3_20
 						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
@@ -95,8 +91,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				enocean_button: enocean-button at 0 {
-					reg = <0>;
+				enocean_button: enocean-button {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_RTS__GPIO_3_3
 					>;
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
index 13e7b13..e5c92f3 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
@@ -63,8 +63,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
 					>;
@@ -73,8 +72,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_reset_pin: mac0-phy-reset at 0 {
-					reg = <0>;
+				mac0_phy_reset_pin: mac0-phy-reset {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
 					>;
@@ -83,8 +81,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_int_pin: mac0-phy-int at 0 {
-					reg = <0>;
+				mac0_phy_int_pin: mac0-phy-int {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
 					>;
@@ -93,8 +90,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins: led at 0 {
-					reg = <0>;
+				led_pins: led {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__GPIO_3_20
 						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
@@ -104,8 +100,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				qca7000_pins: qca7000 at 0 {
-					reg = <0>;
+				qca7000_pins: qca7000 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_RTS__GPIO_3_3    /* Interrupt */
 						MX28_PAD_LCD_D13__GPIO_1_13      /* QCA7K reset */
diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/imx28-duckbill-2.dts
index 88556c9..0a9128b 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2.dts
@@ -50,8 +50,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
 					>;
@@ -60,8 +59,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_reset_pin: mac0-phy-reset at 0 {
-					reg = <0>;
+				mac0_phy_reset_pin: mac0-phy-reset {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
 					>;
@@ -70,8 +68,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_int_pin: mac0-phy-int at 0 {
-					reg = <0>;
+				mac0_phy_int_pin: mac0-phy-int {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
 					>;
@@ -80,8 +77,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins: leds at 0 {
-					reg = <0>;
+				led_pins: leds {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__GPIO_3_20
 						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index f286bfe..6113bdc 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -45,8 +45,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
 					>;
@@ -55,8 +54,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_phy_reset_pin: mac0-phy-reset at 0 {
-					reg = <0>;
+				mac0_phy_reset_pin: mac0-phy-reset {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__GPIO_2_7    /* PHY Reset */
 					>;
@@ -65,8 +63,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins: leds at 0 {
-					reg = <0>;
+				led_pins: leds {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__GPIO_3_4
 						MX28_PAD_AUART1_TX__GPIO_3_5
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
index b70f334..8773575 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
@@ -58,8 +58,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&hog_pins_cpuimx283>;
 
-	hog_pins_cpuimx283: hog-cpuimx283 at 0 {
-		reg = <0>;
+	hog_pins_cpuimx283: hog-cpuimx283 {
 		fsl,pinmux-ids = <
 			MX28_PAD_ENET0_RX_CLK__GPIO_4_13
 			MX28_PAD_ENET0_TX_CLK__GPIO_4_5
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
index 65efb78..cfd92c3 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
@@ -38,8 +38,7 @@
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hog_pins_cpuimx283 &hog_pins_cpuimx287>;
-	hog_pins_cpuimx287: hog-cpuimx287 at 0 {
-		reg = <0>;
+	hog_pins_cpuimx287: hog-cpuimx287 {
 		fsl,pinmux-ids = <
 			MX28_PAD_SPDIF__GPIO_3_27
 		>;
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
index ff1328c..11f3426 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
@@ -197,8 +197,7 @@
 };
 
 &pinctrl {
-	gpio_button_sw3_pins_mbmx28lc: gpio-button-sw3-mbmx28lc at 0 {
-		reg = <0>;
+	gpio_button_sw3_pins_mbmx28lc: gpio-button-sw3-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D21__GPIO_1_21
 		>;
@@ -207,8 +206,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	gpio_button_sw4_pins_mbmx28lc: gpio-button-sw4-mbmx28lc at 0 {
-		reg = <0>;
+	gpio_button_sw4_pins_mbmx28lc: gpio-button-sw4-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D20__GPIO_1_20
 		>;
@@ -217,8 +215,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	lcdif_pins_mbmx28lc: lcdif-mbmx28lc at 0 {
-		reg = <0>;
+	lcdif_pins_mbmx28lc: lcdif-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_VSYNC__LCD_VSYNC
 			MX28_PAD_LCD_HSYNC__LCD_HSYNC
@@ -230,8 +227,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	led_d6_pins_mbmx28lc: led-d6-mbmx28lc at 0 {
-		reg = <0>;
+	led_d6_pins_mbmx28lc: led-d6-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D23__GPIO_1_23
 		>;
@@ -240,8 +236,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	led_d7_pins_mbmx28lc: led-d7-mbmx28lc at 0 {
-		reg = <0>;
+	led_d7_pins_mbmx28lc: led-d7-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D22__GPIO_1_22
 		>;
@@ -250,8 +245,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	reg_lcd_3v3_pins_mbmx28lc: lcd-3v3-mbmx28lc at 0 {
-		reg = <0>;
+	reg_lcd_3v3_pins_mbmx28lc: lcd-3v3-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_RESET__GPIO_3_30
 		>;
@@ -260,8 +254,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	reg_usb0_vbus_pins_mbmx28lc: reg-usb0-vbus-mbmx28lc at 0 {
-		reg = <0>;
+	reg_usb0_vbus_pins_mbmx28lc: reg-usb0-vbus-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D18__GPIO_1_18
 		>;
@@ -270,8 +263,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	reg_usb1_vbus_pins_mbmx28lc: reg-usb1-vbus-mbmx28lc at 0 {
-		reg = <0>;
+	reg_usb1_vbus_pins_mbmx28lc: reg-usb1-vbus-mbmx28lc {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D19__GPIO_1_19
 		>;
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index b0d3965..7f849de 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -67,8 +67,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP1_CMD__GPIO_2_13
 						MX28_PAD_SSP1_DATA3__GPIO_2_15
@@ -84,8 +83,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pin_gpio3_5: led_gpio3_5 at 0 {
-					reg = <0>;
+				led_pin_gpio3_5: led_gpio3_5 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_TX__GPIO_3_5
 					>;
@@ -94,8 +92,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_pins_evk: gpmi-nand-evk at 0 {
-					reg = <0>;
+				gpmi_pins_evk: gpmi-nand-evk {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_CE1N__GPMI_CE1N
 						MX28_PAD_GPMI_RDY1__GPMI_READY1
@@ -105,8 +102,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_evk: lcdif-evk at 0 {
-					reg = <0>;
+				lcdif_pins_evk: lcdif-evk {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RD_E__LCD_VSYNC
 						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 3bb5ffc..8af939c 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -67,8 +67,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS0__GPIO_2_19
 						MX28_PAD_PWM4__GPIO_3_29
@@ -80,8 +79,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_m28: lcdif-m28 at 0 {
-					reg = <0>;
+				lcdif_pins_m28: lcdif-m28 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_VSYNC__LCD_VSYNC
 						MX28_PAD_LCD_HSYNC__LCD_HSYNC
@@ -95,8 +93,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pins_gpio: leds-m28 at 0 {
-					reg = <0>;
+				led_pins_gpio: leds-m28 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP3_MISO__GPIO_2_26
 						MX28_PAD_SSP3_SCK__GPIO_2_24
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 7d97a0c..639e1b3 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -51,8 +51,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM3__GPIO_3_28
 						MX28_PAD_AUART2_CTS__GPIO_3_10
@@ -65,8 +64,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_pins_m28: lcdif-m28 at 0 {
-					reg = <0>;
+				lcdif_pins_m28: lcdif-m28 {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_DOTCLK__LCD_DOTCLK
 						MX28_PAD_LCD_ENABLE__LCD_ENABLE
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 2393e839..13d2bba 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -26,8 +26,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
-					reg = <0>;
+				hog_pins_a: hog-gpios {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D00__GPIO_0_0
 						MX28_PAD_GPMI_D03__GPIO_0_3
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
index f8a09a8..758e70d 100644
--- a/arch/arm/boot/dts/imx28-ts4600.dts
+++ b/arch/arm/boot/dts/imx28-ts4600.dts
@@ -39,8 +39,7 @@
 
 			pinctrl at 80018000 {
 
-				en_sd_pwr: en-sd-pwr@0 {
-					reg = <0>;
+				en_sd_pwr: en-sd-pwr {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM3__GPIO_3_28
 					>;
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index e4f19f9b..32794e9 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -516,8 +516,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&hog_pins_a>;
 
-	hog_pins_a: hog at 0 {
-		reg = <0>;
+	hog_pins_a: hog {
 		fsl,pinmux-ids = <
 			MX28_PAD_ENET0_RXD3__GPIO_4_10 /* module LED */
 		>;
@@ -526,8 +525,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_edt_ft5x06_pins: tx28-edt-ft5x06-pins at 0 {
-		reg = <0>;
+	tx28_edt_ft5x06_pins: tx28-edt-ft5x06-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_SSP0_DATA6__GPIO_2_6 /* RESET */
 			MX28_PAD_SSP0_DATA5__GPIO_2_5 /* IRQ */
@@ -538,8 +536,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_flexcan_xcvr_pins: tx28-flexcan-xcvr-pins at 0 {
-		reg = <0>;
+	tx28_flexcan_xcvr_pins: tx28-flexcan-xcvr-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D00__GPIO_1_0
 		>;
@@ -548,8 +545,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_lcdif_23bit_pins: tx28-lcdif-23bit at 0 {
-		reg = <0>;
+	tx28_lcdif_23bit_pins: tx28-lcdif-23bit {
 		fsl,pinmux-ids = <
 			/* LCD_D00 may be used as Flexcan Transceiver Enable on STK5-V5 */
 			MX28_PAD_LCD_D01__LCD_D1
@@ -581,8 +577,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_lcdif_ctrl_pins: tx28-lcdif-ctrl at 0 {
-		reg = <0>;
+	tx28_lcdif_ctrl_pins: tx28-lcdif-ctrl {
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_ENABLE__GPIO_1_31 /* Enable */
 			MX28_PAD_LCD_RESET__GPIO_3_30  /* Reset */
@@ -592,8 +587,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_mac0_pins_gpio: tx28-mac0-gpio-pins at 0 {
-		reg = <0>;
+	tx28_mac0_pins_gpio: tx28-mac0-gpio-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_ENET0_MDC__GPIO_4_0
 			MX28_PAD_ENET0_MDIO__GPIO_4_1
@@ -610,8 +604,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_pca9554_pins: tx28-pca9554-pins at 0 {
-		reg = <0>;
+	tx28_pca9554_pins: tx28-pca9554-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_PWM3__GPIO_3_28
 		>;
@@ -620,8 +613,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_spi_gpio_pins: spi-gpiogrp at 0 {
-		reg = <0>;
+	tx28_spi_gpio_pins: spi-gpiogrp {
 		fsl,pinmux-ids = <
 			MX28_PAD_AUART2_RX__GPIO_3_8
 			MX28_PAD_AUART2_TX__GPIO_3_9
@@ -635,8 +627,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_tsc2007_pins: tx28-tsc2007-pins at 0 {
-		reg = <0>;
+	tx28_tsc2007_pins: tx28-tsc2007-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_SAIF0_MCLK__GPIO_3_20 /* TSC2007 IRQ */
 		>;
@@ -646,8 +637,7 @@
 	};
 
 
-	tx28_usbphy0_pins: tx28-usbphy0-pins at 0 {
-		reg = <0>;
+	tx28_usbphy0_pins: tx28-usbphy0-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_GPMI_CE2N__GPIO_0_18 /* USBOTG_VBUSEN */
 			MX28_PAD_GPMI_CE3N__GPIO_0_19 /* USBOTH_OC */
@@ -657,8 +647,7 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_usbphy1_pins: tx28-usbphy1-pins at 0 {
-		reg = <0>;
+	tx28_usbphy1_pins: tx28-usbphy1-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_SPDIF__GPIO_3_27 /* USBH_VBUSEN */
 			MX28_PAD_JTAG_RTCK__GPIO_4_20 /* USBH_OC */
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 9ad8d35..8f46b1f 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -169,14 +169,11 @@
 			};
 
 			pinctrl: pinctrl@80018000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "fsl,imx28-pinctrl", "simple-bus";
 				reg = <0x80018000 0x2000>;
 
-				gpio0: gpio at 0 {
+				gpio0: gpio0 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
-					reg = <0>;
 					interrupts = <127>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -184,9 +181,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio1: gpio at 1 {
+				gpio1: gpio1 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
-					reg = <1>;
 					interrupts = <126>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -194,9 +190,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio2: gpio at 2 {
+				gpio2: gpio2 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
-					reg = <2>;
 					interrupts = <125>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -204,9 +199,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio3: gpio at 3 {
+				gpio3: gpio3 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
-					reg = <3>;
 					interrupts = <124>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -214,9 +208,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio4: gpio at 4 {
+				gpio4: gpio4 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
-					reg = <4>;
 					interrupts = <123>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -224,8 +217,7 @@
 					#interrupt-cells = <2>;
 				};
 
-				duart_pins_a: duart at 0 {
-					reg = <0>;
+				duart_pins_a: duart0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM0__DUART_RX
 						MX28_PAD_PWM1__DUART_TX
@@ -235,8 +227,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				duart_pins_b: duart at 1 {
-					reg = <1>;
+				duart_pins_b: duart1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_CTS__DUART_RX
 						MX28_PAD_AUART0_RTS__DUART_TX
@@ -246,8 +237,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				duart_4pins_a: duart-4pins at 0 {
-					reg = <0>;
+				duart_4pins_a: duart-4pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_CTS__DUART_RX
 						MX28_PAD_AUART0_RTS__DUART_TX
@@ -259,8 +249,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_pins_a: gpmi-nand at 0 {
-					reg = <0>;
+				gpmi_pins_a: gpmi-nand {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D00__GPMI_D0
 						MX28_PAD_GPMI_D01__GPMI_D1
@@ -283,8 +272,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_status_cfg: gpmi-status-cfg at 0 {
-					reg = <0>;
+				gpmi_status_cfg: gpmi-status-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDN__GPMI_RDN
 						MX28_PAD_GPMI_WRN__GPMI_WRN
@@ -293,8 +281,7 @@
 					fsl,drive-strength = <MXS_DRIVE_12mA>;
 				};
 
-				auart0_pins_a: auart0 at 0 {
-					reg = <0>;
+				auart0_pins_a: auart0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_RX__AUART0_RX
 						MX28_PAD_AUART0_TX__AUART0_TX
@@ -306,8 +293,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart0_2pins_a: auart0-2pins at 0 {
-					reg = <0>;
+				auart0_2pins_a: auart0-2pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_RX__AUART0_RX
 						MX28_PAD_AUART0_TX__AUART0_TX
@@ -317,8 +303,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart1_pins_a: auart1 at 0 {
-					reg = <0>;
+				auart1_pins_a: auart1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__AUART1_RX
 						MX28_PAD_AUART1_TX__AUART1_TX
@@ -330,8 +315,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart1_2pins_a: auart1-2pins at 0 {
-					reg = <0>;
+				auart1_2pins_a: auart1-2pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__AUART1_RX
 						MX28_PAD_AUART1_TX__AUART1_TX
@@ -341,8 +325,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart2_2pins_a: auart2-2pins at 0 {
-					reg = <0>;
+				auart2_2pins_a: auart2-2pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__AUART2_RX
 						MX28_PAD_SSP2_MOSI__AUART2_TX
@@ -352,8 +335,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart2_2pins_b: auart2-2pins at 1 {
-					reg = <1>;
+				auart2_2pins_b: auart2-2pinsb {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART2_RX__AUART2_RX
 						MX28_PAD_AUART2_TX__AUART2_TX
@@ -363,8 +345,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart2_pins_a: auart2-pins at 0 {
-					reg = <0>;
+				auart2_pins_a: auart2-pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART2_RX__AUART2_RX
 						MX28_PAD_AUART2_TX__AUART2_TX
@@ -376,8 +357,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart3_pins_a: auart3 at 0 {
-					reg = <0>;
+				auart3_pins_a: auart3 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART3_RX__AUART3_RX
 						MX28_PAD_AUART3_TX__AUART3_TX
@@ -389,8 +369,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart3_2pins_a: auart3-2pins at 0 {
-					reg = <0>;
+				auart3_2pins_a: auart3-2pins {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_MISO__AUART3_RX
 						MX28_PAD_SSP2_SS0__AUART3_TX
@@ -400,8 +379,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart3_2pins_b: auart3-2pins at 1 {
-					reg = <1>;
+				auart3_2pins_b: auart3-2pinsb {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART3_RX__AUART3_RX
 						MX28_PAD_AUART3_TX__AUART3_TX
@@ -411,8 +389,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart4_2pins_a: auart4 at 0 {
-					reg = <0>;
+				auart4_2pins_a: auart4 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP3_SCK__AUART4_TX
 						MX28_PAD_SSP3_MOSI__AUART4_RX
@@ -422,8 +399,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart4_2pins_b: auart4 at 1 {
-					reg = <1>;
+				auart4_2pins_b: auart4b {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_CTS__AUART4_RX
 						MX28_PAD_AUART0_RTS__AUART4_TX
@@ -433,8 +409,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mac0_pins_a: mac0 at 0 {
-					reg = <0>;
+				mac0_pins_a: mac0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_ENET0_MDC__ENET0_MDC
 						MX28_PAD_ENET0_MDIO__ENET0_MDIO
@@ -451,8 +426,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mac0_pins_b: mac0 at 1 {
-					reg = <1>;
+				mac0_pins_b: mac0b {
 					fsl,pinmux-ids = <
 						MX28_PAD_ENET0_MDC__ENET0_MDC
 						MX28_PAD_ENET0_MDIO__ENET0_MDIO
@@ -477,8 +451,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mac1_pins_a: mac1 at 0 {
-					reg = <0>;
+				mac1_pins_a: mac1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_ENET0_CRS__ENET1_RX_EN
 						MX28_PAD_ENET0_RXD2__ENET1_RXD0
@@ -492,8 +465,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_8bit_pins_a: mmc0-8bit at 0 {
-					reg = <0>;
+				mmc0_8bit_pins_a: mmc0-8bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA0__SSP0_D0
 						MX28_PAD_SSP0_DATA1__SSP0_D1
@@ -512,8 +484,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_4bit_pins_a: mmc0-4bit at 0 {
-					reg = <0>;
+				mmc0_4bit_pins_a: mmc0-4bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA0__SSP0_D0
 						MX28_PAD_SSP0_DATA1__SSP0_D1
@@ -528,16 +499,14 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_cd_cfg: mmc0-cd-cfg at 0 {
-					reg = <0>;
+				mmc0_cd_cfg: mmc0-cd-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT
 					>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc0_sck_cfg: mmc0-sck-cfg at 0 {
-					reg = <0>;
+				mmc0_sck_cfg: mmc0-sck-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_SCK__SSP0_SCK
 					>;
@@ -545,8 +514,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc1_4bit_pins_a: mmc1-4bit at 0 {
-					reg = <0>;
+				mmc1_4bit_pins_a: mmc1-4bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_D00__SSP1_D0
 						MX28_PAD_GPMI_D01__SSP1_D1
@@ -561,16 +529,14 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc1_cd_cfg: mmc1-cd-cfg at 0 {
-					reg = <0>;
+				mmc1_cd_cfg: mmc1-cd-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT
 					>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc1_sck_cfg: mmc1-sck-cfg at 0 {
-					reg = <0>;
+				mmc1_sck_cfg: mmc1-sck-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_WRN__SSP1_SCK
 					>;
@@ -579,8 +545,7 @@
 				};
 
 
-				mmc2_4bit_pins_a: mmc2-4bit at 0 {
-					reg = <0>;
+				mmc2_4bit_pins_a: mmc2-4bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA4__SSP2_D0
 						MX28_PAD_SSP1_SCK__SSP2_D1
@@ -595,8 +560,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc2_4bit_pins_b: mmc2-4bit at 1 {
-					reg = <1>;
+				mmc2_4bit_pins_b: mmc2-4bitb {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__SSP2_SCK
 						MX28_PAD_SSP2_MOSI__SSP2_CMD
@@ -611,16 +575,14 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc2_cd_cfg: mmc2-cd-cfg at 0 {
-					reg = <0>;
+				mmc2_cd_cfg: mmc2-cd-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RX__SSP2_CARD_DETECT
 					>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc2_sck_cfg_a: mmc2-sck-cfg at 0 {
-					reg = <0>;
+				mmc2_sck_cfg_a: mmc2-sck-cfg {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__SSP2_SCK
 					>;
@@ -628,8 +590,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc2_sck_cfg_b: mmc2-sck-cfg at 1 {
-					reg = <1>;
+				mmc2_sck_cfg_b: mmc2-sck-cfgb {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__SSP2_SCK
 					>;
@@ -637,8 +598,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				i2c0_pins_a: i2c0 at 0 {
-					reg = <0>;
+				i2c0_pins_a: i2c0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_I2C0_SCL__I2C0_SCL
 						MX28_PAD_I2C0_SDA__I2C0_SDA
@@ -648,8 +608,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c0_pins_b: i2c0 at 1 {
-					reg = <1>;
+				i2c0_pins_b: i2c0b {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART0_RX__I2C0_SCL
 						MX28_PAD_AUART0_TX__I2C0_SDA
@@ -659,8 +618,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c1_pins_a: i2c1 at 0 {
-					reg = <0>;
+				i2c1_pins_a: i2c1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM0__I2C1_SCL
 						MX28_PAD_PWM1__I2C1_SDA
@@ -670,8 +628,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c1_pins_b: i2c1 at 1 {
-					reg = <1>;
+				i2c1_pins_b: i2c1n {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART2_CTS__I2C1_SCL
 						MX28_PAD_AUART2_RTS__I2C1_SDA
@@ -681,8 +638,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				saif0_pins_a: saif0 at 0 {
-					reg = <0>;
+				saif0_pins_a: saif0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__SAIF0_MCLK
 						MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK
@@ -694,8 +650,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				saif0_pins_b: saif0 at 1 {
-					reg = <1>;
+				saif0_pins_b: saif0b {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK
 						MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK
@@ -706,8 +661,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				saif1_pins_a: saif1 at 0 {
-					reg = <0>;
+				saif1_pins_a: saif1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0
 					>;
@@ -716,8 +670,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				pwm0_pins_a: pwm0 at 0 {
-					reg = <0>;
+				pwm0_pins_a: pwm0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM0__PWM_0
 					>;
@@ -726,8 +679,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				pwm2_pins_a: pwm2 at 0 {
-					reg = <0>;
+				pwm2_pins_a: pwm2 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM2__PWM_2
 					>;
@@ -736,8 +688,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				pwm3_pins_a: pwm3 at 0 {
-					reg = <0>;
+				pwm3_pins_a: pwm3 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM3__PWM_3
 					>;
@@ -746,8 +697,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				pwm3_pins_b: pwm3 at 1 {
-					reg = <1>;
+				pwm3_pins_b: pwm3b {
 					fsl,pinmux-ids = <
 						MX28_PAD_SAIF0_MCLK__PWM_3
 					>;
@@ -756,8 +706,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				pwm4_pins_a: pwm4 at 0 {
-					reg = <0>;
+				pwm4_pins_a: pwm4 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM4__PWM_4
 					>;
@@ -766,8 +715,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_24bit_pins_a: lcdif-24bit at 0 {
-					reg = <0>;
+				lcdif_24bit_pins_a: lcdif-24bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -799,8 +747,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_18bit_pins_a: lcdif-18bit at 0 {
-					reg = <0>;
+				lcdif_18bit_pins_a: lcdif-18bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -826,8 +773,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_16bit_pins_a: lcdif-16bit at 0 {
-					reg = <0>;
+				lcdif_16bit_pins_a: lcdif-16bit {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_D00__LCD_D0
 						MX28_PAD_LCD_D01__LCD_D1
@@ -851,8 +797,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_sync_pins_a: lcdif-sync at 0 {
-					reg = <0>;
+				lcdif_sync_pins_a: lcdif-sync {
 					fsl,pinmux-ids = <
 						MX28_PAD_LCD_RS__LCD_DOTCLK
 						MX28_PAD_LCD_CS__LCD_ENABLE
@@ -864,8 +809,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				can0_pins_a: can0 at 0 {
-					reg = <0>;
+				can0_pins_a: can0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_RDY2__CAN0_TX
 						MX28_PAD_GPMI_RDY3__CAN0_RX
@@ -875,8 +819,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				can1_pins_a: can1 at 0 {
-					reg = <0>;
+				can1_pins_a: can1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_GPMI_CE2N__CAN1_TX
 						MX28_PAD_GPMI_CE3N__CAN1_RX
@@ -886,8 +829,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				spi2_pins_a: spi2 at 0 {
-					reg = <0>;
+				spi2_pins_a: spi2 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SCK__SSP2_SCK
 						MX28_PAD_SSP2_MOSI__SSP2_CMD
@@ -899,8 +841,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				spi3_pins_a: spi3 at 0 {
-					reg = <0>;
+				spi3_pins_a: spi3 {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART2_RX__SSP3_D4
 						MX28_PAD_AUART2_TX__SSP3_D5
@@ -914,8 +855,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				spi3_pins_b: spi3 at 1 {
-					reg = <1>;
+				spi3_pins_b: spi3b {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP3_SCK__SSP3_SCK
 						MX28_PAD_SSP3_MOSI__SSP3_CMD
@@ -927,8 +867,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				usb0_pins_a: usb0 at 0 {
-					reg = <0>;
+				usb0_pins_a: usb0 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS2__USB0_OVERCURRENT
 					>;
@@ -937,8 +876,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usb0_pins_b: usb0 at 1 {
-					reg = <1>;
+				usb0_pins_b: usb0b {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_CTS__USB0_OVERCURRENT
 					>;
@@ -947,8 +885,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usb1_pins_a: usb1 at 0 {
-					reg = <0>;
+				usb1_pins_a: usb1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS1__USB1_OVERCURRENT
 					>;
@@ -957,8 +894,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usb0_id_pins_a: usb0id at 0 {
-					reg = <0>;
+				usb0_id_pins_a: usb0id {
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_RTS__USB0_ID
 					>;
@@ -967,8 +903,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				usb0_id_pins_b: usb0id1 at 0 {
-					reg = <0>;
+				usb0_id_pins_b: usb0id1 {
 					fsl,pinmux-ids = <
 						MX28_PAD_PWM2__USB0_ID
 					>;
-- 
2.7.4
