From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 12:45:01 +0800
Subject: [PATCHv10][ 2/3] ARM: dts: Add support for the cpuimx35 board
 from Eukrea and its baseboard.
In-Reply-To: <1389368441-26310-2-git-send-email-denis@eukrea.com>
References: <1389368441-26310-1-git-send-email-denis@eukrea.com>
 <1389368441-26310-2-git-send-email-denis@eukrea.com>
Message-ID: <20140113044459.GM23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 04:40:40PM +0100, Denis Carikli wrote:
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx35-eukrea {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX35_PAD_LD18__GPIO3_24  0x80000000
> +				MX35_PAD_LD19__GPIO3_25  0x80000000
> +				MX35_PAD_LD23__GPIO3_29  0x80000000

Create pinctrl entry for gpio-leds and gpio-keys to contain them just
like other devices, and move ESDHC CD pin into esdhc1grp, so that we do
not need this hoggrp.  The hoggrp should only hold the pins that do not
really belong to any client devices.

> +			>;
> +		};
> +
> +		pinctrl_audmux: audmuxgrp {
> +			fsl,pins = <MX35_AUDMUX_PINGRP1>;
> +		};
> +
> +		pinctrl_esdhc1: esdhc1grp {
> +			fsl,pins = <MX35_ESDHC1_PINGRP1>;
> +		};
> +
> +		pinctrl_fec: fecgrp {
> +			fsl,pins = <MX35_FEC_PINGRP1>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <MX35_I2C1_PINGRP1>;
> +		};
> +
> +		pinctrl_reg_lcd_3v3: reg-lcd-3v3 {
> +			fsl,pins = <MX35_PAD_D3_CLS__GPIO1_4 0x80000000>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <MX35_UART1_PINGRP1 MX35_UART1_RTSCTS_PINGRP1>;

Split it into two lines, one macro each.

> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <MX35_UART2_PINGRP1 MX35_UART2_RTSCTS_PINGRP1>;

Ditto

Shawn

> +		};
> +	};
> +};
> +
> +&ssi1 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> -- 
> 1.7.9.5
> 
