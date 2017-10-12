From: tpiepho@impinj.com (Trent Piepho)
Date: Thu, 12 Oct 2017 20:41:07 +0000
Subject: [2/2] spi: imx: fix use of native chip-selects with devicetree
In-Reply-To: <209bb901-875e-8007-06f8-3ae9698a0e41@linux-m68k.org>
References: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <1507667916.74283.19.camel@impinj.com>
 <209bb901-875e-8007-06f8-3ae9698a0e41@linux-m68k.org>
Message-ID: <1507840866.3880.4.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-12 at 16:26 +1000, Greg Ungerer wrote:
> On 11/10/17 06:38, Trent Piepho wrote:
> > 
> > arch/arm/mach-imx/mach-mx31moboard.c-static int moboard_spi1_cs[] = {
> > arch/arm/mach-imx/mach-mx31moboard.c:   MXC_SPI_CS(0),
> > arch/arm/mach-imx/mach-mx31moboard.c:   MXC_SPI_CS(2),
> > arch/arm/mach-imx/mach-mx31moboard.c-};
> > 
> > The spi device configured to use chip select 1 will no longer use
> > native chip select line 2.
> > 
> > Looking at all in-tree users of spi imx platform data, it appears that
> > this board is the only one in which the cs selected does not match the
> > array index.  Though there are still several which still use
> > MSC_SPI_CS() even though it doesn't really work anymore.
> 
> Commit 901f26bce64a ("ARM: imx: set correct chip_select in platform setup") 
> fixes this issue. It specifically makes sure that the board setup chip
> select is set correctly (so that spi-imx can then use it). It also pads
> out the chipselect arrays so that the chip select and indexes match.
> 
> Is this not working for you?

It looks like that patch missed one spi bus in mx31moboard.c, quoted
above.

I have a patch series that should fix that and also the documentation. 
Need to test it a bit more.
