From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Jan 2017 11:07:28 +0100
Subject: [PATCH] reset: uniphier: add compatible string for LD11
 SD-reset block
In-Reply-To: <1484420686-28911-1-git-send-email-yamada.masahiro@socionext.com>
References: <1484420686-28911-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1484647648.4087.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-15 at 04:04 +0900, Masahiro Yamada wrote:
> The LD11 SoC is equipped with not only MIO-reset but also SD-reset
> for controlling RST_n pin of the eMMC device.
> 
> Update the binding document and remove unneeded "." from each line
> in itemization.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thank you.

regards
Philipp

> ---
> 
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 47 +++++++++++-----------
>  drivers/reset/reset-uniphier.c                     |  4 ++
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index 5020524..83ab0f5 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -6,14 +6,14 @@ System reset
>  
>  Required properties:
>  - compatible: should be one of the following:
> -    "socionext,uniphier-sld3-reset" - for sLD3 SoC.
> -    "socionext,uniphier-ld4-reset"  - for LD4 SoC.
> -    "socionext,uniphier-pro4-reset" - for Pro4 SoC.
> -    "socionext,uniphier-sld8-reset" - for sLD8 SoC.
> -    "socionext,uniphier-pro5-reset" - for Pro5 SoC.
> -    "socionext,uniphier-pxs2-reset" - for PXs2/LD6b SoC.
> -    "socionext,uniphier-ld11-reset" - for LD11 SoC.
> -    "socionext,uniphier-ld20-reset" - for LD20 SoC.
> +    "socionext,uniphier-sld3-reset" - for sLD3 SoC
> +    "socionext,uniphier-ld4-reset"  - for LD4 SoC
> +    "socionext,uniphier-pro4-reset" - for Pro4 SoC
> +    "socionext,uniphier-sld8-reset" - for sLD8 SoC
> +    "socionext,uniphier-pro5-reset" - for Pro5 SoC
> +    "socionext,uniphier-pxs2-reset" - for PXs2/LD6b SoC
> +    "socionext,uniphier-ld11-reset" - for LD11 SoC
> +    "socionext,uniphier-ld20-reset" - for LD20 SoC
>  - #reset-cells: should be 1.
>  
>  Example:
> @@ -37,14 +37,15 @@ Media I/O (MIO) reset, SD reset
>  
>  Required properties:
>  - compatible: should be one of the following:
> -    "socionext,uniphier-sld3-mio-reset" - for sLD3 SoC.
> -    "socionext,uniphier-ld4-mio-reset"  - for LD4 SoC.
> -    "socionext,uniphier-pro4-mio-reset" - for Pro4 SoC.
> -    "socionext,uniphier-sld8-mio-reset" - for sLD8 SoC.
> -    "socionext,uniphier-pro5-sd-reset"  - for Pro5 SoC.
> -    "socionext,uniphier-pxs2-sd-reset"  - for PXs2/LD6b SoC.
> -    "socionext,uniphier-ld11-mio-reset" - for LD11 SoC.
> -    "socionext,uniphier-ld20-sd-reset"  - for LD20 SoC.
> +    "socionext,uniphier-sld3-mio-reset" - for sLD3 SoC
> +    "socionext,uniphier-ld4-mio-reset"  - for LD4 SoC
> +    "socionext,uniphier-pro4-mio-reset" - for Pro4 SoC
> +    "socionext,uniphier-sld8-mio-reset" - for sLD8 SoC
> +    "socionext,uniphier-pro5-sd-reset"  - for Pro5 SoC
> +    "socionext,uniphier-pxs2-sd-reset"  - for PXs2/LD6b SoC
> +    "socionext,uniphier-ld11-mio-reset" - for LD11 SoC (MIO)
> +    "socionext,uniphier-ld11-sd-reset"  - for LD11 SoC (SD)
> +    "socionext,uniphier-ld20-sd-reset"  - for LD20 SoC
>  - #reset-cells: should be 1.
>  
>  Example:
> @@ -68,13 +69,13 @@ Peripheral reset
>  
>  Required properties:
>  - compatible: should be one of the following:
> -    "socionext,uniphier-ld4-peri-reset"  - for LD4 SoC.
> -    "socionext,uniphier-pro4-peri-reset" - for Pro4 SoC.
> -    "socionext,uniphier-sld8-peri-reset" - for sLD8 SoC.
> -    "socionext,uniphier-pro5-peri-reset" - for Pro5 SoC.
> -    "socionext,uniphier-pxs2-peri-reset" - for PXs2/LD6b SoC.
> -    "socionext,uniphier-ld11-peri-reset" - for LD11 SoC.
> -    "socionext,uniphier-ld20-peri-reset" - for LD20 SoC.
> +    "socionext,uniphier-ld4-peri-reset"  - for LD4 SoC
> +    "socionext,uniphier-pro4-peri-reset" - for Pro4 SoC
> +    "socionext,uniphier-sld8-peri-reset" - for sLD8 SoC
> +    "socionext,uniphier-pro5-peri-reset" - for Pro5 SoC
> +    "socionext,uniphier-pxs2-peri-reset" - for PXs2/LD6b SoC
> +    "socionext,uniphier-ld11-peri-reset" - for LD11 SoC
> +    "socionext,uniphier-ld20-peri-reset" - for LD20 SoC
>  - #reset-cells: should be 1.
>  
>  Example:
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 968c3ae..9c11be3 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -390,6 +390,10 @@ static const struct of_device_id uniphier_reset_match[] = {
>  		.data = uniphier_sld3_mio_reset_data,
>  	},
>  	{
> +		.compatible = "socionext,uniphier-ld11-sd-reset",
> +		.data = uniphier_pro5_sd_reset_data,
> +	},
> +	{
>  		.compatible = "socionext,uniphier-ld20-sd-reset",
>  		.data = uniphier_pro5_sd_reset_data,
>  	},
