From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2009 09:55:35 -0700
Subject: [PATCH 1/6] omap: Fix Unlikely(x) < y
In-Reply-To: <20091014001341.6116.47622.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
	<20091014001341.6116.47622.stgit@localhost>
Message-ID: <20091014165535.GG12700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091013 17:21]:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> The closing parenthesis was not on the right location.

Looks like this one is in the -mm now, so dropping from
mine.

Tony
 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 71ebd7f..7c345b7 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -373,7 +373,7 @@ static inline int gpio_valid(int gpio)
>  
>  static int check_gpio(int gpio)
>  {
> -	if (unlikely(gpio_valid(gpio)) < 0) {
> +	if (unlikely(gpio_valid(gpio) < 0)) {
>  		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
>  		dump_stack();
>  		return -1;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
