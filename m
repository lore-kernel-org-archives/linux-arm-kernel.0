From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 11 Jul 2017 09:52:58 +0200
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2: use sama5d2 compatible
 string for SMC
In-Reply-To: <20170711074015.30440-4-ludovic.desroches@microchip.com>
References: <20170711074015.30440-1-ludovic.desroches@microchip.com>
 <20170711074015.30440-4-ludovic.desroches@microchip.com>
Message-ID: <029b80a8-2d3f-11b4-d4df-55f5fc48c8e7@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2017 at 09:40, Ludovic Desroches wrote:
> A new compatible string has been introduced for sama5d2 SMC to allow to
> manage the registers mapping change.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 4fcd5bb219e3..60e69aeacbdb 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1048,7 +1048,7 @@
>  			};
>  
>  			hsmc: hsmc at f8014000 {
> -				compatible = "atmel,sama5d3-smc", "syscon", "simple-mfd";
> +				compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";

You'd better use something like:
 compatible = "atmel,sama5d2-smc", "atmel,sama5d3-smc", "syscon", "simple-mfd";

So that this patch is independent from the rest of the series and
we can avoid to having to synchronize with mfd or mtd/nand for this part.

Regards,

>  				reg = <0xf8014000 0x1000>;
>  				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
>  				clocks = <&hsmc_clk>;
> 


-- 
Nicolas Ferre
