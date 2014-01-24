From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 11:50:05 +0000
Subject: [PATCH] ARM-i.MX6Q-dts : Added USB_OTG Support
In-Reply-To: <1390555724-9779-1-git-send-email-ashutosh.s@phytec.in>
References: <1390555724-9779-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <20140124115005.GG814@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 09:28:44AM +0000, Ashutosh singh wrote:
> This patch adds support for USB_OTG on Phytec phyFLEX-i.MX6 Quad module.
> 
> Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
> ---
>  arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
>  arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> index 7d37ec6..39e69bd 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> +++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
> @@ -32,3 +32,7 @@
>  &usdhc3 {
>  	status = "okay";
>  };
> +
> +&usbotg {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> index 1a3b50d..dcb1d59 100644
> --- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
> @@ -18,6 +18,19 @@
>  	memory {
>  		reg = <0x10000000 0x80000000>;
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";

This is _not_ a simple bus. It doesn't have the required ranges
property.

Why do these need to be in a regulators container node? We don't group
dma controllers under a dmas node, or uarts under a uarts node.

> +
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio4 15 0>;
> +			enable-active-low;
> +		};
> +	};
>  };

Thanks,
Mark.
