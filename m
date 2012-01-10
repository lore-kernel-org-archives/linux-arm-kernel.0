From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 22:20:10 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120110142008.GE26599@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 03:01:50PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---

I think it deserves a sensible commit message explaining why the patch
is needed.

Regards,
Shawn

>  drivers/dma/imx-sdma.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 22fd561..1d5b6ab 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -753,8 +753,11 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
>  			if (sdmac->event_id0 > 31)
>  				sdmac->watermark_level |= 1 << 30;
>  		} else {
> -			sdmac->event_mask0 = 1 << sdmac->event_id0;
> -			sdmac->event_mask1 = 1 << (sdmac->event_id0 - 32);
> +			if (sdmac->event_id0 < 32)
> +				sdmac->event_mask0 = 1 << sdmac->event_id0;
> +			else
> +				sdmac->event_mask1 =
> +						1 << (sdmac->event_id0 - 32);
>  		}
>  		/* Watermark Level */
>  		sdmac->watermark_level |= sdmac->watermark_level;
> -- 
> 1.7.5.4
> 
> 
