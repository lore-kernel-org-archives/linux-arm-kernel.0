From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Nov 2011 21:03:38 +0900
Subject: [PATCH 1/3 v3.1] ARM: S3C64XX: Update for conversion to
	SAMSUNG_GPIO_EXTRA
In-Reply-To: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <004f01cc9957$74c87340$5e5959c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The conversion of the S3C64XX GPIOs to the generic Samsung GPIOs mean that
> rather than using the previous S3C24XX_GPIO_EXTRA configuration the driver
> now uses SAMSUNG_GPIO_EXTRA.
> 
> Since SAMSUNG_GPIO_EXTRA requires the arch to include the extra space in
> ARCH_NR_GPIOs add it on to BOARD_NR_GPIOs (in case boards are relying on
> the existing reservation).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/include/mach/gpio.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-
> s3c64xx/include/mach/gpio.h
> index 6e34c2f..090c497 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
> @@ -88,6 +88,6 @@ enum s3c_gpio_number {
>  /* define the number of gpios we need to the one after the GPQ() range */
>  #define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
> 
> -#define BOARD_NR_GPIOS 16
> +#define BOARD_NR_GPIOS (16 + CONFIG_SAMSUNG_GPIO_EXTRA)
> 
>  #define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
> --
> 1.7.7.1

Yes, agree. BTW, what's the 'v3.1' in title?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
