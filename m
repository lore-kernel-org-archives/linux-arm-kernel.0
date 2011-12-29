From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 12:47:23 +0900
Subject: [PATCH] ARM: SAMSUNG: Declare struct platform_device in
 plat/s3c64xx-spi.h
In-Reply-To: <1325121208-32295-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325121208-32295-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <029201ccc5dc$92c2aad0$b8480070$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The function declarations in plat/s3c64xx-spi.h rely on struct
> platform_device but it's not declared by the header causing compiler
> warnings if it is included prior to another header which does that.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> index aea68b6..fa95e9a 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> @@ -11,6 +11,8 @@
>  #ifndef __S3C64XX_PLAT_SPI_H
>  #define __S3C64XX_PLAT_SPI_H
> 
> +struct platform_device;
> +
>  /**
>   * struct s3c64xx_spi_csinfo - ChipSelect description
>   * @fb_delay: Slave specific feedback delay.
> --
> 1.7.7.3

Yes, right. Will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
