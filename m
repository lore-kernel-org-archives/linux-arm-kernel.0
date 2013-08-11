From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 20:11:40 +0100
Subject: [PATCH 17/18] spi: s3c64xx: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <1376243970-6489-18-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-18-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130811191140.GI6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 07:59:29PM +0200, Tomasz Figa wrote:

> @@ -366,7 +366,7 @@ config SPI_S3C24XX_FIQ
>  config SPI_S3C64XX
>  	tristate "Samsung S3C64XX series type SPI"
>  	depends on (ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
> -	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
> +	select S3C64XX_PL080 if ARCH_S3C64XX
>  	help
>  	  SPI driver for Samsung S3C64XX and newer SoCs.

Do we need the select here (or should we have other selects for the
Exynos SoCs)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/e4eca38b/attachment.sig>
