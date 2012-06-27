From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jun 2012 20:30:39 +0100
Subject: [PATCH 1/4] mtd: lpc32xx_slc: Select AMBA_PL08X in Kconfig
In-Reply-To: <CAAAP30Fdr2_tcgMYjCirVPCPTtrUgbeMb=7j=69wGtvJeiLsOA@mail.gmail.com>
References: <1340812275-1197-1-git-send-email-stigge@antcom.de>
 <20120627191542.GC25319@n2100.arm.linux.org.uk>
 <CAAAP30Fdr2_tcgMYjCirVPCPTtrUgbeMb=7j=69wGtvJeiLsOA@mail.gmail.com>
Message-ID: <20120627193039.GF25319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 04:26:18PM -0300, Alexandre Pereira da Silva wrote:
> On Wed, Jun 27, 2012 at 4:15 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jun 27, 2012 at 05:51:12PM +0200, Roland Stigge wrote:
> >> From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> >>
> >> Since this driver depends on the amba pl08x dma driver, select it in Kconfig.
> >>
> >> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> >> Signed-off-by: Roland Stigge <stigge@antcom.de>
> >> ---
> >> ?drivers/mtd/nand/Kconfig | ? ?1 +
> >> ?1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> >> index de69978..a9e8b73 100644
> >> --- a/drivers/mtd/nand/Kconfig
> >> +++ b/drivers/mtd/nand/Kconfig
> >> @@ -417,6 +417,7 @@ config MTD_NAND_PXA3xx
> >> ?config MTD_NAND_SLC_LPC32XX
> >> ? ? ? tristate "NXP LPC32xx SLC Controller"
> >> ? ? ? depends on ARCH_LPC32XX
> >> + ? ? select AMBA_PL08X
> >> ? ? ? help
> >> ? ? ? ? Enables support for NXP's LPC32XX SLC (i.e. for Single Level Cell
> >> ? ? ? ? chips) NAND controller. This is the default for the PHYTEC 3250
> >
> > Surely not? ?Drivers using DMA engine really should not depend on any
> > particular DMA engine implementation.
> 
> Should the DMA code in this driver be ifdef'd like in spi-pl022.c?
> 
> Or just depend on DMA_ENGINE instead?

Well, the DMA engine API gets stubbed out when no DMA engine is selected,
so I'm not sure why spi-pl022 needs all those ifdefs (yes, you may wish
to do that if you want to shrink your driver private struct size.)

Provided the driver is capable of working without DMA engine, I don't see
any reason what so ever to make that driver select or depend on DMA engine
stuff.
