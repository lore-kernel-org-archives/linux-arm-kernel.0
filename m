From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jan 2012 10:07:40 +0100
Subject: [PATCH 1/6] ARM: mxc: make imx_dma_is_general_purpose more
 generic for sdma
In-Reply-To: <1325820343-11875-2-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120106090740.GF5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:25:38AM +0800, Richard Zhao wrote:
> sdma device names vary for different SoC. So we just check
> whether it includes "sdma" substring.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  arch/arm/plat-mxc/include/mach/dma.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/dma.h b/arch/arm/plat-mxc/include/mach/dma.h
> index 233d0a5..1b90803 100644
> --- a/arch/arm/plat-mxc/include/mach/dma.h
> +++ b/arch/arm/plat-mxc/include/mach/dma.h
> @@ -60,8 +60,7 @@ static inline int imx_dma_is_ipu(struct dma_chan *chan)
>  
>  static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  {
> -	return !strcmp(dev_name(chan->device->dev), "imx31-sdma") ||
> -		!strcmp(dev_name(chan->device->dev), "imx35-sdma") ||
> +	return strstr(dev_name(chan->device->dev), "sdma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx-dma");
>  }
>  
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
