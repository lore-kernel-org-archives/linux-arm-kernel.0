From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Wed, 25 Oct 2017 00:02:58 +0200
Subject: [PATCH v1 1/2] dt-bindings: mtd: add new compatible strings and
 improve description
In-Reply-To: <1505997906-30921-2-git-send-email-guochun.mao@mediatek.com>
References: <1505997906-30921-1-git-send-email-guochun.mao@mediatek.com>
 <1505997906-30921-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <be2712c2-a151-5fc4-0c0a-3bfa0cc34320@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/09/2017 ? 14:45, Guochun Mao a ?crit?:
> Add "mediatak,mt2712-nor" and "mediatek,mt7622-nor"
> for nor flash node's compatible strings.
> Explicate the fallback compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>

Applied to the spi-nor/next branch of l2-mtd

Thanks!
> ---
>  .../devicetree/bindings/mtd/mtk-quadspi.txt        |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> index 840f940..56d3668 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> @@ -1,13 +1,16 @@
>  * Serial NOR flash controller for MTK MT81xx (and similar)
>  
>  Required properties:
> -- compatible: 	  The possible values are:
> -		  "mediatek,mt2701-nor"
> -		  "mediatek,mt7623-nor"
> +- compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
> +		  and it's the fallback compatible for other Soc.
> +		  For every other SoC, should contain both the SoC-specific compatible
> +		  string and "mediatek,mt8173-nor".
> +		  The possible values are:
> +		  "mediatek,mt2701-nor", "mediatek,mt8173-nor"
> +		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
> +		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
> +		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
>  		  "mediatek,mt8173-nor"
> -		  For mt8173, compatible should be "mediatek,mt8173-nor".
> -		  For every other SoC, should contain both the SoC-specific compatible string
> -		  and "mediatek,mt8173-nor".
>  - reg: 		  physical base address and length of the controller's register
>  - clocks: 	  the phandle of the clocks needed by the nor controller
>  - clock-names: 	  the names of the clocks
> 
