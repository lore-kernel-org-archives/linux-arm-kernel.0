From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 1 Oct 2013 07:24:54 +0530
Subject: [PATCH v2 3/5] dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
In-Reply-To: <1380580887-24249-4-git-send-email-santosh.shilimkar@ti.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
 <1380580887-24249-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131001015454.GA16684@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:41:25PM -0400, Santosh Shilimkar wrote:
> Allow the TI_EDMA to be built for ARCH_KEYSTONE which also supports
> the EDMA IP.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Vinod,
> I need your ack on this patch to carry $subject patch via arm-soc tree
> to avoid the unmet dependency warnings.
Sure, but too many dependency fixes have been popoing up for this part and this
IIRC is third patch! Something doesn't seem right, hopefully am wrong..

I have a patch in my -next from Josh which selects TI_PRIV_EDMA for this...

~Vinod
> 
>  drivers/dma/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 526ec77..b1dde16 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -195,7 +195,7 @@ config SIRF_DMA
>  
>  config TI_EDMA
>  	bool "TI EDMA support"
> -	depends on ARCH_DAVINCI || ARCH_OMAP
> +	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	default n
> -- 
> 1.7.9.5
> 

-- 
