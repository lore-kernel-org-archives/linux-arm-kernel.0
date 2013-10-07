From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Oct 2013 22:44:09 +0200
Subject: [PATCH] ARM: sunxi: dts: Add support for the cubieboard3, the
 CubieTruck
In-Reply-To: <1380986247-29112-2-git-send-email-oliver+list@schinagl.nl>
References: <1380986247-29112-1-git-send-email-oliver+list@schinagl.nl>
 <1380986247-29112-2-git-send-email-oliver+list@schinagl.nl>
Message-ID: <20131007204409.GB3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

On Sat, Oct 05, 2013 at 05:17:27PM +0200, oliver+list at schinagl.nl wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
> 
> Cubieboard3, CT

Please change the commit log to something meaningful.

> Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
> ---
>  arch/arm/boot/dts/Makefile                 |  1 +
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 60 ++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index cc0f1fb..171e6c7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -232,6 +232,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>  	sun5i-a13-olinuxino.dtb \
>  	sun6i-a31-colombus.dtb \
>  	sun7i-a20-cubieboard2.dtb \
> +	sun7i-a20-cubietruck.dtb \
>  	sun7i-a20-olinuxino-micro.dtb
>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> new file mode 100644
> index 0000000..0167afe
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright 2013 Oliver Schinagl
> + *
> + * Oliver Schinagl <oliver@schinagl.nl>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun7i-a20.dtsi"
> +
> +/ {
> +	model = "Cubietech Cubietruck";
> +	compatible = "cubietech,cubietech", "allwinner,sun7i-a20";

cubietech,cubietruck :)

> +
> +	soc at 01c00000 {
> +		pinctrl at 01c20800 {
> +			led_pins_cubietruck: led_pins at 0 {
> +				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_cubietruck>;
> +
> +		blue {
> +			label = "cubietruck:blue:usr";
> +			gpios = <&pio 7 21 0>;
> +		};

Newline

> +		orange {
> +			label = "cubietruck:orange:usr";
> +			gpios = <&pio 7 20 0>;
> +		};

Ditto.

> +		white {
> +			label = "cubietruck:white:usr";
> +			gpios = <&pio 7 11 0>;
> +		};

Ditto.

> +		green {
> +			label = "cubietruck:green:usr";
> +			gpios = <&pio 7 7 0>;
> +		};
> +	};
> +};
> -- 
> 1.8.1.5
> 

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/b7cc59aa/attachment-0001.sig>
