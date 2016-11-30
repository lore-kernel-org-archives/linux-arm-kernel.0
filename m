From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 30 Nov 2016 18:47:04 +0800
Subject: [PATCH v10 11/13] drm/mediatek: add dsi rxtx control
In-Reply-To: <1480070076-6196-12-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-12-git-send-email-yt.shen@mediatek.com>
Message-ID: <1480502824.13978.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Fri, 2016-11-25 at 18:34 +0800, YT Shen wrote:
> add non-continuous clock mode and EOT packet control for dsi
> 

I think commit title should be 'drm/mediatek: add non-continuous clock
mode and EOT packet control for dsi', and commit message should describe
more information about this modification. For example, what is the
difference between with and without this patch. Does it fix any problem?

Regards,
CK

> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 01df829..ded4202 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -399,6 +399,9 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>  		break;
>  	}
>  
> +	tmp_reg |= (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) << 6;
> +	tmp_reg |= (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
> +
>  	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>  }
>  
