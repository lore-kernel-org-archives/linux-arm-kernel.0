From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 20 May 2011 18:20:54 -0400 (EDT)
Subject: [PATCH] Fix generic irq chip
In-Reply-To: <20110520220510.GC30675@n2100.arm.linux.org.uk>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1105201820180.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 May 2011, Russell King - ARM Linux wrote:

> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Nicolas Pitre <nico@fluxnic.net>




> 
>  arch/arm/Kconfig           |    2 ++
>  arch/arm/plat-omap/Kconfig |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 44c16f0..9b63bab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -854,6 +854,7 @@ config ARCH_DAVINCI
>  	select HAVE_IDE
>  	select CLKDEV_LOOKUP
>  	select GENERIC_ALLOCATOR
> +	select GENERIC_IRQ_CHIP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	help
>  	  Support for TI's DaVinci platform.
> @@ -1033,6 +1034,7 @@ config PLAT_IOP
>  
>  config PLAT_ORION
>  	bool
> +	select GENERIC_IRQ_CHIP
>  	select HAVE_SCHED_CLOCK
>  
>  config PLAT_PXA
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index cd5f993..29b4c35 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_OMAP1
>  config ARCH_OMAP2PLUS
>  	bool "TI OMAP2/3/4"
>  	select CLKDEV_LOOKUP
> +	select GENERIC_IRQ_CHIP
>  	select OMAP_DM_TIMER
>  	help
>  	  "Systems based on OMAP2, OMAP3 or OMAP4"
> 
