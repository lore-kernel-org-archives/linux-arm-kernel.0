From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 12:37:11 +0900
Subject: [PATCH] ARM: S3C64XX: Staticise s3c64xx_init_uarts()
In-Reply-To: <1325121194-32240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325121194-32240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <028f01ccc5db$2658df50$730a9df0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Since the merge of everything into common.c s3c64xx_init_uarts() is now
> only used within the one source file and should therefore be declared
> static.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-
> s3c64xx/common.c
> index 8ae5b16..f8cc5a0 100644
> --- a/arch/arm/mach-s3c64xx/common.c
> +++ b/arch/arm/mach-s3c64xx/common.c
> @@ -49,7 +49,7 @@
> 
>  /* uart registration process */
> 
> -void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
> +static void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int
no)
>  {
>  	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg,
> no);
>  }
> --
> 1.7.7.3

OK, let me send this to patch system.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
