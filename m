From: joe@perches.com (Joe Perches)
Date: Sun, 06 Jan 2013 18:10:15 -0800
Subject: [v3 PATCH 06/12] spi/atmel_spi: add dmaengine support
In-Reply-To: <1357523413-27209-7-git-send-email-wenyou.yang@atmel.com>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
 <1357523413-27209-7-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357524615.4940.19.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-07 at 09:50 +0800, Wenyou Yang wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
[]
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
[]
> +static inline bool atmel_spi_use_dma(struct atmel_spi *as,
> +				struct spi_transfer *xfer)
> +{
> +	if ((as->use_dma) && (xfer->len >= DMA_MIN_BYTES))
> +		return true;
> +	else
> +		return false;
> +}

Same unnecessary form.

	return as->use_dma && xfer->len >= DMA_MIN_BYTES;

> +static inline bool atmel_spi_use_pdc(struct atmel_spi *as)
> +{
> +	if (as->use_pdc)
> +		return true;
> +	else
> +		return false;
> +}

Does this function really need to exist at all?
