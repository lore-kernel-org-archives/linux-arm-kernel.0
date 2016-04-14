From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 14 Apr 2016 18:56:21 +0800
Subject: [PATCH v6 3/4] soc: mediatek: Add MT2701 power dt-bindings
In-Reply-To: <1460621819-695-4-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621819-695-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621819-695-4-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1460631381.13240.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-14 at 16:16 +0800, James Liao wrote:
> From: Shunli Wang <shunli.wang@mediatek.com>
> 
> Add power dt-bindings for MT2701.
> 
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 12 ++++++----
>  include/dt-bindings/power/mt2701-power.h           | 27 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt2701-power.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index e8f15e3..ebb3144 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -9,17 +9,19 @@ domain control.
>  
>  The driver implements the Generic PM domain bindings described in
>  power/power_domain.txt. It provides the power domains defined in
> -include/dt-bindings/power/mt8173-power.h.
> +include/dt-bindings/power/mt8173-power.h and mt2701-power.h.
>  
>  Required properties:
> -- compatible: Must be "mediatek,mt8173-scpsys"
> +- compatible: Should be one of:
> +	- "mediatek,mt2701-scpsys"
> +	- "mediatek,mt8173-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
>  - infracfg: must contain a phandle to the infracfg controller
>  - clock, clock-names: clocks according to the common clock binding.
> -                      The clocks needed "mm", "mfg", "venc" and "venc_lt".
> -		      These are the clocks which hardware needs to be enabled
> -		      before enabling certain power domains.
> +                      The clocks needed "mm", "mfg", "venc", "venc_lt" and
> +                      "ethif". These are the clocks which hardware needs to be
> +                      enabled before enabling certain power domains.


Clock ethif only exist on mt2701 so it is not required on mt8173.

Joe.C
