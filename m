From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 20 Nov 2010 15:01:31 +0100
Subject: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
In-Reply-To: <4CE7B6F7.7080108@ru.mvista.com>
References: <20101120095906.GD4216@game.jcrosoft.org>
	<1290247733-17834-6-git-send-email-plagnioj@jcrosoft.com>
	<4CE7B6F7.7080108@ru.mvista.com>
Message-ID: <20101120140131.GF4216@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:54 Sat 20 Nov     , Sergei Shtylyov wrote:
> Hello.
> 
> On 20-11-2010 13:08, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> >passing argument 2 of 'dma_map_single' discards qualifiers from pointer target type
> 
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >---
> >  drivers/spi/atmel_spi.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> >diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> >index 154529a..2cf6abd 100644
> >--- a/drivers/spi/atmel_spi.c
> >+++ b/drivers/spi/atmel_spi.c
> >@@ -352,8 +352,10 @@ atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
> >
> >  	xfer->tx_dma = xfer->rx_dma = INVALID_DMA_ADDRESS;
> >  	if (xfer->tx_buf) {
> >+		void *nonconst_tx = (void *)xfer->tx_buf; /* shut up gcc */
> >+
> 
>    Aren't casts to 'void *' automatic?
no as the tx_buf is const void *

Best Regards,
J.
