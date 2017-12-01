From: venkataravi.e@techveda.org (venkataravi.e at techveda.org)
Date: Fri,  1 Dec 2017 12:08:31 +0530
Subject: [PATCH 4/4] arm: dts: imx28: Device tree cleanup
In-Reply-To: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
References: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
Message-ID: <1512110311-15788-5-git-send-email-venkataravi.e@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravi Eluri <venkataravi.e@techveda.org>

Cleaned up device tree.

Signed-off-by: Ravi Eluri <venkataravi.e@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- This is the fourth patch of the four patch series.
- Patch was compile tested and built(ARCH=arm, imx28) on linux-next
  (latest).
- No build issues reported.
- Please discard this changeset, if this is not making any better.
---
 arch/arm/boot/dts/imx28-evk.dts | 448 ++++++++++++++++++++--------------------
 1 file changed, 224 insertions(+), 224 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 9d74486..eb683264 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -121,249 +121,249 @@
 	};
 };
 
-			&gpmi {
-				pinctrl-names = "default";
-				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
-					     &gpmi_pins_evk>;
-				status = "okay";
-			};
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
+		     &gpmi_pins_evk>;
+	status = "okay";
+};
 
-			&ssp0 {
-				compatible = "fsl,imx28-mmc";
-				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_8bit_pins_a
-					&mmc0_cd_cfg &mmc0_sck_cfg>;
-				bus-width = <8>;
-				wp-gpios = <&gpio2 12 0>;
-				vmmc-supply = <&reg_vddio_sd0>;
-				status = "okay";
-			};
+&ssp0 {
+	compatible = "fsl,imx28-mmc";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_8bit_pins_a
+		     &mmc0_cd_cfg &mmc0_sck_cfg>;
+	bus-width = <8>;
+	wp-gpios = <&gpio2 12 0>;
+	vmmc-supply = <&reg_vddio_sd0>;
+	status = "okay";
+};
 
-			&ssp1 {
-				compatible = "fsl,imx28-mmc";
-				bus-width = <8>;
-				wp-gpios = <&gpio0 28 0>;
-			};
+&ssp1 {
+	compatible = "fsl,imx28-mmc";
+	bus-width = <8>;
+	wp-gpios = <&gpio0 28 0>;
+};
 
-			&ssp2 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx28-spi";
-				pinctrl-names = "default";
-				pinctrl-0 = <&spi2_pins_a>;
-				status = "okay";
-
-				flash: m25p80 at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "sst,sst25vf016b", "jedec,spi-nor";
-					spi-max-frequency = <40000000>;
-					reg = <0>;
-				};
-			};
+&ssp2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
 
-			&pinctrl {
-				pinctrl-names = "default";
-				pinctrl-0 = <&hog_pins_a>;
-
-				hog_pins_a: hog at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_SSP1_CMD__GPIO_2_13
-						MX28_PAD_SSP1_DATA3__GPIO_2_15
-						MX28_PAD_ENET0_RX_CLK__GPIO_4_13
-						MX28_PAD_SSP1_SCK__GPIO_2_12
-						MX28_PAD_PWM3__GPIO_3_28
-						MX28_PAD_LCD_RESET__GPIO_3_30
-						MX28_PAD_AUART2_RX__GPIO_3_8
-						MX28_PAD_AUART2_TX__GPIO_3_9
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-
-				led_pin_gpio3_5: led_gpio3_5 at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_AUART1_TX__GPIO_3_5
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-
-				gpmi_pins_evk: gpmi-nand-evk at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_GPMI_CE1N__GPMI_CE1N
-						MX28_PAD_GPMI_RDY1__GPMI_READY1
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-
-				lcdif_pins_evk: lcdif-evk at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						MX28_PAD_LCD_RD_E__LCD_VSYNC
-						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
-						MX28_PAD_LCD_RS__LCD_DOTCLK
-						MX28_PAD_LCD_CS__LCD_ENABLE
-					>;
-					fsl,drive-strength = <MXS_DRIVE_4mA>;
-					fsl,voltage = <MXS_VOLTAGE_HIGH>;
-					fsl,pull-up = <MXS_PULL_DISABLE>;
-				};
-			};
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
+		spi-max-frequency = <40000000>;
+		reg = <0>;
+	};
+};
 
-			&lcdif {
-				pinctrl-names = "default";
-				pinctrl-0 = <&lcdif_24bit_pins_a
-					     &lcdif_pins_evk>;
-				lcd-supply = <&reg_lcd_3v3>;
-				display = <&display0>;
-				status = "okay";
-
-				display0: display0 {
-					bits-per-pixel = <32>;
-					bus-width = <24>;
-
-					display-timings {
-						native-mode = <&timing0>;
-						timing0: timing0 {
-							clock-frequency = <33500000>;
-							hactive = <800>;
-							vactive = <480>;
-							hback-porch = <89>;
-							hfront-porch = <164>;
-							vback-porch = <23>;
-							vfront-porch = <10>;
-							hsync-len = <10>;
-							vsync-len = <10>;
-							hsync-active = <0>;
-							vsync-active = <0>;
-							de-active = <1>;
-							pixelclk-active = <0>;
-						};
-					};
-				};
-			};
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a>;
+
+	hog_pins_a: hog at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_SSP1_CMD__GPIO_2_13
+			MX28_PAD_SSP1_DATA3__GPIO_2_15
+			MX28_PAD_ENET0_RX_CLK__GPIO_4_13
+			MX28_PAD_SSP1_SCK__GPIO_2_12
+			MX28_PAD_PWM3__GPIO_3_28
+			MX28_PAD_LCD_RESET__GPIO_3_30
+			MX28_PAD_AUART2_RX__GPIO_3_8
+			MX28_PAD_AUART2_TX__GPIO_3_9
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+		};
 
