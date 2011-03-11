From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:36:40 +0100
Subject: [PATCH 7/8] ARM: PXA: Z2: Keep kbd backlight disabled by default
In-Reply-To: <1299839023-16601-7-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-7-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112236.40272.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 11:23:42 Vasily Khoruzhick wrote:
> It eats too much power, and anyway it's not usefull
> during boot process. Userspace can enable it later.
> 

You can have my:

Acked-by: Marek Vasut <marek.vasut@gmail.com>

on this one.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/z2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index d1e40ba..2fac54d 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -210,7 +210,7 @@ static struct platform_pwm_backlight_data
> z2_backlight_data[] = { /* Keypad Backlight */
>  		.pwm_id		= 1,
>  		.max_brightness	= 1023,
> -		.dft_brightness	= 512,
> +		.dft_brightness	= 0,
>  		.pwm_period_ns	= 1260320,
>  	},
>  	[1] = {
