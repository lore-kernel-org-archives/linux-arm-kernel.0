From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 May 2016 15:29:56 +0200
Subject: [PATCH 1/3] ARM: at91/dt: sama5d2: add trng node
In-Reply-To: <1462293864-32551-2-git-send-email-mike@mikebwilliams.com>
References: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
 <1462293864-32551-2-git-send-email-mike@mikebwilliams.com>
Message-ID: <572C9C54.5030706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/05/2016 18:44, Mike Williams a ?crit :
> Add node to support SAMA5D2 hardware random number generator.

Oh, Mike, something is missing here: you Singed-off-by tag.

http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L409

Please read this and send me an email telling me if you add it to your
patches (this way you don't have to re-send them, if it's easier for you).

Bye,


> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 78996bd..af9a5f8 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1127,6 +1127,13 @@
>  				status = "disabled";
>  			};
>  
> +			trng at fc01c000 {
> +				compatible = "atmel,at91sam9g45-trng";
> +				reg = <0xfc01c000 0x4000>;
> +				interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
> +				clocks = <&trng_clk>;
> +			};
> +
>  			aic: interrupt-controller at fc020000 {
>  				#interrupt-cells = <3>;
>  				compatible = "atmel,sama5d2-aic";
> 


-- 
Nicolas Ferre
