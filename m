From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 19 Jun 2018 15:58:51 +0800
Subject: [PATCH v6 08/29] drm/mediatek: add component DSI2
In-Reply-To: <1529393670-26862-9-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
 <1529393670-26862-9-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529395131.26480.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> This patch add the component DSI2
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index cc74b1a7278c..071f9f5aefea 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -227,6 +227,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
> +	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
>  	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
>  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> @@ -278,6 +279,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	    comp_id == DDP_COMPONENT_DPI0 ||
>  	    comp_id == DDP_COMPONENT_DPI1 ||
>  	    comp_id == DDP_COMPONENT_DSI0 ||
> +	    comp_id == DDP_COMPONENT_DSI2 ||
>  	    comp_id == DDP_COMPONENT_PWM0) {
>  		comp->regs = NULL;
>  		comp->clk = NULL;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 54c99c169093..8d152b337f15 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -50,6 +50,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_DPI1,
>  	DDP_COMPONENT_DSI0,
>  	DDP_COMPONENT_DSI1,
> +	DDP_COMPONENT_DSI2,
>  	DDP_COMPONENT_GAMMA,
>  	DDP_COMPONENT_OD0,
>  	DDP_COMPONENT_OD1,
