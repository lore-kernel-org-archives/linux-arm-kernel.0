From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 14 Apr 2011 20:36:13 +0200
Subject: i.MX27 SPI tx fifo underrun
In-Reply-To: <io73tm$1e5$1@dough.gmane.org>
References: <io73tm$1e5$1@dough.gmane.org>
Message-ID: <20110414183613.GH3811@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 05:29:57PM +0200, Jurgen Braam wrote:
> while trying to write to an at25 eeprom connected via SPI on an
> i.MX27, I ran into a TX FIFO underrun. In spi_imx_isr() the variable
> spi_imx->txfifo gets rather large as a result of an unsigned integer
> underflow, resulting in a feels-like-endless loop.
> 
> The following patch fixes the problem in our case:
> 
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -407,7 +407,7 @@ static void __maybe_unused

Please add your Signed-off-by: when sending patches.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
