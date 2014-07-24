From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Jul 2014 16:15:29 +0100
Subject: [PATCH v2 5/6] ARM: at91: change compatibility string for
 sama5d3x gem
In-Reply-To: <b8cbfb4e8d5d156d477634164c21cfa6f509c4ea.1406192657.git.cyrille.pitchen@atmel.com>
References: <cover.1406192657.git.cyrille.pitchen@atmel.com>
 <b8cbfb4e8d5d156d477634164c21cfa6f509c4ea.1406192657.git.cyrille.pitchen@atmel.com>
Message-ID: <20140724151529.GA26190@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 12:51:02PM +0100, Cyrille Pitchen wrote:
> this new compatibility string prevents macb/gem driver from using the
> scatter-gather and gso features on sama5d3x boards.

What will happen were the driver to attempt to use the features on this
board?

How will this affect existing DTBs?

Thanks,
Mark.

> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  arch/arm/boot/dts/sama5d3_gmac.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3_gmac.dtsi b/arch/arm/boot/dts/sama5d3_gmac.dtsi
> index a6cb050..de5ed59 100644
> --- a/arch/arm/boot/dts/sama5d3_gmac.dtsi
> +++ b/arch/arm/boot/dts/sama5d3_gmac.dtsi
> @@ -74,7 +74,7 @@
>  			};
>  
>  			macb0: ethernet at f0028000 {
> -				compatible = "cdns,pc302-gem", "cdns,gem";
> +				compatible = "atmel,sama5d3-gem";
>  				reg = <0xf0028000 0x100>;
>  				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 3>;
>  				pinctrl-names = "default";
> -- 
> 1.8.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
