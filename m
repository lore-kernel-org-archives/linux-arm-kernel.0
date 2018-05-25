From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 25 May 2018 13:00:25 +0800
Subject: [PATCH v3 8/8] drm/mediatek: add third ddp path
In-Reply-To: <1527215665-11937-9-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
 <1527215665-11937-9-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527224425.27165.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh at mediatek.com wrote:
> From: Stu Hsieh <stu.hsieh@mediatek.com>
> 
> This patch create third crtc by third ddp path
> 

Apply this patch before the patch 'Add support for mediatek SOC MT2712'
because this patch is necessary for mt2712.

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b32c4cc8d051..3a866e1d6af4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -267,6 +267,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	if (ret < 0)
>  		goto err_component_unbind;
>  
> +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> +				  private->data->third_len);

I think you should prevent doing this for mt8173 and mt2701 because that
two SoC has only two ddp path.

Regards,
CK

> +	if (ret < 0)
> +		goto err_component_unbind;
> +
>  	/* Use OVL device for all DMA memory allocations */
>  	np = private->comp_node[private->data->main_path[0]] ?:
>  	     private->comp_node[private->data->ext_path[0]];
