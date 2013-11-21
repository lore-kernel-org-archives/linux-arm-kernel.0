From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Nov 2013 13:00:09 +0900
Subject: [PATCH] ARM: shmobile: koelsch: mark GPIO keys as wake-up sources
In-Reply-To: <20131120035638.30046.96506.sendpatchset@w520>
References: <20131120035638.30046.96506.sendpatchset@w520>
Message-ID: <20131121040007.GE31130@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 12:56:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Enable wakeup for the GPIO keys on the Koelsch board.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0015/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-11-20 12:40:24.000000000 +0900
> @@ -57,7 +57,7 @@ static const struct gpio_led_platform_da
>  /* GPIO KEY */
>  #define GPIO_KEY(c, g, d, ...) \
>  	{ .code = c, .gpio = g, .desc = d, .active_low = 1, \
> -	  .debounce_interval = 20 }
> +	  .wakeup = 1, .debounce_interval = 20 }
>  
>  static struct gpio_keys_button gpio_buttons[] = {
>  	GPIO_KEY(KEY_4,		RCAR_GP_PIN(5, 3),	"SW2-pin4"),
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
