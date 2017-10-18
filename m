From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 19 Oct 2017 00:14:14 +0300
Subject: [PATCH 1/2 v2] drm: bridge: Add bindings for TI THS8134
In-Reply-To: <20171017101904.22308-1-linus.walleij@linaro.org>
References: <20171017101904.22308-1-linus.walleij@linaro.org>
Message-ID: <14098078.249ollOXmK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Tuesday, 17 October 2017 13:19:03 EEST Linus Walleij wrote:
> This adds device tree bindings for the Texas Instruments
> THS8134A and THS8134B VGA DACs by extending and renaming the
> existing bindings for THS8135.
> 
> These DACs are used for the VGA outputs on the ARM reference
> designs such as Integrator, Versatile and RealView.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> ChangeLog v1->v2:
> - Introduce specific-to-general compatible string:
>   compatible = "ti,ths8134a", "ti,ths813x";
>   so drivers can handle the whole family the same way.
> - Collected Rob's ACK.
> ---
>  .../display/bridge/{ti,ths8135.txt => ti,ths813x.txt}      | 14 +++++++----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt =>
> ti,ths813x.txt} (65%)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> similarity index 65%
> rename from Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> rename to Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> index 6ec1a880ac18..97ef5eb57052 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ths813x.txt
> @@ -1,11 +1,15 @@
> -THS8135 Video DAC
> ------------------
> +THS8134 and THS8135 Video DAC
> +-----------------------------
> 
> -This is the binding for Texas Instruments THS8135 Video DAC bridge.
> +This is the binding for Texas Instruments THS8134A, THS8134B and THS8135
> +Video DAC bridge.
> 
>  Required properties:
> 
> -- compatible: Must be "ti,ths8135"
> +- compatible: Must be one of
> +  "ti,ths8134a", "ti,ths813x"
> +  "ti,ths8134b", "ti,ths813x"
> +  "ti,ths8135", "ti,ths813x"
> 
>  Required nodes:
> 
> @@ -19,7 +23,7 @@ Example
>  -------
> 
>  vga-bridge {
> -	compatible = "ti,ths8135";
> +	compatible = "ti,ths8135", "ti,ths813x";
>  	#address-cells = <1>;
>  	#size-cells = <0>;

-- 
Regards,

Laurent Pinchart
