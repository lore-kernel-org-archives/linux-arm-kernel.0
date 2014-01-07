From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 20:56:00 +0800
Subject: [PATCHv3][ 2/2] ARM: dts: Add support for the cpuimx53 board
 from Eukrea and its baseboard.
In-Reply-To: <1389024968-20242-2-git-send-email-denis@eukrea.com>
References: <1389024968-20242-1-git-send-email-denis@eukrea.com>
 <1389024968-20242-2-git-send-email-denis@eukrea.com>
Message-ID: <20140107125558.GH12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 05:16:08PM +0100, Denis Carikli wrote:
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1 &pinctrl_esdhc1_cd>;
> +	cd-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
> +	vqmmc-supply = <&reg_3p3v>;
> +	vmmc-supply = <&reg_3p3v>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	imx53-eukrea {
> +		pinctrl_esdhc1: esdhc1 {

s/esdhc1/esdhc1grp

> +			fsl,pins = <MX53_ESDHC1_PINGRP1>;
> +		};
> +
> +		pinctrl_esdhc1_cd: esdhc1_cd {
> +			fsl,pins = <MX53_PAD_DISP0_DAT23__GPIO5_17 0x80000000>;
> +		};

Please merge above two nodes into one as below.

	pinctrl_esdhc1: esdhc1grp {
		fsl,pins = <
			MX53_ESDHC1_PINGRP1
			MX53_PAD_DISP0_DAT23__GPIO5_17 0x80000000 /* CD */
		>;
	};

> +
> +		pinctrl_gpiokeys: gpiokeysgrp {
> +			fsl,pins = <MX53_PAD_KEY_COL4__GPIO4_14 0x80000000>;
> +		};
> +
> +		pinctrl_gpioled: gpioledgrp {
> +			fsl,pins = <MX53_PAD_KEY_ROW4__GPIO4_15 0x80000000>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <MX53_UART1_PINGRP2 MX53_UART1_PINGRP3>;

Please put two macros onto two lines.

Shawn

> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <MX53_UART2_PINGRP2>;
> +		};
> +	};
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
