From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 19 Jun 2018 15:58:28 +0800
Subject: [PATCH v6 07/29] drm/mediatek: add component DPI1
In-Reply-To: <1529393670-26862-8-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
 <1529393670-26862-8-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529395108.26480.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> This patch add the component DPI1
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 86e8c9e5df41..cc74b1a7278c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -224,6 +224,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> +	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> @@ -275,6 +276,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  
>  	if (comp_id == DDP_COMPONENT_BLS ||
>  	    comp_id == DDP_COMPONENT_DPI0 ||
> +	    comp_id == DDP_COMPONENT_DPI1 ||
>  	    comp_id == DDP_COMPONENT_DSI0 ||
>  	    comp_id == DDP_COMPONENT_PWM0) {
>  		comp->regs = NULL;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index e00c2e798abd..54c99c169093 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -47,6 +47,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_DPI0,
> +	DDP_COMPONENT_DPI1,
>  	DDP_COMPONENT_DSI0,
>  	DDP_COMPONENT_DSI1,
>  	DDP_COMPONENT_GAMMA,
