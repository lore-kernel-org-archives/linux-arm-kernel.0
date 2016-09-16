From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 10:04:14 +0200
Subject: [RFC PATCH v2 3/5] dmaengine: hi3620: Make hi3620 explicit,
 remove wildcard
In-Reply-To: <20160915210505.21878-4-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
 <20160915210505.21878-4-netz.kernel@gmail.com>
Message-ID: <2803421.aLdooP5OTy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 4:05:03 PM CEST Marty Plummer wrote:
> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 739f797..74bab9d0 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -279,7 +279,7 @@ config INTEL_MIC_X100_DMA
>  
>  config K3_DMA
>         tristate "Hisilicon K3 DMA support"
> -       depends on ARCH_HI3xxx
> +       depends on ARCH_HI3620
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
>         help
> 

This can not be applied until the first patch is merged.
If we leave a ARCH_HI3xxx Kconfig symbol in place indefinitely,
I think it's ok to just leave it the way it is right now
and drop the patch: there are many other drivers for hardware
you don't have and we just leave them disabled in the .config,
so we can do the same here.

	Arnd
