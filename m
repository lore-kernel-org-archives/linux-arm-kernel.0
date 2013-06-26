From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jun 2013 17:13:21 +0200
Subject: [PATCH 2/3] ARM: mxs: dt: Add Crystalfontz CFA-10056 device tree
In-Reply-To: <1372258347-18422-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372258347-18422-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372258347-18422-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20130626151321.GD5803@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, Jun 26, 2013 at 04:52:26PM +0200, Alexandre Belloni wrote:
> From: Brian Lilly <brian@crystalfontz.com>
> 
> The CFA-10056 is a breakout board for the CFA-10036, and is
> basically a CFA-10037, with ai 4.3" screen.
                               ^ typo

> Signed-off-by: Brian Lilly <brian@crystalfontz.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx28-cfa10056.dts | 200 +++++++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-cfa10056.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 225d939..d494f37 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx28-cfa10037.dtb \
>  	imx28-cfa10049.dtb \
>  	imx28-cfa10055.dtb \
> +	imx28-cfa10056.dtb \
>  	imx28-cfa10057.dtb \
>  	imx28-evk.dtb \
>  	imx28-m28evk.dtb \
> diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
> new file mode 100644
> index 0000000..47b5016
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-cfa10056.dts
> @@ -0,0 +1,200 @@
> +/*
> + * Copyright 2012 Free Electrons
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/*
> + * The CFA-10056 is an expansion board for the CFA-10036 module, thus we
> + * need to include the CFA-10036 DTS.
> + */
> +/include/ "imx28-cfa10036.dts"
> +
> +/ {
> +	model = "Crystalfontz CFA-10056 Board";
> +	compatible = "crystalfontz,cfa10056", "crystalfontz,cfa10036", "fsl,imx28";
> +
> +	apb at 80000000 {
> +		apbh at 80000000 {
> +			pinctrl at 80018000 {
> +				pinctrl-names = "default", "default";
> +				pinctrl-1 = <&hog_pins_cfa10056
> +					&hog_pins_cfa10056_pullup>;
> +
> +				hog_pins_cfa10056: hog-10056 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x0073 /* MX28_PAD_GPMI_D7__GPIO_0_7 */
> +						0x2153 /* MX28_PAD_SSP2_D5__GPIO_2_21 */
> +						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				hog_pins_cfa10056_pullup: hog-10056-pullup at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2133 /* MX28_PAD_SSP2_D3__GPIO_2_19 */
> +						0x3183 /* MX28_PAD_I2C0_SCL__GPIO_3_24 */
> +						0x3193 /* MX28_PAD_I2C0_SDA__GPIO_3_25 */
> +						0x31a3 /* MX28_PAD_SAIF_SDATA0__GPIO_3_26 */
> +						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

These pins don't seem used in your DT. Are you sure you need them?

> +				spi2_pins_cfa10056: spi2-cfa10056 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2103 /* MX28_PAD_SSP2_SCK__GPIO_2_16 */
> +						0x2113 /* MX28_PAD_SSP2_CMD__GPIO_2_17 */
> +						0x2123 /* MX28_PAD_SSP2_D0__GPIO_2_18 */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi3_pins_cfa10056: spi3-cfa10056 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x0183 /* MX28_PAD_GPMI_RDN__GPIO_0_24 */
> +						0x01c3 /* MX28_PAD_GPMI_RESETN__GPIO_0_28 */
> +						0x0113 /* MX28_PAD_GPMI_CE1N__GPIO_0_17 */
> +						0x01a3 /* MX28_PAD_GPMI_ALE__GPIO_0_26 */
> +						0x01b3 /* MX28_PAD_GPMI_CLE__GPIO_0_27 */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

Ditto.

> +				lcdif_pins_cfa10056: lcdif-evk at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
> +						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
> +						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
> +						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +			};
> +
> +			lcdif at 80030000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&lcdif_24bit_pins_a
> +						 &lcdif_pins_cfa10056>;
> +				display = <&display>;
> +				status = "okay";
> +
> +				display: display {
> +					bits-per-pixel = <32>;
> +					bus-width = <24>;
> +
> +					display-timings {
> +						native-mode = <&timing0>;
> +						timing0: timing0 {
> +							clock-frequency = <32000000>;
> +							hactive = <480>;
> +							vactive = <800>;
> +							hback-porch = <2>;
> +							hfront-porch = <2>;
> +							vback-porch = <2>;
> +							vfront-porch = <2>;
> +							hsync-len = <5>;
> +							vsync-len = <5>;
> +							hsync-active = <0>;
> +							vsync-active = <0>;
> +							de-active = <1>;
> +							pixelclk-active = <1>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		apbx at 80040000 {
> +			i2c1: i2c at 8005a000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c1_pins_a>;
> +				status = "okay";
> +			};

There's no child device on this bus. We don't need to load it (and we
can remove the pinctrl node with it as well).

> +			usbphy1: usbphy at 8007e000 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ahb at 80080000 {
> +		usb1: usb at 80090000 {
> +			vbus-supply = <&reg_usb1_vbus>;
> +			pinctrl-0 = <&usbphy1_pins_a>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb1_vbus: usb1_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio0 7 1>;
> +		};
> +	};
> +
> +	ahb at 80080000 {
> +		mac0: ethernet at 800f0000 {
> +			phy-mode = "rmii";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mac0_pins_a>;
> +			phy-reset-gpios = <&gpio2 21 0>;
> +			phy-reset-duration = <100>;
> +			status = "okay";
> +		};
> +	};
> +
> +	spi2 {
> +		compatible = "spi-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi2_pins_cfa10056>;
> +		status = "okay";
> +		gpio-sck = <&gpio2 16 0>;
> +		gpio-mosi = <&gpio2 17 0>;
> +		gpio-miso = <&gpio2 18 0>;
> +		cs-gpios = <&gpio3 5 0>;
> +		num-chipselects = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hx8369: hx8369 at 0 {
> +			compatible = "himax,hx8369a", "himax,hx8369";
> +			reg = <0>;
> +			spi-max-frequency = <100000>;
> +			spi-cpol;
> +			spi-cpha;
> +			gpios-reset = <&gpio3 30 0>;
> +		};
> +	};
> +
> +	fiq {
> +		compatible = "crystalfontz,cfa10049-fiq";
> +		interrupts = <50>;
> +	};
> +};

This code has never been merged, and even with the unmerged driver the
driver won't load. You should maybe remove it :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/ef9351cc/attachment-0001.sig>
