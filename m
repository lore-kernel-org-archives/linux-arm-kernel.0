From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 14 Apr 2011 20:43:43 +0200
Subject: i.MX27 SPI tx fifo underrun
In-Reply-To: <20110414183613.GH3811@pengutronix.de>
References: <io73tm$1e5$1@dough.gmane.org>
	<20110414183613.GH3811@pengutronix.de>
Message-ID: <20110414184343.GA16552@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 08:36:13PM +0200, Robert Schwebel wrote:
> On Thu, Apr 14, 2011 at 05:29:57PM +0200, Jurgen Braam wrote:
> > while trying to write to an at25 eeprom connected via SPI on an
> > i.MX27, I ran into a TX FIFO underrun. In spi_imx_isr() the variable
> > spi_imx->txfifo gets rather large as a result of an unsigned integer
> > underflow, resulting in a feels-like-endless loop.
> > 
> > The following patch fixes the problem in our case:
> > 
> > --- a/drivers/spi/spi_imx.c
> > +++ b/drivers/spi/spi_imx.c
> > @@ -407,7 +407,7 @@ static void __maybe_unused
> 
> Please add your Signed-off-by: when sending patches.

It was an RFC only.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110414/6964d77c/attachment.sig>
