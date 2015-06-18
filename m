From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jun 2015 07:50:06 +0200
Subject: [PATCH 6/8] ARM: dts: imx: add imx6ul and imx6ul evk board support
In-Reply-To: <1434555569-8237-7-git-send-email-Frank.Li@freescale.com>
References: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
 <1434555569-8237-7-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150618055006.GR6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:39:27PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	fsl,uart-has-rtscts;
> +	/* for DTE mode, add below change */
> +	/* fsl,dte-mode; */
> +	/* pinctrl-0 = <&pinctrl_uart2dte>; */
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	cd-gpios = <&gpio1 19 0>;

Use the correct polarity here. This is probably GPIO_ACTIVE_LOW.

> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;
> +	vmmc-supply = <&reg_sd1_vmmc>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_1>;
> +	imx6ul-evk {

You can put the pinctrl nodes directly under the iomux node since:
5fcdf6a pinctrl: imx: Allow parsing DT without function nodes

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
