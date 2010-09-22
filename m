From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 22 Sep 2010 11:28:28 +0200
Subject: [PATCH] mx3fb and ipu_idmac cleanups
In-Reply-To: <1285146693-22644-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1285146693-22644-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20100922092827.GD2693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 11:11:33AM +0200, Michael Grzeschik wrote:
> From: Juergen Beisert <j.beisert@pengutronix.de>
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/dma/ipu/ipu_idmac.c |    2 +-
>  drivers/video/mx3fb.c       |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Ehrm, I think it makes sense to split them up.

> 
> diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
> index cb26ee9..e065703 100644
> --- a/drivers/dma/ipu/ipu_idmac.c
> +++ b/drivers/dma/ipu/ipu_idmac.c
> @@ -321,7 +321,7 @@ static void ipu_ch_param_set_size(union chan_param_mem *params,
>  		params->ip.wid2	= 4;		/* Blue bit width - 1 */
>  		break;
>  	case IPU_PIX_FMT_BGR24:
> -		params->ip.bpp	= 1;		/* 24 BPP & RGB PFS */
> +		params->ip.bpp	= 1;		/* 24 BPP & BGR PFS */
>  		params->ip.pfs	= 4;
>  		params->ip.npb	= 7;
>  		params->ip.sat	= 2;		/* SAT = 32-bit access */
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 7cfc170..658f10a 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -660,12 +660,12 @@ static uint32_t bpp_to_pixfmt(int bpp)
>  {
>  	uint32_t pixfmt = 0;
>  	switch (bpp) {
> -	case 24:
> -		pixfmt = IPU_PIX_FMT_BGR24;
> -		break;
>  	case 32:
>  		pixfmt = IPU_PIX_FMT_BGR32;
>  		break;
> +	case 24:
> +		pixfmt = IPU_PIX_FMT_BGR24;
> +		break;
>  	case 16:
>  		pixfmt = IPU_PIX_FMT_RGB565;
>  		break;
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100922/79f2317a/attachment-0001.sig>
