From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 28 May 2018 15:03:55 +0800
Subject: [PATCH v4 3/9] drm/mediatek: add ddp component AAL1
In-Reply-To: <1527489507-24453-4-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
 <1527489507-24453-4-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527491035.24367.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch add component AAL1 and
> rename AAL to AAL0
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 47ffa240bd25..7217665f4b5d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -110,7 +110,7 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>  };
>  
>  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
> +	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
>  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
>  	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
>  	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 4672317e3ad1..0919039805aa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -218,7 +218,8 @@ struct mtk_ddp_comp_match {
>  };
>  
>  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
> +	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
> +	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },
>  	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 0828cf8bf85c..eee3c0cc2632 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -41,7 +41,8 @@ enum mtk_ddp_comp_type {
>  };
>  
>  enum mtk_ddp_comp_id {
> -	DDP_COMPONENT_AAL,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_AAL1,
>  	DDP_COMPONENT_BLS,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90fc403c..a415260f3d5f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -149,7 +149,7 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
>  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
> -	DDP_COMPONENT_AAL,
> +	DDP_COMPONENT_AAL0,
>  	DDP_COMPONENT_OD,
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_UFOE,
