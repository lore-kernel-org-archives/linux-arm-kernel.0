From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 15:35:05 +0800
Subject: [PATCH 26/28] drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
In-Reply-To: <1528687580-549-27-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-27-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528875305.30263.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add components DPI1/DSI1/DSI2/DSI3 in comp_init.
> Because the some parameter for these components initialized
> in their driver.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 22f4c72fa785..ff974d82a4a6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -278,7 +278,11 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  
>  	if (comp_id == DDP_COMPONENT_BLS ||
>  	    comp_id == DDP_COMPONENT_DPI0 ||
> +	    comp_id == DDP_COMPONENT_DPI1 ||

Why not move this modification to the patch 'add component DPI1'?

>  	    comp_id == DDP_COMPONENT_DSI0 ||
> +	    comp_id == DDP_COMPONENT_DSI1 ||
> +	    comp_id == DDP_COMPONENT_DSI2 ||

Why not move this modification to the patch 'add component DSI2'?

> +	    comp_id == DDP_COMPONENT_DSI3 ||

Why not move this modification to the patch 'add component DSI3'?

Regards,
CK

>  	    comp_id == DDP_COMPONENT_PWM0) {
>  		comp->regs = NULL;
>  		comp->clk = NULL;
