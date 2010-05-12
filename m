From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 15:06:15 +0900
Subject: [PATCH 11/16] ARM: SMDKC100: enable i2c support again
In-Reply-To: <1270190944-21644-12-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-12-git-send-email-m.szyprowski@samsung.com>
Message-ID: <001e01caf199$3de2bb40$b9a831c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch enables support for i2c busses on SMDKC100 machine.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig         |    2 ++
>  arch/arm/mach-s5pc100/mach-smdkc100.c |    8 +++-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 03a51e2..f2d5c23 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -28,7 +28,9 @@ config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
>  	select S5PC100_SETUP_FB_24BPP
> +	select S5PC100_SETUP_I2C1
>  	select S3C_DEV_FB
> +	select S3C_DEV_I2C1
>  	help
>  	  Machine support for the Samsung SMDKC100
> 
> diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-
> s5pc100/mach-smdkc100.c
> index 44984be..93af963 100644
> --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> @@ -77,7 +77,6 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[]
__initdata
> = {
>  	},
>  };
> 
> -#if 0

Ok.

>  /* I2C0 */
>  static struct i2c_board_info i2c_devs0[] __initdata = {
>  };
> @@ -85,7 +84,7 @@ static struct i2c_board_info i2c_devs0[] __initdata = {
>  /* I2C1 */
>  static struct i2c_board_info i2c_devs1[] __initdata = {
>  };
> -#endif
> +
>  /* LCD power controller */
>  static void smdkc100_lcd_power_set(struct plat_lcd_data *pd,
>  				   unsigned int power)
> @@ -142,9 +141,9 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata
> __initdata = {
>  static struct platform_device *smdkc100_devices[] __initdata = {
>  	&s3c_device_fb,
>  	&smdkc100_lcd_powerdev,
> -#if 0
>  	&s3c_device_i2c0,
>  	&s3c_device_i2c1,
> +#if 0

Aha ;-)

>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc1,
>  	&s3c_device_hsmmc2,
> @@ -160,13 +159,12 @@ static void __init smdkc100_map_io(void)
> 
>  static void __init smdkc100_machine_init(void)
>  {
> -#if 0
>  	/* I2C */
>  	s3c_i2c0_set_platdata(NULL);
>  	s3c_i2c1_set_platdata(NULL);
>  	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
>  	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
> -#endif
> +
>  	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
> 
>  	/* LCD init */
> --
> 1.6.4
> 

Looks good except remaining if 0 :-)
I understand your intention.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
