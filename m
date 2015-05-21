From: mwelling@ieee.org (Michael Welling)
Date: Wed, 20 May 2015 21:07:09 -0500
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150512191758.GX3066@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
Message-ID: <20150521020709.GA14258@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 08:17:58PM +0100, Mark Brown wrote:
> On Tue, May 12, 2015 at 12:38:57PM -0500, Michael Welling wrote:
> > GPIO chip select patch series appears to have broken the native chip select
> > support. This patch pulls the manual native chip select toggling out of
> > the transfer_one routine and adds a set_cs routine.
> 
> Applied, thanks

It appears that in haste, this fix for the native cs support broke
the GPIO chip select support that I was originally shooting for.

[    2.653658] mcp23s08 spi1.1: TXS timed out
[    2.657961] mcp23s08 spi1.1: SPI transfer failed: -5
[    2.663305] spi_master spi1: failed to transfer one message from queue
[    2.670172] mcp23s08 spi1.1: can't setup chip 64, --> -5
[    2.675784] GPIO chip mcp23s08: gpiochip_unexport: status -19

My guess is that the set_cs needs to be called even when toggling as GPIO.

How should I handle this?
