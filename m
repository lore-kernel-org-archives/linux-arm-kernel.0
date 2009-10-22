From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Oct 2009 10:19:33 +0200
Subject: MXC MMC driver and SDIO peripherals
In-Reply-To: <20091021205156.GO14091@buzzloop.caiaq.de>
References: <20091021192038.GK14091@buzzloop.caiaq.de>
	<1256156119.8469.40.camel@localhost.localdomain>
	<20091021205156.GO14091@buzzloop.caiaq.de>
Message-ID: <20091022081933.GC8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 10:51:56PM +0200, Daniel Mack wrote:
> Hi Dan,
> 
> On Wed, Oct 21, 2009 at 01:15:19PM -0700, Dan Williams wrote:
> > On Wed, 2009-10-21 at 21:20 +0200, Daniel Mack wrote:
> > > Hi,
> > > 
> > > we're having trouble getting SDIO connected harware to fly on MX31 based
> > > designs. In particular, a SD8686 chip supported by the libertas_sdio
> > > driver will hang forever when built without CONFIG_MMC_DEBUG=y. With
> > > that option selected, however, the behaviour is a little different, and
> > > I can at least see the following messages on a recent 2.6.32-rc5 based
> > > MX31 tree.
> > > 
> > > Is there any common pitfall for such setups? I did more or less the same
> > > thing on PXAs (same WLAN chip, same kind of interface, same firmware),
> > > and haven't seen any such effects, so I suspect the MXC specific parts
> > > to be the reason for that. Any ideas?
> > 
> > Any idea what quirks your SDHC is using if any?  Does it require PIO or
> > can it do DMA? 
> 
> In mainline kernels, DMA is limited to the MX2 SoC family. The MX3 that
> I'm using is excluded from that feature, but I'mm not aware of the
> reason for that.

The reason is that the i.MX31/35/25 have a so called Smart DMA engine
(SDMA). So far nobody has been smart enough to clean the Freescale code
up for mainline. The original DMA engine this driver works with is
equipped with the i.MX1/21/27 processors.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
