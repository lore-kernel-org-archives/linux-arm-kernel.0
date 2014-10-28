From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 22:51:37 +0100
Subject: [PATCH 2/5] ARM: dtsi: sunxi: add common VBUS regulator
In-Reply-To: <210cc2a03d43e3d65b08f302b3b32663044ad94f.1414444953.git.rbyshko@gmail.com>
References: <cover.1414444953.git.rbyshko@gmail.com>
 <210cc2a03d43e3d65b08f302b3b32663044ad94f.1414444953.git.rbyshko@gmail.com>
Message-ID: <20141028215137.GG9255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 10:43:02PM +0100, Roman Byshko wrote:
> Until now the regulator nodes for powering USB VBUS
> existed only for the two host controllers. Now the regulator
> is added for USB OTG too.
> ---
>  arch/arm/boot/dts/sunxi-common-regulators.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> index c9c5b10..f521672 100644
> --- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> +++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
> @@ -21,6 +21,13 @@
>  				allwinner,pull = <0>;
>  			};
>  
> +			usb0_vbus_pin_a: usb0_vbus_pin at 0 {
> +				allwinner,pins = "PB9";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
>  			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
>  				allwinner,pins = "PH6";
>  				allwinner,function = "gpio_out";
> @@ -49,6 +56,18 @@
>  		status = "disabled";
>  	};
>  
> +	reg_usb0_vbus: usb0-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb0_vbus_pin_a>;
> +		regulator-name = "usb0-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&pio 1 9 0>;
> +		status = "disabled";
> +	};

We're using these regulators because a huuuge majority of the boards
out there, regardless of their SoC, are using the same GPIO to drive
the same regulator. Is this the case here? What board have you looked
at?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/644628e5/attachment.sig>
