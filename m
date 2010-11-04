From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 4 Nov 2010 18:30:14 +0100 (CET)
Subject: [PATCH 1/3] ARM mx3fb: check for DMA engine type
In-Reply-To: <1288888459-7293-2-git-send-email-s.hauer@pengutronix.de>
References: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
	<1288888459-7293-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1011041829040.13123@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Nov 2010, Sascha Hauer wrote:

> We have two dma engines in MX3 systems: The IPU and the SDMA
> engine. We have to check if we got a channel from the correct
> engine before proceeding with a channel.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Yeah, looks right:

Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Could you also make a similar one for drivers/media/video/mx3_camera.c?

Thanks
Guennadi

> ---
>  drivers/video/mx3fb.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 7cfc170..ca0f6be 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk.h>
>  #include <linux/mutex.h>
>  
> +#include <mach/dma.h>
>  #include <mach/hardware.h>
>  #include <mach/ipu.h>
>  #include <mach/mx3fb.h>
> @@ -1420,6 +1421,9 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
>  	struct device *dev;
>  	struct mx3fb_platform_data *mx3fb_pdata;
>  
> +	if (!imx_dma_is_ipu(chan))
> +		return false;
> +
>  	if (!rq)
>  		return false;
>  
> -- 
> 1.7.2.3
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
