From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 9 Jun 2015 12:12:13 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: fix dma conf for aes, sha and
 tdes nodes
In-Reply-To: <1433771754-4999-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433771754-4999-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5576BBFD.2060605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/2015 15:55, Ludovic Desroches a ?crit :
> The xdmac channel configuration is done in one cell not two. This error
> prevents from probing devices correctly.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 83906783b766 ("ARM: at91/dt: sama5d4: add aes, sha and tdes nodes")
> Cc: stable at vger.kernel.org # 4.1

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Arnd, Olof, Kevin,

This patch is a fix concerning material that had been added to 4.1, so
it's not exactly a regression.

So, as we missed the last train to 4.1, I'd like to queue it for 4.2 but
it's the only patch I have on top of my previous DT pull-request
(at91-dt4, not taken by you, yet).

So, should I build another pull-request (at91-dt5) or can you take this
single patch when you pull the at91-dt4 material?

BTW, here is the link to patchwork if it's easier:
https://patchwork.kernel.org/patch/6565591/

Thanks, bye,

> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 6b1bb58..51ddec4 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1125,10 +1125,10 @@
>  				compatible = "atmel,at91sam9g46-aes";
>  				reg = <0xfc044000 0x100>;
>  				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> -				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(41)>,
> -				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(40)>;
> +				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(41))>,
> +				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(40))>;
>  				dma-names = "tx", "rx";
>  				clocks = <&aes_clk>;
>  				clock-names = "aes_clk";
> @@ -1139,10 +1139,10 @@
>  				compatible = "atmel,at91sam9g46-tdes";
>  				reg = <0xfc04c000 0x100>;
>  				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
> -				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(42)>,
> -				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(43)>;
> +				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(42))>,
> +				       <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(43))>;
>  				dma-names = "tx", "rx";
>  				clocks = <&tdes_clk>;
>  				clock-names = "tdes_clk";
> @@ -1153,8 +1153,8 @@
>  				compatible = "atmel,at91sam9g46-sha";
>  				reg = <0xfc050000 0x100>;
>  				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 0>;
> -				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(44)>;
> +				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(44))>;
>  				dma-names = "tx";
>  				clocks = <&sha_clk>;
>  				clock-names = "sha_clk";
> 


-- 
Nicolas Ferre
