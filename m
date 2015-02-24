From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Feb 2015 22:40:55 +0900
Subject: [PATCH 1/1] spi: atmel: Fix interrupt setup for PDC transfers
In-Reply-To: <CANZ4BrSBnE78Z8WeNvRhEZRdxKMhToxpwcSvf0cLpZLJxGA78Q@mail.gmail.com>
References: <CANZ4BrSBnE78Z8WeNvRhEZRdxKMhToxpwcSvf0cLpZLJxGA78Q@mail.gmail.com>
Message-ID: <20150224134055.GG6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 01:26:20PM +0100, Torsten Fleischer wrote:

> spi_master *master,
>   (unsigned long long)xfer->rx_dma);
>   }
> 
> - /* REVISIT: We're waiting for ENDRX before we start the next
> + /* REVISIT: We're waiting for RXBUFF before we start the next
>   * transfer because we need to handle some difficult timing
> - * issues otherwise. If we wait for ENDTX in one transfer and
> - * then starts waiting for ENDRX in the next, it's difficult
> - * to tell the difference between the ENDRX interrupt we're
> - * actually waiting for and the ENDRX interrupt of the
> + * issues otherwise. If we wait for TXBUFE in one transfer and
> + * then starts waiting for RXBUFF in the next, it's difficult
> + * to tell the difference between the RXBUFF interrupt we're
> + * actually waiting for and the RXBUFF interrupt of the
>   * previous transfer.
>   *
>   * It should be doable, though. Just not now...
>   */
> - spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
> + spi_writel(as, IER, SPI_BIT(RXBUFF) | SPI_BIT(OVRES));
>   spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
>  }

It looks like your mail program has corrupted the patch and turned all
tabs into spaces...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/a6f2fe26/attachment.sig>
