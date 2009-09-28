From: ben@trinity.fluff.org (Ben Dooks)
Date: Mon, 28 Sep 2009 13:23:59 +0100
Subject: s3c24xx gpiolib question
In-Reply-To: <200909272012.53753.anarsoul@gmail.com>
References: <200909272012.53753.anarsoul@gmail.com>
Message-ID: <20090928122359.GE2698@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 08:12:44PM +0300, Vasily Khoruzhick wrote:
> Hi,
> 
> Is following patch sufficient to add GPJ port support to s3c24xx gpiolib?
> And how to switch gpioline to custom function mode (for example TOUT0 on GPB0) 
> via gpiolib?
> 
> diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
> index 6d7a961..65d79f9 100644
> --- a/arch/arm/plat-s3c24xx/gpiolib.c
> +++ b/arch/arm/plat-s3c24xx/gpiolib.c
> @@ -151,7 +151,8 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
>  			.ngpio			= 16,
>  			.to_irq			= s3c24xx_gpiolib_bankg_toirq,
>  		},
> -	}, {
> +	}, 
> +	[7] = {
>  		.base	= S3C2410_GPHCON,
>  		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
>  		.chip	= {
> @@ -161,6 +162,16 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
>  			.ngpio			= 11,
>  		},
>  	},
> +	[8] = {
> +		.base	= S3C2440_GPJCON,
> +		.pm = __gpio_pm(&s3c_gpio_pm_2bit),
> +		.chip	= {
> +			.base			= S3C2440_GPJ0,

I need to get the gpio number space compressed to get this to
work, it got shuffled out of this round of patches due to urgent
meetings.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
