From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 23 May 2016 11:35:19 +0100
Subject: [PATCH 1/1] drm/mediatek: do not dereference NULL
In-Reply-To: <1463605190-5323-1-git-send-email-xypron.glpk@gmx.de>
References: <1463605190-5323-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160523103519.GB13596@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 10:59:50PM +0200, Heinrich Schuchardt wrote:
> After having verified that dpi is NULL we should not
> dereference it.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index d05ca79..3dbd00d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -433,7 +433,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	unsigned int factor;
>  
>  	if (!dpi) {
> -		dev_err(dpi->dev, "invalid argument\n");
> +		dev_err(NULL, "invalid argument\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.1.4

Seems obvious ^^
Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
