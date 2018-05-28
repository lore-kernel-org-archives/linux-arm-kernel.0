From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 28 May 2018 17:12:42 +0800
Subject: [PATCH v1 6/7] drm/mediatek: add a error return value when
 clock driver has been prepared
In-Reply-To: <20180514075243.5442-7-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
 <20180514075243.5442-7-bibby.hsieh@mediatek.com>
Message-ID: <1527498762.14913.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

On Mon, 2018-05-14 at 15:52 +0800, Bibby Hsieh wrote:
> DRM driver get the comp->clk by of_clk_get(), we only
> assign NULL to comp->clk when error happened, but do
> not return the error number.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 4672317e3ad1..d38a5303f8fc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -283,7 +283,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	comp->irq = of_irq_get(node, 0);
>  	comp->clk = of_clk_get(node, 0);
>  	if (IS_ERR(comp->clk))
> -		comp->clk = NULL;
> +		return PTR_ERR(comp->clk);
>  
>  	/* Only DMA capable components need the LARB property */
>  	comp->larb_dev = NULL;
