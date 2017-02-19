From: broonie@kernel.org (Mark Brown)
Date: Sun, 19 Feb 2017 16:29:55 +0000
Subject: [PATCH v2 1/6] spi: davinci: Use SPI framework to handle DMA
 mapping
In-Reply-To: <1487327904-28311-2-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-2-git-send-email-fisaksen@baylibre.com>
Message-ID: <20170219162955.cf3t6dljxblf5zwg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:38:19AM +0100, Frode Isaksen wrote:

> +static inline bool __davinci_spi_can_dma(struct spi_device *spi)
> +{
> +	struct davinci_spi_config *spicfg = spi->controller_data;
> +
> +	return spicfg ? spicfg->io_type == SPI_IO_TYPE_DMA : false;
> +}
> +
> +static bool davinci_spi_can_dma(struct spi_master *master,
> +				struct spi_device *spi,
> +				struct spi_transfer *xfer)
> +{
> +	return __davinci_spi_can_dma(spi);
> +}

Why the wrapper function?  __davinci_spi_can_dma has exactly one user
immediately below it.  Also please write normal if statements, it really
helps with legibility.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170219/ac1c20df/attachment.sig>
