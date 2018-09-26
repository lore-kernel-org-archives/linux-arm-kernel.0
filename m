From: peda@axentia.se (Peter Rosin)
Date: Wed, 26 Sep 2018 16:44:50 +0200
Subject: [PATCH 1/2] dt-bindings: i2c-omap: Add new compatible for AM654
 SoCs
In-Reply-To: <20180926115751.20421-2-vigneshr@ti.com>
References: <20180926115751.20421-1-vigneshr@ti.com>
 <20180926115751.20421-2-vigneshr@ti.com>
Message-ID: <c3421929-1c40-513a-5c14-73e132a11d0f@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-26 13:57, Vignesh R wrote:
> AM654 SoCs have similar I2C IP as OMAP SoCs. Add new compatible to
> handle AM654 SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> index 7e49839d4124..11ce869d682d 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> @@ -2,7 +2,8 @@ I2C for OMAP platforms
>  
>  Required properties :
>  - compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
> -  or "ti,omap4-i2c"
> +  or "ti,omap4-i2c" for OMAP2+ SoCs
> +- compatible : Must "ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
                      ^
                     be

Also, it looks bad with two 'compatible' entries in the properties list.
I think the trend is to list one valid compatible (plus fallbacks)
per line. So, you should consider reformatting, possibly like so:

- compatible : Must be one of
	"ti,omap2420-i2c"
	"ti,omap2430-i2c"
	"ti,omap3-i2c"
        "ti,omap4-i2c"
	"ti,am654-i2c", "ti,omap4-i2c"

Cheers,
Peter

>  - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
>  - #address-cells = <1>;
>  - #size-cells = <0>;
> 
