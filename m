From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Nov 2010 18:20:05 +0900
Subject: [PATCH 1/2] ARM: S3C2410: H1940: Adapt h1940-bluetooth to gpiolib
	changes
In-Reply-To: <1289248308-21272-1-git-send-email-anarsoul@gmail.com>
References: <1289248308-21272-1-git-send-email-anarsoul@gmail.com>
Message-ID: <010b01cb856f$77c05ab0$67411010$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> Replace in s3c_gpio_cfgpull with s3c_gpio_setpull.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/h1940-bluetooth.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-
> s3c2410/h1940-bluetooth.c
> index 8aa2f19..6b86a72 100644
> --- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
> +++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> @@ -77,13 +77,13 @@ static int __devinit h1940bt_probe(struct
platform_device
> *pdev)
> 
>  	/* Configures BT serial port GPIOs */
>  	s3c_gpio_cfgpin(S3C2410_GPH(0), S3C2410_GPH0_nCTS0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(0), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(1), S3C2410_GPIO_OUTPUT);
> -	s3c_gpio_cfgpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(1), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(2), S3C2410_GPH2_TXD0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(2), S3C_GPIO_PULL_NONE);
>  	s3c_gpio_cfgpin(S3C2410_GPH(3), S3C2410_GPH3_RXD0);
> -	s3c_gpio_cfgpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_setpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
> 
> 
>  	rfk = rfkill_alloc(DRV_NAME, &pdev->dev, RFKILL_TYPE_BLUETOOTH,
> --

You're right..will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
