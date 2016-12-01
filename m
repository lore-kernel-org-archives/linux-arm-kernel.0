From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 1 Dec 2016 09:10:40 +0800
Subject: [PATCH v10 10/13] drm/mediatek: add dsi ulp mode control
In-Reply-To: <1480070076-6196-11-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-11-git-send-email-yt.shen@mediatek.com>
Message-ID: <1480554640.25380.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Fri, 2016-11-25 at 18:34 +0800, YT Shen wrote:
> modify dsi enter ultra low power mode method
> 

This looks like a power-saving patch. I think without this, MT2701 could
still work correctly. The commit message is too simple, please describe
why this patch is related to MT2701. If it is not related to MT2701,
move this patch out of MT2701 series and send it independently.

Regards,
CK

> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index d03a0f1..01df829 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -289,7 +289,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
>  {
>  	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
> -	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
> +	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, LC_ULPM_EN);
>  }
>  
>  static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
> @@ -302,7 +302,7 @@ static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
>  static void mtk_dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
>  {
>  	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_HS_TX_EN, 0);
> -	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
> +	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, LD0_ULPM_EN);
>  }
>  
>  static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
