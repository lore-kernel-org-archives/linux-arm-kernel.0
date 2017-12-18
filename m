From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 18 Dec 2017 10:46:49 +0200
Subject: [PATCH 1/4 v5] drm/bridge: Add bindings for TI THS8134
In-Reply-To: <20171215121047.3650-2-linus.walleij@linaro.org>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
 <20171215121047.3650-2-linus.walleij@linaro.org>
Message-ID: <1661312.kCzA9cG53b@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

Thank you for the patch.

On Friday, 15 December 2017 14:10:44 EET Linus Walleij wrote:
> This adds device tree bindings for the Texas Instruments
> THS8134, THS8134A and THS8134B VGA DACs by extending and
> renaming the existing bindings for THS8135.
> 
> These DACs are used for the VGA outputs on the ARM reference
> designs such as Integrator, Versatile and RealView.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v5:
> - Dropped the "ti,ths813x" as it turns out we need precise info
>   about the sub-variant anyways as they all very in timings.
> - Refine the THS8134 variants, it turns out ths8134, ths8134a
>   and ths8134b are three different variants of ths8134.
> ChangeLog v1->v2:
> - Introduce specific-to-general compatible string:
>   compatible = "ti,ths8134a", "ti,ths813x";
>   so drivers can handle the whole family the same way.
> - Collected Rob's ACK.
> ---
>  .../display/bridge/{ti,ths8135.txt => ti,ths813x.txt}       | 13 +++++++--
>  1 file changed, 9 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt =>
> ti,ths813x.txt} (69%)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> similarity index 69%
> rename from Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> rename to Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> index 6ec1a880ac18..49f155467f00 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> @@ -1,11 +1,16 @@
> -THS8135 Video DAC
> ------------------
> +THS8134 and THS8135 Video DAC
> +-----------------------------
> 
> -This is the binding for Texas Instruments THS8135 Video DAC bridge.
> +This is the binding for Texas Instruments THS8134, THS8134A, THS8134B and
> +THS8135 Video DAC bridge.

There's more than one no, so s/bridge/bridges/. Or just s/DAC bridge/DACs/ as 
bridge refers to the software implementation.

With this and Rob's comment about the compatible string ordering 
("ti,ths8134[ab]", "ti,ths8134" instead of "ti,ths8134[ab]", "ti,ths8134"),

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  Required properties:
> 
> -- compatible: Must be "ti,ths8135"
> +- compatible: Must be one of
> +  "ti,ths8134"
> +  "ti,ths8134", "ti,ths8134a"
> +  "ti,ths8134", "ti,ths8134b"
> +  "ti,ths8135"
> 
>  Required nodes:


-- 
Regards,

Laurent Pinchart
