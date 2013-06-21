From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 21 Jun 2013 16:05:35 +0530
Subject: [PATCH v12 08/11] spi: omap2-mcspi: add generic DMA request
 support to the DT binding
In-Reply-To: <1371762407-24544-9-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <1371762407-24544-9-git-send-email-joelagnel@ti.com>
Message-ID: <51C42C77.90909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,
On Friday 21 June 2013 02:36 AM, Joel A Fernandes wrote:
> From: Matt Porter<mporter@ti.com>
>
> The binding definition is based on the generic DMA request binding
>
> Signed-off-by: Matt Porter<mporter@ti.com>
> Signed-off-by: Joel A Fernandes<joelagnel@ti.com>
> ---
>   Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
> index 938809c..4c85c4c 100644
> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
> @@ -10,7 +10,18 @@ Required properties:
>   			  input. The default is D0 as input and
>   			  D1 as output.
>
> -Example:
> +Optional properties:
> +- dmas: List of DMA specifiers with the controller specific format
> +	as described in the generic DMA client binding. A tx and rx
> +	specifier is required for each chip select.
> +- dma-names: List of DMA request names. These strings correspond
> +	1:1 with the DMA specifiers listed in dmas. The string naming
> +	is to be "rxN" and "txN" for RX and TX requests,
> +	respectively, where N equals the chip select number.
> +
> +Examples:
> +
> +[hwmod populated DMA resources]
>
>   mcspi1: mcspi at 1 {
>       #address-cells =<1>;
> @@ -20,3 +31,17 @@ mcspi1: mcspi at 1 {
>       ti,spi-num-cs =<4>;
>   };
>
> +[generic DMA request binding]
> +
> +mcspi1: mcspi at 1 {
> +    #address-cells =<1>;
> +    #size-cells =<0>;
> +    compatible = "ti,omap4-mcspi";
> +    ti,hwmods = "mcspi1";
> +    ti,spi-num-cs =<2>;
> +    dmas =<&edma 42
> +	&edma 43
> +	&edma 44
> +	&edma 45>;
> +    dma-names = "tx0", "rx0", "tx1", "rx1";
> +};
If the patch looks good to you, these can go independently in your
tree.

Reviewed-by: Sourav Poddar <sourav.poddar@ti.com>

~Sourav
