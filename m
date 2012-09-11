From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 11 Sep 2012 12:09:34 +0200
Subject: [PATCH v2 2/3] arm/dts: Add twl4030-usb data
In-Reply-To: <1347345381-4390-3-git-send-email-kishon@ti.com>
References: <1347345381-4390-1-git-send-email-kishon@ti.com>
 <1347345381-4390-3-git-send-email-kishon@ti.com>
Message-ID: <504F0DDE.308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 08:36 AM, Kishon Vijay Abraham I wrote:
> Add twl4030-usb data node in twl4030 device tree file.

IIRC, the usb part on twl4030 was doing more than it does on twl6030.

Could you describe what part of the USB is really done by the TWL in
that case?

> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 22f4d13..761a5a5 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -37,6 +37,18 @@
>  		regulator-max-microvolt = <3150000>;
>  	};
>  
> +	vusb1v5: regulator-vusb1v5 {
> +		compatible = "ti,twl4030-vusb1v5";
> +	};
> +
> +	vusb1v8: regulator-vusb1v8 {
> +		compatible = "ti,twl4030-vusb1v8";
> +	};
> +
> +	vusb3v1: regulator-vusb3v1 {
> +		compatible = "ti,twl4030-vusb3v1";
> +	};
> +
>  	twl_gpio: gpio {
>  		compatible = "ti,twl4030-gpio";
>  		gpio-controller;
> @@ -44,4 +56,13 @@
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
>  	};
> +
> +	twl4030-usb {

Same comment than before about the name. Is it the usb-comparator as well?

> +		compatible = "ti,twl4030-usb";
> +		interrupts = < 10 4 >;
> +		usb1v5-supply = <&vusb1v5>;
> +		usb1v8-supply = <&vusb1v8>;
> +		usb3v1-supply = <&vusb3v1>;
> +		usb_mode = <1>;

Is this a TI only attribute or something generic?

If this is TI only, it should be prefix with "ti," otherwise, it is fine.

Regards,
Benoit
