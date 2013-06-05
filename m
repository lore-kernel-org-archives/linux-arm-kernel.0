From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Jun 2013 08:38:47 -0700
Subject: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
In-Reply-To: <2942784.trumtc2GjZ@wuerfel>
References: <2942784.trumtc2GjZ@wuerfel>
Message-ID: <20130605153847.GV3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130531 09:05]:
> The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
> has caused a new warning for omap1_defconfig:
> 
> drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
>  static void omap_gpio_init_context(struct gpio_bank *p) {}
>              ^
> 
> The solution is to mark the stub function as 'static inline' so
> it gets left out of the build when unused.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d3f7d2d..e5fba65 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1462,7 +1462,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  #else
>  #define omap_gpio_runtime_suspend NULL
>  #define omap_gpio_runtime_resume NULL
> -static void omap_gpio_init_context(struct gpio_bank *p) {}
> +static inline void omap_gpio_init_context(struct gpio_bank *p) {}
>  #endif
>  
>  static const struct dev_pm_ops gpio_pm_ops = {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
