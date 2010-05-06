From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 6 May 2010 02:22:58 +0100
Subject: [PATCH 5/9] Add support for red flashing LED on Acer n35
In-Reply-To: <4BE1EE8C.8040900@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz>
Message-ID: <20100506012258.GZ6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 12:17:48AM +0200, Pinkava J. wrote:
> 

how about one patch for all the leds?
 
> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
> ---
>  arch/arm/mach-s3c2410/mach-n30.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
> index aeabbff..b83eabd 100644
> --- a/arch/arm/mach-s3c2410/mach-n30.c
> +++ b/arch/arm/mach-s3c2410/mach-n30.c
> @@ -283,6 +283,13 @@ static struct s3c24xx_led_platdata n30_warning_led_pdata = {
>  	.def_trigger	= "",
>  };
> 
> +static struct s3c24xx_led_platdata n35_warning_led_pdata = {
> +	.name		= "warning_led",
> +	.flags          = S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
> +	.gpio		= S3C2410_GPD(9),
> +	.def_trigger	= "",
> +};
> +
>  static struct platform_device n30_blue_led = {
>  	.name		= "s3c24xx_led",
>  	.id		= 1,
> @@ -307,6 +314,14 @@ static struct platform_device n30_warning_led = {
>  	},
>  };
> 
> +static struct platform_device n35_warning_led = {
> +	.name		= "s3c24xx_led",
> +	.id		= 2,
> +	.dev		= {
> +		.platform_data	= &n35_warning_led_pdata,
> +	},
> +};
> +
>  static struct s3c2410fb_display n30_display __initdata = {
>  	.type		= S3C2410_LCDCON1_TFT,
>  	.width		= 240,
> @@ -355,6 +370,7 @@ static struct platform_device *n35_devices[] __initdata = {
>  	&s3c_device_usbgadget,
>  	&n35_button_device,
>  	&n35_blue_led,
> +	&n35_warning_led,
>  };
> 
>  static struct s3c2410_platform_i2c __initdata n30_i2ccfg = {
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
