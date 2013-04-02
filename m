From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 02 Apr 2013 18:55:08 +0900
Subject: [PATCH] ARM: S3C64XX: remove obsolete Makefile line
In-Reply-To: <1364597502.1345.103.camel@x61.thuisdomein>
References: <1364597502.1345.103.camel@x61.thuisdomein>
Message-ID: <237a01ce2f88$28edbd90$7ac938b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> Commit a07613a54d700a974f3a4a657da78ef5d097315d ("Merge branch
> 'samsung/dt' into samsung/cleanup") added this line to
> arch/arm/mach-s3c64xx/Makefile:
>     obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> 
> But at that time CONFIG_S3C64XX_DEV_SPI wasn't a valid Kconfig macro
> anymore and arch/arm/mach-s3c64xx/dev-spi.c was already removed. So we
> can remove this line.
> 
Yes, the dev-spi.c has been removed with Consolidation work of SPI platform devices.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
>  arch/arm/mach-s3c64xx/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-
> s3c64xx/Makefile
> index f9ce1dc..31d0c91 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -32,7 +32,6 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
> 
>  obj-y				+= dev-uart.o
>  obj-y				+= dev-audio.o
> -obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> 
>  # Device setup
> 
> --
> 1.7.11.7
> 
Looks OK to me, applied.

Thanks.

- Kukjin
