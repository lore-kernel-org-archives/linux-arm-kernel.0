From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Aug 2011 15:45:53 +0200
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110819085647.GA2046@arm.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<20110819064356.GC12527@S2100-06.ap.freescale.net>
	<20110819085647.GA2046@arm.com>
Message-ID: <201108191545.54223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011, Dave Martin wrote:
> > > +static void __init highbank_map_io(void)
> > > +{
> > > +   unsigned long base;
> > > +
> > > +   /* Get SCU base */
> > > +   asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> > > +
> > > +   highbank_io_desc[0].pfn = __phys_to_pfn(base);
> > > +   iotable_init(highbank_io_desc, ARRAY_SIZE(highbank_io_desc));
> > > +}
> > > +
> > It's a great demo that we can get this base address from CA9 itself.
> > However I'm wondering if we have to do so, since this address should
> > be known for given SoC.  Can we put this known base into device tree
> > and map it when needed?  In that case, we can save another static
> > mapping.
> 
> Since device tree is mainly about providing data to describe system
> components that are not discoverable, maybe it is better after all
> not to put this address in the device tree.
> 
> Discovery feels like the best approach, where possible.

It's a bit silly to leave it out of the device tree when you otherwise
describe all major components.

However, I agree that if you can probe the value from hardware,
there is no need to read it from there.

	Arnd
