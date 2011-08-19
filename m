From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Aug 2011 22:07:38 +0900
Subject: [PATCH] ARM: SAMSUNG: TSADC: Remove unnecessary duplication of
	plat_data
In-Reply-To: <1313754043-29398-1-git-send-email-ch.naveen@samsung.com>
References: <1313754043-29398-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <002b01cc5e70$f902f350$eb08d9f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> The default plat_data struct for TSADC is added in devs-ts
> and duplication is removed from the following machines.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> 
> Note: Only build tested on mini6410, real6410.
> 
>  arch/arm/mach-s3c64xx/mach-mini6410.c |    8 +-------
>  arch/arm/mach-s3c64xx/mach-real6410.c |    8 +-------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |    8 +-------
>  arch/arm/mach-s5p64x0/mach-smdk6440.c |    8 +-------
>  arch/arm/mach-s5p64x0/mach-smdk6450.c |    8 +-------
>  arch/arm/mach-s5pc100/mach-smdkc100.c |    8 +-------
>  arch/arm/mach-s5pv210/mach-smdkv210.c |    8 +-------
>  arch/arm/plat-samsung/dev-ts.c        |    9 +++++++++
>  8 files changed, 16 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-
> s3c64xx/mach-mini6410.c
> index 527f49b..8f34a3c 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -205,12 +205,6 @@ static struct platform_device mini6410_lcd_powerdev =
{
>  	.dev.platform_data	= &mini6410_lcd_power_data,
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  static struct platform_device *mini6410_devices[] __initdata = {
>  	&mini6410_device_eth,
>  	&s3c_device_hsmmc0,
> @@ -319,7 +313,7 @@ static void __init mini6410_machine_init(void)
> 
>  	s3c_nand_set_platdata(&mini6410_nand_info);
>  	s3c_fb_set_platdata(&mini6410_lcd_pdata);
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	/* configure nCS1 width to 16 bits */
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
> s3c64xx/mach-real6410.c
> index 95b04b1..1f5abfa 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -198,12 +198,6 @@ static struct platform_device *real6410_devices[]
> __initdata = {
>  	&s3c_device_ohci,
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  static void __init real6410_map_io(void)
>  {
>  	u32 tmp;
> @@ -300,7 +294,7 @@ static void __init real6410_machine_init(void)
> 
>  	s3c_fb_set_platdata(&real6410_lcd_pdata);
>  	s3c_nand_set_platdata(&real6410_nand_info);
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	/* configure nCS1 width to 16 bits */
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
> s3c64xx/mach-smdk6410.c
> index ecbea92..c5190a5 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -658,12 +658,6 @@ static struct i2c_board_info i2c_devs1[] __initdata =
{
>  	{ I2C_BOARD_INFO("24c128", 0x57), },	/* Samsung S524AD0XD1 */
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  /* LCD Backlight data */
>  static struct samsung_bl_gpio_info smdk6410_bl_gpio_info = {
>  	.no = S3C64XX_GPF(15),
> @@ -705,7 +699,7 @@ static void __init smdk6410_machine_init(void)
> 
>  	samsung_keypad_set_platdata(&smdk6410_keypad_data);
> 
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	/* configure nCS1 width to 16 bits */
> 
> diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-
> s5p64x0/mach-smdk6440.c
> index 346f8df..340f30f 100644
> --- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
> +++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
> @@ -129,12 +129,6 @@ static struct i2c_board_info smdk6440_i2c_devs1[]
> __initdata = {
>  	/* To be populated */
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  /* LCD Backlight data */
>  static struct samsung_bl_gpio_info smdk6440_bl_gpio_info = {
>  	.no = S5P6440_GPF(15),
> @@ -155,7 +149,7 @@ static void __init smdk6440_map_io(void)
> 
>  static void __init smdk6440_machine_init(void)
>  {
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	s3c_i2c0_set_platdata(&s5p6440_i2c0_data);
>  	s3c_i2c1_set_platdata(&s5p6440_i2c1_data);
> diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-
> s5p64x0/mach-smdk6450.c
> index 33f2adf..ee0da14 100644
> --- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
> +++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
> @@ -148,12 +148,6 @@ static struct i2c_board_info smdk6450_i2c_devs1[]
> __initdata = {
>  	{ I2C_BOARD_INFO("24c128", 0x57), },/* Samsung S524AD0XD1
> EEPROM */
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  /* LCD Backlight data */
>  static struct samsung_bl_gpio_info smdk6450_bl_gpio_info = {
>  	.no = S5P6450_GPF(15),
> @@ -174,7 +168,7 @@ static void __init smdk6450_map_io(void)
> 
>  static void __init smdk6450_machine_init(void)
>  {
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	s3c_i2c0_set_platdata(&s5p6450_i2c0_data);
>  	s3c_i2c1_set_platdata(&s5p6450_i2c1_data);
> diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-
> s5pc100/mach-smdkc100.c
> index 227d890..0b70762 100644
> --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> @@ -203,12 +203,6 @@ static struct platform_device *smdkc100_devices[]
> __initdata = {
>  	&s5pc100_device_spdif,
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  /* LCD Backlight data */
>  static struct samsung_bl_gpio_info smdkc100_bl_gpio_info = {
>  	.no = S5PC100_GPD(0),
> @@ -228,7 +222,7 @@ static void __init smdkc100_map_io(void)
> 
>  static void __init smdkc100_machine_init(void)
>  {
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	/* I2C */
>  	s3c_i2c0_set_platdata(NULL);
> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-
> s5pv210/mach-smdkv210.c
> index 5e011fc..4b27bca 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -265,12 +265,6 @@ static struct i2c_board_info smdkv210_i2c_devs2[]
> __initdata = {
>  	/* To Be Updated */
>  };
> 
> -static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> -	.delay			= 10000,
> -	.presc			= 49,
> -	.oversampling_shift	= 2,
> -};
> -
>  /* LCD Backlight data */
>  static struct samsung_bl_gpio_info smdkv210_bl_gpio_info = {
>  	.no = S5PV210_GPD0(3),
> @@ -296,7 +290,7 @@ static void __init smdkv210_machine_init(void)
>  	smdkv210_dm9000_init();
> 
>  	samsung_keypad_set_platdata(&smdkv210_keypad_data);
> -	s3c24xx_ts_set_platdata(&s3c_ts_platform);
> +	s3c24xx_ts_set_platdata(NULL);
> 
>  	s3c_i2c0_set_platdata(NULL);
>  	s3c_i2c1_set_platdata(NULL);
> diff --git a/arch/arm/plat-samsung/dev-ts.c
b/arch/arm/plat-samsung/dev-ts.c
> index 82543f0..5f3d46a 100644
> --- a/arch/arm/plat-samsung/dev-ts.c
> +++ b/arch/arm/plat-samsung/dev-ts.c
> @@ -43,8 +43,17 @@ struct platform_device s3c_device_ts = {
>  	.resource	= s3c_ts_resource,
>  };
> 
> +static struct s3c2410_ts_mach_info default_ts_data __initdata = {
> +	.delay			= 10000,
> +	.presc			= 49,
> +	.oversampling_shift	= 2,
> +};
> +
>  void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
>  {
> +	if (!pd)
> +		pd = &default_ts_data;
> +
>  	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
>  			 &s3c_device_ts);
>  }
> --
> 1.7.2.3

Looks ok, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
