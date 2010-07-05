From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Jul 2010 09:15:53 +0200
Subject: [PATCH 15/33] Removing dead PROCESSOR_NS9750
In-Reply-To: <73d2b3929175d36d8bfdedf2d49150d2ed911b2a.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<73d2b3929175d36d8bfdedf2d49150d2ed911b2a.1277911346.git.siccegge@cs.fau.de>
Message-ID: <20100705071553.GD18865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 05:58:48PM +0200, Christoph Egger wrote:
> PROCESSOR_NS9750 doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-ns9xxx/gpio.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-ns9xxx/gpio.c b/arch/arm/mach-ns9xxx/gpio.c
> index 5503ca0..58f4f50 100644
> --- a/arch/arm/mach-ns9xxx/gpio.c
> +++ b/arch/arm/mach-ns9xxx/gpio.c
> @@ -25,9 +25,6 @@
>  
>  #if defined(CONFIG_PROCESSOR_NS9360)
>  #define GPIO_MAX 72
> -#elif defined(CONFIG_PROCESSOR_NS9750)
> -#define GPIO_MAX 49
> -#endif
>  
>  /* protects BBU_GCONFx and BBU_GCTRLx */
>  static spinlock_t gpio_lock = __SPIN_LOCK_UNLOCKED(gpio_lock);
> @@ -42,11 +39,6 @@ static inline int ns9xxx_valid_gpio(unsigned gpio)
>  		return gpio <= 72;
>  	else
>  #endif
> -#if defined(CONFIG_PROCESSOR_NS9750)
> -	if (processor_is_ns9750())
> -		return gpio <= 49;
> -	else
> -#endif
>  	{
>  		BUG();
>  		return 0;
The code is correct as is, but AFAIK the ns9750 isn't supported anymore
even in the Digi provided BSPs and as it seems there aren't any efforts
to maintain ns9xxx in mainline.

So, Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
