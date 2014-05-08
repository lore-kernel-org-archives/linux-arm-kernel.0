From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 May 2014 08:26:16 +0200
Subject: [PATCH] ARM i.MX51: Add Efika MX Smartbook devicetree
In-Reply-To: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140508062616.GF5918@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 01:41:38PM +0400, Alexander Shiyan wrote:
> This patch adds support for Efika MX Smartbook.
> 
> +/ {
> +	model = "Genesi Efika MX Smartbook";
> +	compatible = "genesi,imx51-sb", "fsl,imx51";
> +
> +	chosen {
> +		linux,stdout-path = &uart1;

As a newly introduced board this should use the standard 'stdout-path'
property rather than the Linux specific 'linux,stdout-path' property.

> +	};
> +
> +	memory {
> +		reg = <0x90000000 0x20000000>;
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
> +		pwms = <&pwm1 0 78770>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		enable-gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
> +		default-brightness-level = <6>;
> +        };

Whitespace damage here.

> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	phy_type = "ulpi";
> +	status = "okay";
> +};
> +
> +&usbh2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh2>;
> +	phy_type = "ulpi";
> +	vbus-supply = <&reg_usbh2_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "host";
> +	phy_type = "ulpi";
> +	vbus-supply = <&reg_usbotg_vbus>;
> +	status = "okay";
> +};

>From what I can see ulpi mode is not supported currently in the chipidea
driver. I think that shouldn't block adding these device nodes, but
maybe a comment could clarify this so we get patches instead of bug reports
for USB?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
