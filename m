From: john@phrozen.org (John Crispin)
Date: Wed, 25 Jan 2017 06:39:53 +0100
Subject: [PATCH v2 1/2] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1485315515-29942-2-git-send-email-guochun.mao@mediatek.com>
References: <1485315515-29942-1-git-send-email-guochun.mao@mediatek.com>
 <1485315515-29942-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <d2da6971-3b31-38c1-1dad-dba7f6ab759c@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/2017 04:38, Guochun Mao wrote:
> Add "mediatek,mt2701-nor" for nor flash node's compatible.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> ---
>  .../devicetree/bindings/mtd/mtk-quadspi.txt        |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> index fb314f0..5ded66a 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> @@ -1,7 +1,13 @@
>  * Serial NOR flash controller for MTK MT81xx (and similar)
>  
>  Required properties:
> -- compatible: 	  should be "mediatek,mt8173-nor";
> +- compatible: 	  The possible values are:
> +		  "mediatek,mt2701-nor"
> +		  "mediatek,mt7623-nor"

Thanks !

Acked-by: John Crispin <john@phrozen.org>


> +		  "mediatek,mt8173-nor"
> +		  For mt8173, compatible should be "mediatek,mt8173-nor".
> +		  For every other SoC, should contain both the SoC-specific compatible string
> +		  and "mediatek,mt8173-nor".
>  - reg: 		  physical base address and length of the controller's register
>  - clocks: 	  the phandle of the clocks needed by the nor controller
>  - clock-names: 	  the names of the clocks
> 
