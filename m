From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Aug 2010 15:50:46 +0200
Subject: [PATCH 2/3] h1940: fix h1940-bluetooth compilation
In-Reply-To: <1282230003-2020-3-git-send-email-anarsoul@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<1282230003-2020-3-git-send-email-anarsoul@gmail.com>
Message-ID: <201008241550.46858.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 19. srpna 2010 17:00:02 Vasily Khoruzhick napsal(a):
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Errr ... fix ... in what way? What was broken? I don't understand, please add 
more explanatory text. Thanks
Cheers
> ---
>  arch/arm/mach-s3c2410/h1940-bluetooth.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c
> b/arch/arm/mach-s3c2410/h1940-bluetooth.c index 8aa2f19..6b86a72 100644
> --- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
> +++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> @@ -77,13 +77,13 @@ static int __devinit h1940bt_probe(struct
> platform_device *pdev)
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
