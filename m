From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 07:52:12 +0900
Subject: [PATCH 2.6.36] S3C64XX: Fix special function for IISv4 port
In-Reply-To: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <003101cb6b29$47f1c810$d7d55830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> When converting to use s3c_gpio_cfgpin_range() the function for the
> IISv4 block appears to have been typoed as 4 (the keypad) rather than
> 5 as it should be.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/dev-audio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c
b/arch/arm/mach-s3c64xx/dev-
> audio.c
> index e53764e..76426a3 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -49,7 +49,7 @@ static int s3c64xx_i2sv4_cfg_gpio(struct platform_device
> *pdev)
>  	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
>  	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
>  	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
> -	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(4));
> +	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
> 
>  	return 0;
>  }
> --

Hi,

According to commit f08269d8, when converting to use s3c_gpio_cfgpin_range()
the function, there was no typo.
(Commit f08269d8: ARM: S3C64XX: Change to using s3c_gpio_cfgpin_range())

@@ -51,10 +48,7 @@ static int s3c64xx_i2sv4_cfg_gpio(struct platform_device
*pdev)
 	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C_GPIO_SFN(4));
+	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(4));

 	return 0;
 }

It seems to happen more before...
Anyway, you're right. should be fixed.

Will apply in -next :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
