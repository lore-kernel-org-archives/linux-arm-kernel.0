From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 3 Jun 2011 14:10:17 -0600
Subject: [PATCH v3] gpio: ep93xx: move driver to drivers/gpio
In-Reply-To: <201106011009.19844.hartleys@visionengravers.com>
References: <201106011009.19844.hartleys@visionengravers.com>
Message-ID: <20110603201017.GC17972@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 10:09:19AM -0700, H Hartley Sweeten wrote:
> The GPIO driver should reside in drivers/gpio.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>
> 

Applied, thanks...

> ---
> 
> v3: Change Kconfig option to def_bool y
> v2: Make the Kconfig symbol a silent option, dependent on ARCH_EP93XX

BTW, please put the patch changelog above the s-o-b list in future
patches.  It's helpful to include that information in the upstream
commit.

g.

> 
> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
> index 33ee2c8..6b7c41d 100644
> --- a/arch/arm/mach-ep93xx/Makefile
> +++ b/arch/arm/mach-ep93xx/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for the linux kernel.
>  #
> -obj-y			:= core.o clock.o dma-m2p.o gpio.o
> +obj-y			:= core.o clock.o dma-m2p.o
>  obj-m			:=
>  obj-n			:=
>  obj-			:=
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 18c0b31..517172f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -86,6 +86,10 @@ config GPIO_IT8761E
>  	help
>  	  Say yes here to support GPIO functionality of IT8761E super I/O chip.
>  
> +config GPIO_EP93XX
> +	def_bool y
> +	depends on ARCH_EP93XX
> +
>  config GPIO_EXYNOS4
>  	bool "Samsung Exynos4 GPIO library support"
>  	default y
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4ac7cb3..c8faabe 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_GPIO_ADP5520)	+= adp5520-gpio.o
>  obj-$(CONFIG_GPIO_ADP5588)	+= adp5588-gpio.o
>  obj-$(CONFIG_GPIO_BASIC_MMIO_CORE)	+= basic_mmio_gpio.o
>  obj-$(CONFIG_GPIO_BASIC_MMIO)	+= basic_mmio_gpio.o
> +obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
>  obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
>  obj-$(CONFIG_GPIO_I801)		+= gpio-i801.o
>  obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
> diff --git a/arch/arm/mach-ep93xx/gpio.c b/drivers/gpio/gpio-ep93xx.c
> similarity index 100%
> rename from arch/arm/mach-ep93xx/gpio.c
> rename to drivers/gpio/gpio-ep93xx.c
