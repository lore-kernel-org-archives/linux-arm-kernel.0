From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 10:57:18 -0700
Subject: [PATCH 10/30] ARM: omap/iommu: always provide iommu debug code
In-Reply-To: <1317566760-25681-11-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-11-git-send-email-arnd@arndb.de>
Message-ID: <20111003175718.GU6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [111002 07:13]:
> The iommu module on omap contains a few functions that are
> only used by the debug module. These are however only there
> when the debug code is built as a module. Since it is possible
> to build the debug code into the kernel, the functions should
> also be provided for the built-in case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 34fc31e..9d43ce1 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -391,7 +391,7 @@ void iommu_set_twl(struct iommu *obj, bool on)
>  }
>  EXPORT_SYMBOL_GPL(iommu_set_twl);
>  
> -#if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
> +#if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
>  
>  ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
>  {
> -- 
> 1.7.5.4
> 
