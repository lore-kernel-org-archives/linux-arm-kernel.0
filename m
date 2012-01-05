From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 17:42:38 +0800
Subject: [PATCH 1/2] arm/mxc: make imx_dma_is_general_purpose more
 generic for sdma
In-Reply-To: <1325733074-10749-1-git-send-email-richard.zhao@linaro.org>
References: <1325733074-10749-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120105094236.GC1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm-soc maintainers are requiring patch subject be like

ARM: <platform>: ...

In this case, it's "ARM: mxc: ..."

On Thu, Jan 05, 2012 at 11:11:13AM +0800, Richard Zhao wrote:
> sdma device names var when use device tree.

I think this needs some level rewording.  For given SoC, the name is
fixed, and the name may vary from SoC to SoC, whether or not it's
device tree case.

Other than that, it looks good to me.

Regards,
Shawn

> So we just check
> whether it includes "sdma" substring.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
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
