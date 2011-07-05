From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 08:36:29 +0100
Subject: [PATCH 2/7] DMA: PL330: Update PL330 DMA API driver
In-Reply-To: <1309781915-31549-3-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110705073629.GM8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 09:18:30PM +0900, Kukjin Kim wrote:
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 25cf327..9b7f15a 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -193,7 +193,8 @@ config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
>  config PL330_DMA
>  	tristate "DMA API Driver for PL330"
>  	select DMA_ENGINE
> -	depends on PL330
> +	select ARM_AMBA

This is the wrong way around.  If your SoC supports Primecells, then you are
supposed to select ARM_AMBA from the SoC to allow the Primecell drivers to be
enabled.  Primecell drivers should then depend on ARM_AMBA.
