From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Oct 2017 15:14:12 -0500
Subject: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
In-Reply-To: <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20171013201412.ces7ttqfwfuj4mnn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 07:35:16PM +0800, Chaotian Jing wrote:
> the driver has updated to have an explicit compatible, so update
> binding file according to the driver change.

Normally, that's not a reason for a binding change. An old kernel 
without the driver change is still valid.

> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 3e0a97c..2bb585b 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
>  
>  Required properties:
>  - compatible: value should be either of the following.
> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135

Except this one didn't really make sense. "mediatek,mt8135-mmc" should 
be the most specific compatible on a MT8135.

> -	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173

Why is the version in MT8173 no longer compatible with a driver that 
supports "mediatek,mt8135-mmc"? Your commit msg needs to answer that 
question.

> +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>  - reg: physical base address of the controller and length
> -- 
> 1.8.1.1.dirty
> 
