From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 10 Jan 2012 15:02:25 +0100
Subject: [PATCH 5/6] dma/imx-sdma: use num_events to validate event_id0
In-Reply-To: <1326178910-14044-5-git-send-email-richard.zhao@linaro.org>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <4F0C44F1.9060703@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.01.2012 08:01, Richard Zhao wrote:
> event number is not always 32. use num_events for checking instead.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/dma/imx-sdma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 015d93f..22fd561 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -723,7 +723,7 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
>  	sdmac->per_addr = 0;
>  
>  	if (sdmac->event_id0) {
> -		if (sdmac->event_id0 > 32)
> +		if (sdmac->event_id0 >= sdmac->sdma->num_events)
>  			return -EINVAL;
>  		sdma_event_enable(sdmac, sdmac->event_id0);
>  	}

In your git you have

http://git.linaro.org/gitweb?p=people/riczhao/linux-2.6.git;a=commitdiff;h=4bd46e7f8ade05984ee89222bc0523b656d017d2

-       if (sdmac->event_id0) {
-               if (sdmac->event_id0 > 32)
-                       return -EINVAL;
+       if (sdmac->event_id0)
                 sdma_event_enable(sdmac, sdmac->event_id0);

I your git version outdated and replaced by this patch?

Best regards

Dirk
