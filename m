From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 29 Sep 2016 13:36:23 +0800
Subject: [PATCH 1/2] drm/mediatek: set vblank_disable_allowed to true
In-Reply-To: <1475119789-64619-2-git-send-email-bibby.hsieh@mediatek.com>
References: <1475119789-64619-1-git-send-email-bibby.hsieh@mediatek.com>
 <1475119789-64619-2-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1475127383.18843.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: CK Hu <ck.hu@mediatek.com>

On Thu, 2016-09-29 at 11:29 +0800, Bibby Hsieh wrote:
> MTK DRM driver didn't set the vblank_disable_allowed to
> true, it cause that the irq_handler is called every
> 16.6 ms (every vblank) when the display didn't be updated.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index eebb7d8..941ec5f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -200,6 +200,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	if (ret < 0)
>  		goto err_component_unbind;
>  
> +	drm->vblank_disable_allowed = true;
>  	drm_kms_helper_poll_init(drm);
>  	drm_mode_config_reset(drm);
>  
