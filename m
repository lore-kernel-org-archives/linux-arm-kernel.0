From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Oct 2012 17:48:33 +0000
Subject: [PATCH v2 2/4] zynq: move static peripheral mappings
In-Reply-To: <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
References: <20121022211219.GC31538@beefymiracle.amer.corp.natinst.com>
 <201210231450.11540.arnd@arndb.de>
 <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210231748.33373.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 October 2012, Josh Cartwright wrote:
> On Tue, Oct 23, 2012 at 02:50:11PM +0000, Arnd Bergmann wrote:
> > On Monday 22 October 2012, Josh Cartwright wrote:
> 
> > > diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > > index d0d3f8f..ae3b236 100644
> > > --- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > > +++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > > -#define TTC0_PHYS			0xF8001000
> > > -#define TTC0_VIRT			TTC0_PHYS
> > > +#define TTC0_PHYS		0xF8001000
> > > +#define TTC0_SIZE		SZ_4K
> > > +#define TTC0_VIRT		(UART0_VIRT - TTC0_SIZE)
> > 
> > It's quite likely that this does not have to be a fixed mapping
> > any more. Just have a look at how drivers/clocksource/dw_apb_timer_of.c
> > calls of_iomap() to get the address.
> 
> Yes, this is already on my list of plans.  The in-tree TTC driver
> unfortunately doesn't yet support device tree bindings.  Are you
> comfortable waiting on the DT-ification of the TTC in a follow-up
> patchset?

Yes, that's fine. If you do that, you can also move the driver to
drivers/clocksource in another patch.

	Arnd