-			&can0 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&can0_pins_a>;
-				xceiver-supply = <&reg_can_3v3>;
-				status = "okay";
-			};
+	led_pin_gpio3_5: led_gpio3_5 at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_AUART1_TX__GPIO_3_5
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
 
-			&can1 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&can1_pins_a>;
-				xceiver-supply = <&reg_can_3v3>;
-				status = "okay";
-			};
+	gpmi_pins_evk: gpmi-nand-evk at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_CE1N__GPMI_CE1N
+			MX28_PAD_GPMI_RDY1__GPMI_READY1
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
 
-			&saif0 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&saif0_pins_a>;
-				status = "okay";
-			};
+	lcdif_pins_evk: lcdif-evk at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_LCD_RD_E__LCD_VSYNC
+			MX28_PAD_LCD_WR_RWN__LCD_HSYNC
+			MX28_PAD_LCD_RS__LCD_DOTCLK
+			MX28_PAD_LCD_CS__LCD_ENABLE
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+};
 
-			&saif1 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&saif1_pins_a>;
-				fsl,saif-master = <&saif0>;
-				status = "okay";
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcdif_24bit_pins_a
+		     &lcdif_pins_evk>;
+	lcd-supply = <&reg_lcd_3v3>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <32>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <33500000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <89>;
+				hfront-porch = <164>;
+				vback-porch = <23>;
+				vfront-porch = <10>;
+				hsync-len = <10>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
+		};
+	};
+};
 
-			&lradc {
-				status = "okay";
-				fsl,lradc-touchscreen-wires = <4>;
-				fsl,ave-ctrl = <4>;
-				fsl,ave-delay = <2>;
-				fsl,settling = <10>;
-			};
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0_pins_a>;
+	xceiver-supply = <&reg_can_3v3>;
+	status = "okay";
+};
 
-			&i2c0 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins_a>;
-				status = "okay";
-
-				sgtl5000: codec at a {
-					compatible = "fsl,sgtl5000";
-					reg = <0x0a>;
-					VDDA-supply = <&reg_3p3v>;
-					VDDIO-supply = <&reg_3p3v>;
-					clocks = <&saif0>;
-				};
-
-				at24 at 51 {
-					compatible = "atmel,24c32";
-					pagesize = <32>;
-					reg = <0x51>;
-				};
-			};
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1_pins_a>;
+	xceiver-supply = <&reg_can_3v3>;
+	status = "okay";
+};
 
-			&pwm {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pwm2_pins_a>;
-				status = "okay";
-			};
+&saif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif0_pins_a>;
+	status = "okay";
+};
 
-			&duart {
-				pinctrl-names = "default";
-				pinctrl-0 = <&duart_pins_a>;
-				status = "okay";
-			};
+&saif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif1_pins_a>;
+	fsl,saif-master = <&saif0>;
+	status = "okay";
+};
 
-			&auart0 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart0_pins_a>;
-				uart-has-rtscts;
-				status = "okay";
-			};
+&lradc {
+	status = "okay";
+	fsl,lradc-touchscreen-wires = <4>;
+	fsl,ave-ctrl = <4>;
+	fsl,ave-delay = <2>;
+	fsl,settling = <10>;
+};
 
-			&auart3 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart3_pins_a>;
-				status = "okay";
-			};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	sgtl5000: codec at a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		clocks = <&saif0>;
+	};
 
-			&usbphy0 {
-				status = "okay";
-			};
+	at24 at 51 {
+		compatible = "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x51>;
+	};
+};
 
-			&usbphy1 {
-				status = "okay";
-			};
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2_pins_a>;
+	status = "okay";
+};
 
-		&usb0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb0_id_pins_a>;
-			vbus-supply = <&reg_usb0_vbus>;
-			status = "okay";
-		};
+&duart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&duart_pins_a>;
+	status = "okay";
+};
 
-		&usb1 {
-			vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
-		};
+&auart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart0_pins_a>;
+	uart-has-rtscts;
+	status = "okay";
+};
 
-		&mac0 {
-			phy-mode = "rmii";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mac0_pins_a>;
-			phy-supply = <&reg_fec_3v3>;
-			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
-			phy-reset-duration = <100>;
-			status = "okay";
-		};
+&auart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart3_pins_a>;
+	status = "okay";
+};
 
-		&mac1 {
-			phy-mode = "rmii";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mac1_pins_a>;
-			status = "okay";
-		};
+&usbphy0 {
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_pins_a>;
+	vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <100>;
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac1_pins_a>;
+	status = "okay";
+};
-- 
1.9.1
