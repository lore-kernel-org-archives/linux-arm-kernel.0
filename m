From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Aug 2013 15:53:09 +0100
Subject: [PATCH] ARM: dts: am33xx: Correct gpio #interrupt-cells property
In-Reply-To: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de>
References: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de>
Message-ID: <20130807145309.GG28558@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 12:06:32PM +0100, Lars Poeschel wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> Following commit ff5c9059 and therefore other omap platforms using
> the gpio-omap driver correct the #interrupt-cells property on am33xx
> too. The omap gpio binding documentaion also states that
> the #interrupt-cells property should be 2.

I take it there are no device nodes for which any of these nodes are an
interrupt parent (which would need to be updated)?

If so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..033c5dd 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -102,7 +102,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  			reg = <0x44e07000 0x1000>;
>  			interrupts = <96>;
>  		};
> @@ -113,7 +113,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  			reg = <0x4804c000 0x1000>;
>  			interrupts = <98>;
>  		};
> @@ -124,7 +124,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  			reg = <0x481ac000 0x1000>;
>  			interrupts = <32>;
>  		};
> @@ -135,7 +135,7 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			#interrupt-cells = <2>;
>  			reg = <0x481ae000 0x1000>;
>  			interrupts = <62>;
>  		};
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
