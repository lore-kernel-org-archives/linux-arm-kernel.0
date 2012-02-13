From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 08:00:33 -0600
Subject: [PATCH 1/1] gpio: drop CONFIG_OF_GPIO in the definition of the
 struct gpio_chip
In-Reply-To: <1329125002-21134-1-git-send-email-plagnioj@jcrosoft.com>
References: <1329125002-21134-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4F391781.2020203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 03:23 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this will allow to avoid the ifdef CONFIG_OF_GPIO in gpio drivers
> 

So would always enabling CONFIG_OF on at91 and then only 1 sub-arch is
paying the price for additional space. Then we would only have ifdefs in
the truly cross-platform gpio drivers.

Rob

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  include/asm-generic/gpio.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 1ff4e22..c08b758 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -122,7 +122,6 @@ struct gpio_chip {
>  	unsigned		can_sleep:1;
>  	unsigned		exported:1;
>  
> -#if defined(CONFIG_OF_GPIO)
>  	/*
>  	 * If CONFIG_OF is enabled, then all GPIO controllers described in the
>  	 * device tree automatically may have an OF translation
> @@ -131,7 +130,6 @@ struct gpio_chip {
>  	int of_gpio_n_cells;
>  	int (*of_xlate)(struct gpio_chip *gc,
>  		        const struct of_phandle_args *gpiospec, u32 *flags);
> -#endif
>  };
>  
>  extern const char *gpiochip_is_requested(struct gpio_chip *chip,
