From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 23 May 2017 17:28:15 +0800
Subject: [PATCH] drm/mediatek: hdmi: Filter interlaced resolutions
In-Reply-To: <1485234604-19889-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1485234604-19889-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1495531695.20811.19.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

I've applied this patch to my branch mediatek-drm-fixes-4.12-rc1,
thanks.

Regards,
CK

On Tue, 2017-01-24 at 13:10 +0800, Bibby Hsieh wrote:
> Current Mediatek DRM driver does not support interlaced mode, and
> will hang if such resolution is used: Filter those to prevent
> kernel hangs, until the DRM driver is fixed properly.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 0e8c4d9..e33678d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1244,6 +1244,8 @@ static int mtk_hdmi_conn_mode_valid(struct drm_connector *conn,
>  			return MODE_BAD;
>  	}
>  
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		return MODE_NO_INTERLACE;
>  	if (mode->clock < 27000)
>  		return MODE_CLOCK_LOW;
>  	if (mode->clock > 297000)
