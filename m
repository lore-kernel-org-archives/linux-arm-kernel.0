From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 19 Sep 2016 09:08:48 +0800
Subject: [PATCH v8 9/9] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1473681672-47144-10-git-send-email-yt.shen@mediatek.com>
References: <1473681672-47144-1-git-send-email-yt.shen@mediatek.com>
 <1473681672-47144-10-git-send-email-yt.shen@mediatek.com>
Message-ID: <1474247328.24685.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Mon, 2016-09-12 at 20:01 +0800, YT Shen wrote:
> This patch add support for the Mediatek MT2701 DISP subsystem.
> There is only one OVL engine in MT2701.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  6 ++++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  6 ++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 17 +++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  7 +++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 29 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dsi.c          |  1 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c      |  6 ++++++
>  7 files changed, 72 insertions(+)
> 

[snip...]

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 4b4e449..465819b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -112,6 +112,7 @@ struct mtk_ddp_comp_match {
>  
>  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
> +	[DDP_COMPONENT_BLS]	= { MTK_DISP_PWM,	0, NULL },

I would like to move this modification to the patch of "Add BLS
component". Just like 'shadow register', even we first introduce it in
MT2701, we separate it in another independent patch because it may be
included in other Mediatek Soc. I prefer modification of this patch is
something which exist in MT8173 but is different in MT2701. 

Regards,
CK

>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> @@ -130,11 +131,17 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
>  };
>  
