From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Aug 2014 18:44:42 +0100
Subject: [PATCH v3 2/8] spi: sun4i: add DMA support
In-Reply-To: <1407183002-29420-3-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140807174442.GP17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 05:09:56PM -0300, Emilio L?pez wrote:

> +static int sun4i_spi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct sun4i_spi *sspi = spi_master_get_devdata(master);
> +
> +	master->dma_rx = sspi->rx_dma_chan;
> +	master->dma_tx = sspi->tx_dma_chan;
> +
> +	return 0;
> +}

Why is this being done per transfer rather than at probe time?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/930f5ba3/attachment.sig>
