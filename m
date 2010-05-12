From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 May 2010 16:05:10 +0900
Subject: [PATCH 13/16] ARM: SMDKC100: enable sdhci support again
In-Reply-To: <1270190944-21644-14-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-14-git-send-email-m.szyprowski@samsung.com>
Message-ID: <002001caf1a1$79d4fa70$6d7eef50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch enables support for sdhci controllers on SMDKC100 machine.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig         |    4 ++++
>  arch/arm/mach-s5pc100/mach-smdkc100.c |    2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index af64da3..168bf51 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -40,8 +40,12 @@ config MACH_SMDKC100
>  	select CPU_S5PC100
>  	select S5PC100_SETUP_FB_24BPP
>  	select S5PC100_SETUP_I2C1
> +	select S5PC100_SETUP_SDHCI
>  	select S3C_DEV_FB
>  	select S3C_DEV_I2C1
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
> +	select S3C_DEV_HSMMC2
>  	help
>  	  Machine support for the Samsung SMDKC100
> 
> diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-
> s5pc100/mach-smdkc100.c
> index 93af963..052f6db 100644
> --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> @@ -143,11 +143,9 @@ static struct platform_device *smdkc100_devices[]
> __initdata = {
>  	&smdkc100_lcd_powerdev,
>  	&s3c_device_i2c0,
>  	&s3c_device_i2c1,
> -#if 0
>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc1,
>  	&s3c_device_hsmmc2,
> -#endif
>  };
> 
>  static void __init smdkc100_map_io(void)
> --
> 1.6.4

Looks good.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
