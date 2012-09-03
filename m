From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Sep 2012 22:39:09 +0800
Subject: [PATCHv2] ARM: dts: mxs: Enable USB1 Host on the CFA-10049
 expansion board
In-Reply-To: <1346681725-19195-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346681725-19195-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120903143906.GG2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 04:15:25PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx28-cfa10049.dts |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index a0c7b83..f8f8dd4 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -31,6 +31,31 @@
>  				pinctrl-0 = <&i2c1_pins_a>;
>  				status = "okay";
>  			};
> +
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
>  		};
>  	};
>  };
> -- 
> 1.7.9.5
> 
