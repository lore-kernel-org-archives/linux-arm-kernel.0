From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 19 Jan 2017 09:42:06 +0800
Subject: [PATCH v11 10/12] drm/mediatek: add non-continuous clock mode
 and EOT packet control
In-Reply-To: <1484117473-46644-11-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
 <1484117473-46644-11-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484790126.19089.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Wed, 2017-01-11 at 14:51 +0800, YT Shen wrote:
> This patch will update dsi clock control method.
> 1. dsi non-continue clock mode will enhance antistatic effect for panel
> 2. EOT packet control will judge whether dsi send end of packet or not
> by customize
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>

Acked-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index b3c7fd8..85f22d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -431,6 +431,9 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>  		break;
>  	}
>  
> +	tmp_reg |= (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) << 6;
> +	tmp_reg |= (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
> +
>  	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>  }
>  
