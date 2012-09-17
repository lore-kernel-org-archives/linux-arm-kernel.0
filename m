From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 14:46:45 +0800
Subject: [PATCH 2/2] ARM: dts: imx23-olinuxino: Add USB host support
In-Reply-To: <1347557619-17793-2-git-send-email-fabio.estevam@freescale.com>
References: <1347557619-17793-1-git-send-email-fabio.estevam@freescale.com>
 <1347557619-17793-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120917064643.GD6413@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 02:33:39PM -0300, Fabio Estevam wrote:
> Add USB host support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index 711dcf5..daddd1e 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -40,6 +40,7 @@
>  					reg = <0>;
>  					fsl,pinmux-ids = <
>  						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
> +						0x0113 /* MX23_PAD_GPMI_ALE__GPIO_0_17 */
>  					>;
>  					fsl,drive-strength = <0>;
>  					fsl,voltage = <1>;
> @@ -60,6 +61,31 @@
>  				pinctrl-0 = <&auart0_2pins_a>;
>  				status = "okay";
>  			};
> +
> +			usbphy0: usbphy at 8007c000 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ahb at 80080000 {
> +		usb0: usb at 80080000 {
> +			vbus-supply = <&reg_usb0_vbus>;
> +			status = "okay";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb0_vbus: usb0_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb0_vbus";
> +			regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;

The indentation needs a fix.

> +			enable-active-high;
> +			startup-delay-us = <300>; /* LAN9215 requires a POR of 200us minimum */

So the regulator also supplies LAN9215?

Regards,
Shawn

> +			gpio = <&gpio0 17 0>;
>  		};
>  	};
>  
> -- 
> 1.7.9.5
> 
> 
