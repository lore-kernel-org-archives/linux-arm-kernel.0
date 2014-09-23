From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 23 Sep 2014 14:06:21 +0200
Subject: [PATCH] ARM: at91: fix at91sam9263ek DT mmc pinmuxing settings
In-Reply-To: <1411472564-32448-1-git-send-email-andreas.henriksson@endian.se>
References: <1411472564-32448-1-git-send-email-andreas.henriksson@endian.se>
Message-ID: <5421623D.6090609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/2014 13:42, Andreas Henriksson :
> As discovered on a custom board similar to at91sam9263ek and basing
> its devicetree on that one apparently the pin muxing doesn't get
> set up properly. This was discovered since the custom boards u-boot
> does funky stuff with the pin muxing and leaved it set to SPI
> which made the MMC driver not work under Linux.
> The fix is simply to define the given configuration as the default.
> This probably worked by pure luck before, but it's better to
> make the muxing explicitly set.
> 
> CC: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Signed-off-by: Andreas Henriksson <andreas.henriksson@endian.se>

Thanks a lot for having fix this Andreas.

> ---
>  arch/arm/boot/dts/at91sam9263ek.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 5cf93ee..33a4f9a 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -64,6 +64,7 @@
>  			};
>  
>  			mmc0: mmc at fff80000 {
> +				pinctrl-names = "default";

On AT91, we tend to have this property directly in the SoC .dtsi file:
can you please add this "default" name to the 2 mmc hosts in
at91sam9263.dtsi file?

Thanks, best regards.

>  				pinctrl-0 = <
>  					&pinctrl_board_mmc0
>  					&pinctrl_mmc0_clk
> 


-- 
Nicolas Ferre
