From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 19 Apr 2013 11:39:45 +0200
Subject: [PATCH v3 2/6] ARM: at91: dts: set #dma-cells to the correct value
In-Reply-To: <1366362683-14496-3-git-send-email-ludovic.desroches@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <517110E1.70804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 11:11 AM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Moving to generic DMA DT binding involves to set #dma-cells to 2.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked in at91-3.10-soc.

thanks,

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi | 1 +
>  arch/arm/boot/dts/at91sam9n12.dtsi | 1 +
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 2 ++
>  arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 6b1d4ca..275e768 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -108,6 +108,7 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <21 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl at fffff200 {
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 7750f98..acc4526 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -110,6 +110,7 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl at fffff400 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 3870322..8e83d87 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -104,12 +104,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffec00 0x200>;
>  				interrupts = <20 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			dma1: dma-controller at ffffee00 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <21 4 0>;
> +				#dma-cells = <2>;
>  			};
>  
>  			pinctrl at fffff400 {
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 39b0458..95c00a3 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -348,14 +348,14 @@
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe600 0x200>;
>  				interrupts = <30 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			dma1: dma-controller at ffffe800 {
>  				compatible = "atmel,at91sam9g45-dma";
>  				reg = <0xffffe800 0x200>;
>  				interrupts = <31 4 0>;
> -				#dma-cells = <1>;
> +				#dma-cells = <2>;
>  			};
>  
>  			ramc0: ramc at ffffea00 {
> 


-- 
Nicolas Ferre
