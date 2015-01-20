From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 20 Jan 2015 12:49:15 -0800
Subject: [PATCH 2/2] ARM: at91: sama5d4: dts: change the nand compatible
 string
In-Reply-To: <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
References: <1421656387-12538-1-git-send-email-josh.wu@atmel.com>
 <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
Message-ID: <20150120204915.GS9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 04:33:07PM +0800, Josh Wu wrote:
> As we introduce a new "atmel,sama5d4-nand" compatible string for sama5d4,
> so we need to apply it for sama5d4 chip.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 1b0f30c..02d67c2 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -267,7 +267,7 @@
>  		};
>  
>  		nand0: nand at 80000000 {
> -			compatible = "atmel,at91rm9200-nand";
> +			compatible = "atmel,sama5d4-nand";

Wouldn't it make sense to include both compatible strings, so that old
kernels can still bind to it? The newer IP only adds a new ECC feature,
but the driver still can work fine without handling it, right?

>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;

Brian
