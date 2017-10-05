From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 5 Oct 2017 15:23:34 +0200
Subject: [PATCH] ARM64: dts: meson-gxbb-nexbox-a95x: Enable USB Nodes
In-Reply-To: <20171005132118.2150-1-peter@korsgaard.com>
References: <20171005132118.2150-1-peter@korsgaard.com>
Message-ID: <89e9980a-2ca6-4509-b9d5-36aac433b9bd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2017 15:21, Peter Korsgaard wrote:
> Enable both gxbb USB controllers and add a 5V regulator for the OTG port
> VBUS, similar to p20x.
> 
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 38dfdde5c147..60cd9c3b11c8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -88,6 +88,18 @@
>  		};
>  	};
>  
> +	usb_pwr: regulator-usb-pwrs {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "USB_PWR";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	vddio_card: gpio-regulator {
>  		compatible = "regulator-gpio";
>  
> @@ -294,3 +306,20 @@
>  	pinctrl-0 = <&uart_ao_a_pins>;
>  	pinctrl-names = "default";
>  };
> +
> +&usb0_phy {
> +	status = "okay";
> +	phy-supply = <&usb_pwr>;
> +};
> +
> +&usb1_phy {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> 

Indeed, I forgot to add USB to this board,
Thanks

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
