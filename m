From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 9 Oct 2009 17:22:02 -0400
Subject: [PATCH 2/8] bcmring: add gpio support in Kconfig and Makefile
In-Reply-To: <20091009211224.GA24851@broadcom.com>
References: <20091009211224.GA24851@broadcom.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7E08@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 09, 2009 2:12 PM, Leo (Hao) Chen wrote:
> From 4aff48c9134bc44306540bf7220c3546a8a889d2 Mon Sep 17 00:00:00 2001
> From: Leo Chen <leochen@broadcom.com>
> Date: Wed, 7 Oct 2009 11:43:05 -0700
> Subject: [PATCH] bcmring: gpio addition to Kconfig and Makefile
> 
> 
> Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
> ---
>  arch/arm/Kconfig                   |    3 ++-
>  arch/arm/mach-bcmring/Makefile     |    3 ++-
>  arch/arm/mach-bcmring/csp/Makefile |    2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c4119c..d22af37 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -695,10 +695,11 @@ config ARCH_BCMRING
>  	depends on MMU
>  	select CPU_V6
>  	select ARM_AMBA
> +	select GENERIC_GPIO
>  	select COMMON_CLKDEV
>  	select GENERIC_TIME
>  	select GENERIC_CLOCKEVENTS
> -	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARCH_REQUIRE_GPIOLIB
>  	help
>  	  Support for Broadcom's BCMRing platform.
>  
> diff --git a/arch/arm/mach-bcmring/Makefile b/arch/arm/mach-bcmring/Makefile
> index f8d9fce..b629869 100644
> --- a/arch/arm/mach-bcmring/Makefile
> +++ b/arch/arm/mach-bcmring/Makefile
> @@ -4,5 +4,6 @@
>  
>  # Object file lists.
>  
> -obj-y := arch.o mm.o irq.o clock.o core.o timer.o dma.o
> +obj-y := arch.o mm.o irq.o clock.o core.o timer.o dma.o gpio_irq.o
>  obj-y += csp/
> +obj-$(CONFIG_ARCH_REQUIRE_GPIOLIB)	+= gpio.o

If ARCH_BCMRING always has CONFIG_ARCH_REQUIRE_GPIOLIB why not just add
gpio.o to the obj-y list?

Regards,
Hartley
