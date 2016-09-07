From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 7 Sep 2016 13:37:33 +0800
Subject: [PATCH v7 9/9] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1472815484-43821-10-git-send-email-yt.shen@mediatek.com>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-10-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473226653.11736.33.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> This patch add support for the Mediatek MT2701 DISP subsystem.
> There is only one OVL engine in MT2701.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>

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

I think BLS is different than PWM, so this statement should be

[DDP_COMPONENT_BLS] = { MTK_DISP_BLS, 0, NULL };


>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },

Regards,
CK
