From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:36:29 +0100
Subject: [PATCH 8/8] ARM: PXA: Z2: Add default triggers for LEDs
In-Reply-To: <1299839023-16601-8-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-8-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112236.29701.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 11:23:43 Vasily Khoruzhick wrote:
> So user can see if there's any mmc activity and if device's
> charging.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

You can have my:

Acked-by: Marek Vasut <marek.vasut@gmail.com>

on this one.
> ---
>  arch/arm/mach-pxa/z2.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 2fac54d..7314a79 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -315,12 +315,12 @@ struct gpio_led z2_gpio_leds[] = {
>  	.active_low		= 1,
>  }, {
>  	.name			= "z2:green:charged",
> -	.default_trigger	= "none",
> +	.default_trigger	= "mmc0",
>  	.gpio			= GPIO85_ZIPITZ2_LED_CHARGED,
>  	.active_low		= 1,
>  }, {
>  	.name			= "z2:amber:charging",
> -	.default_trigger	= "none",
> +	.default_trigger	= "Z2-charging-or-full",
>  	.gpio			= GPIO83_ZIPITZ2_LED_CHARGING,
>  	.active_low		= 1,
>  },
