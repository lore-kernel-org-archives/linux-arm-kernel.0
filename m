From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 21 Sep 2011 15:05:38 +0200
Subject: [PATCH V2 1/3] ARM: EXYNOS4: Add TVOUT support for SMDKV310
In-Reply-To: <1316583860-32510-2-git-send-email-hatim.rv@samsung.com>
References: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
	<1316583860-32510-2-git-send-email-hatim.rv@samsung.com>
Message-ID: <4E79E122.2000600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hatim,

On 09/21/2011 07:44 AM, Hatim Ali wrote:
> Add support for TVOUT on SMDKV310 board.
> 
> Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
> ---
...
> diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
> index 7ce4d8b..50de270 100644
> --- a/arch/arm/mach-exynos4/mach-smdkv310.c
> +++ b/arch/arm/mach-exynos4/mach-smdkv310.c
> @@ -239,6 +239,7 @@ static struct platform_device *smdkv310_devices[] __initdata = {
>  	&s3c_device_hsmmc2,
>  	&s3c_device_hsmmc3,
>  	&s3c_device_i2c1,
> +	&s5p_device_i2c_hdmiphy,
>  	&s3c_device_rtc,
>  	&s3c_device_wdt,
>  	&exynos4_device_ac97,
> @@ -262,6 +263,8 @@ static struct platform_device *smdkv310_devices[] __initdata = {
>  	&smdkv310_lcd_lte480wv,
>  	&smdkv310_smsc911x,
>  	&exynos4_device_ahci,
> +	&s5p_device_hdmi,
> +	&s5p_device_mixer,
>  };
>  
>  static void __init smdkv310_smsc911x_init(void)
> @@ -298,6 +301,25 @@ static struct platform_pwm_backlight_data smdkv310_bl_data = {
>  	.pwm_period_ns  = 1000,
>  };
>  
> +static void s5p_tv_setup(void)
> +{
> +	int ret;
> +
> +	/* direct HPD to HDMI chip */
> +	ret = gpio_request(EXYNOS4_GPX3(7), "hpd-plug");
> +
> +	if (!ret) {
> +		gpio_direction_input(EXYNOS4_GPX3(7));

Since you're probably going to be reworking this anyway, I think gpio_request_one
could be used here for simplicity.  

--
Regards,
Sylwester
