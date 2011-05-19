From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 May 2011 12:18:27 -0600
Subject: [PATCH] gpio: remove some legacy comments in build files
In-Reply-To: <1303975117-20651-1-git-send-email-linus.walleij@stericsson.com>
References: <1303975117-20651-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110519181827.GC5109@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 09:18:37AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The build files for drivers/gpio has some wording and comments
> about the directory being reserved exclusively for GPIO expanders
> (according to the gpio.txt file these are on external busses) and
> this has been false for some time. We already have PL061 and
> Xilinx drivers which are in silicon and now I'm moving more
> silicon drivers here, so delete this and reword it a bit.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.
g.

> ---
>  drivers/gpio/Kconfig  |    8 ++++----
>  drivers/gpio/Makefile |    6 +-----
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c23401f..b7fac15 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1,5 +1,5 @@
>  #
> -# platform-neutral GPIO infrastructure and expanders
> +# GPIO infrastructure and drivers
>  #
>  
>  config ARCH_WANT_OPTIONAL_GPIOLIB
> @@ -31,7 +31,7 @@ menuconfig GPIOLIB
>  	help
>  	  This enables GPIO support through the generic GPIO library.
>  	  You only need to enable this, if you also want to enable
> -	  one or more of the GPIO expansion card drivers below.
> +	  one or more of the GPIO drivers below.
>  
>  	  If unsure, say N.
>  
> @@ -63,12 +63,12 @@ config GPIO_SYSFS
>  	  Kernel drivers may also request that a particular GPIO be
>  	  exported to userspace; this can be useful when debugging.
>  
> -# put expanders in the right section, in alphabetical order
> +# put drivers in the right section, in alphabetical order
>  
>  config GPIO_MAX730X
>  	tristate
>  
> -comment "Memory mapped GPIO expanders:"
> +comment "Memory mapped GPIO drivers:"
>  
>  config GPIO_BASIC_MMIO
>  	tristate "Basic memory-mapped GPIO controllers support"
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index e4851c5..cfbdef1 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -1,8 +1,4 @@
> -# generic gpio support: dedicated expander chips, etc
> -#
> -# NOTE: platform-specific GPIO drivers don't belong in the
> -# drivers/gpio directory; put them with other platform setup
> -# code, IRQ controllers, board init, etc.
> +# generic gpio support: platform drivers, dedicated expander chips, etc
>  
>  ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
>  
> -- 
> 1.7.3.2
> 
