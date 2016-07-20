From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 20 Jul 2016 14:53:19 +0800
Subject: [PATCH v4 4/8] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1468577274-6178-5-git-send-email-yt.shen@mediatek.com>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
 <1468577274-6178-5-git-send-email-yt.shen@mediatek.com>
Message-ID: <1468997599.11841.49.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

Some comments inline.

On Fri, 2016-07-15 at 18:07 +0800, YT Shen wrote:
> This patch add support for the Mediatek MT2701 DISP subsystem.
> There is only one OVL engine in MT2701.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    6 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    6 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   41 +++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    7 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   31 ++++++++++++++++++++
>  6 files changed, 92 insertions(+)
> 

[snip...]

>  
>  static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> +	{ .compatible = "mediatek,mt2701-disp-ovl",   .data = (void *)MTK_DISP_OVL },
>  	{ .compatible = "mediatek,mt8173-disp-ovl",   .data = (void *)MTK_DISP_OVL },
> +	{ .compatible = "mediatek,mt2701-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
>  	{ .compatible = "mediatek,mt8173-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
> +	{ .compatible = "mediatek,mt2701-disp-wdma",  .data = (void *)MTK_DISP_WDMA },

Is WDMA different from MT8173 to MT2701. If they are the same, you need
not to add compatible of 'mediatek,mt2701-disp-wdma' because use
'mediatek,mt8173-disp-wdma' is enough.

>  	{ .compatible = "mediatek,mt8173-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
> +	{ .compatible = "mediatek,mt2701-disp-color", .data = (void *)MTK_DISP_COLOR },
>  	{ .compatible = "mediatek,mt8173-disp-color", .data = (void *)MTK_DISP_COLOR },
>  	{ .compatible = "mediatek,mt8173-disp-aal",   .data = (void *)MTK_DISP_AAL},
>  	{ .compatible = "mediatek,mt8173-disp-gamma", .data = (void *)MTK_DISP_GAMMA, },
>  	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
> +	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt2701-dpi",	      .data = (void *)MTK_DPI },

Is DPI different from MT8173 to MT2701. If they are the same, you need
not to add compatible of 'mediatek,mt2701-dpi' because use
'mediatek,mt8173-dpi' is enough.

>  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
> +	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_PWM },

Is pwm different from MT8173 to MT2701. If they are the same, you need
not to add compatible of 'mediatek,mt2701-disp-pwm' because use
'mediatek,mt8173-disp-pwm' is enough.

>  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
>  	{ .compatible = "mediatek,mt8173-disp-od",    .data = (void *)MTK_DISP_OD },
>  	{ }
> @@ -514,6 +543,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  			 mtk_drm_sys_resume);
>  
>  static const struct of_device_id mtk_drm_of_ids[] = {
> +	{ .compatible = "mediatek,mt2701-mmsys",
> +	  .data = &mt2701_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8173-mmsys",
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ }

Regards,
CK
