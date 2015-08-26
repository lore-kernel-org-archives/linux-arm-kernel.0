From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Aug 2015 11:04:39 +0200
Subject: [PATCH] ARM: at91/dt: corrections to i2c1 declaration to sama5d4
In-Reply-To: <1440578745-9585-1-git-send-email-nicolas.ferre@atmel.com>
References: <1440578745-9585-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <55DD8127.1000909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/08/2015 10:45, Nicolas Ferre a ?crit :
> From: Holger Busse <h.busse@kathrein-sachsen.de>
> 
> Correcting the dma declaration for i2c1 dma.
> 
> Signed-off-by: Holger Busse <h.busse@kathrein-sachsen.de>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Oh, and I forgot to add:

Fixes: 4cc7cdf35c5f ("ARM: at91/dt: add i2c1 declaration to sama5d4")
Cc: stable at vger.kernel.org  # v4.1+

I'll add that when I including it to the "dt" branch.

Bye,

> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 3ee22ee13c5a..1ba10e495f21 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -939,11 +939,11 @@
>  				reg = <0xf8018000 0x4000>;
>  				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas = <&dma1
> -					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(4)>,
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(4))>,
>  				       <&dma1
> -					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> -					AT91_XDMAC_DT_PERID(5)>;
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> +					| AT91_XDMAC_DT_PERID(5))>;
>  				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_i2c1>;
> 


-- 
Nicolas Ferre
