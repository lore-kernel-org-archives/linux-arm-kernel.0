From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 10:57:34 +0200
Subject: [PATCH v2] s3cmci: port DMA code to dmaengine API
In-Reply-To: <1400617259-6939-1-git-send-email-anarsoul@gmail.com>
References: <1400617259-6939-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4563444.HLmgOoMRYe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 23:20:59 Vasily Khoruzhick wrote:
> index 1384f67..e70e4cf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -420,6 +420,7 @@ config MMC_SPI
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
>         depends on ARCH_S3C24XX
> +       select S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in
>            Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
> 

I think you should use 'depends on S3C24XX_DMAC' here.

Other than that,

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
