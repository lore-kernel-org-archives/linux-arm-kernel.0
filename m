From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 11 May 2015 23:39:08 +0200
Subject: [PATCH] Show proper respect for Heinrich Hertz by using the
 correct unit for frequency
In-Reply-To: <20150511131952.GD2067@n2100.arm.linux.org.uk>
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Message-ID: <5551217C.9090504@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.05.2015 um 15:19 schrieb Russell King - ARM Linux:
> The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
> given the symbol "Hz" to denote this.  "hz" is not the unit of frequency,
> and is in fact meaningless.
> 
> Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich Hertz
> contribution to the modern world.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Nice. :) Since you're being exact, should it be "Hertz' contribution"?

> diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
> index f5b5a1d96cd7..53ae04f9104d 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3517.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
> @@ -66,7 +66,7 @@
>  
>  	otg_drv_vbus: pinmux_otg_drv_vbus {
>  		pinctrl-single,pins = <
> -			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50Mhz_clk.usb0_drvvbus */
> +			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50MHz_clk.usb0_drvvbus */

This one looks like an identifier - did you check where it comes from
and whether it needs to be fixed there as well?

>  		>;
>  	};
>  

Rest looks good,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
