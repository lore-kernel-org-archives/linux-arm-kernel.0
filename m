From: oliver@schinagl.nl (Olliver Schinagl)
Date: Mon, 5 Jan 2015 07:41:59 +0000 (UTC)
Subject: [PATCH 4/6] ARM: sunxi: DT: Convert the DTs to use a header for
 the pinctrl nodes
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
 <1418767199-20957-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <loom.20150105T083747-798@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Maxime!


Maxime Ripard <maxime.ripard <at> free-electrons.com> writes:

> 
> The pinctrl nodes require some extra opaque arguments for the pull up and
drive
> strength values.
> 
> Introduce a new header file and convert the device trees to replace these
> opaque numbers by defines.
<snip>
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts
b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index 532ab3bd9735..b67e5be618cf 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>  <at>  <at>  -52,6 +52,7  <at>  <at> 
>  #include "sunxi-common-regulators.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>  
>  / {
>  	model = "Mele A1000";
>  <at>  <at>  -114,15 +115,15  <at>  <at> 
>  			emac_power_pin_a1000: emac_power_pin <at> 0 {
>  				allwinner,pins = "PH15";
>  				allwinner,function = "gpio_out";
> -				allwinner,drive = <0>;
> -				allwinner,pull = <0>;
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;

May I query why you used Mega Ampere's for the drive strength? ;) I know
it's quite obvious it means mili-amps, but I recall reading that small
letters in defines is 'acceptable' in the case of mA, which is already used
in the dts files for the imx.

I doubt we will ever see MegaAmp in any dts ;) but technically not impossible.

Olliver
