From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 10:39:56 +0200
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <20130405212143.GA16221@obsidianresearch.com>
References: <20130405150200.7b6dee63@skate> <201304052301.27231.arnd@arndb.de>
 <20130405212143.GA16221@obsidianresearch.com>
Message-ID: <201304061039.56241.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2013 at 11:01:27PM +0200, Arnd Bergmann wrote:
> 
> > >  - The bridge ranges would be offset 0 length 4G-1 in the DT since
> > >    the value is not known. However firmware could do PCI address
> > >    assignment and fill in corrected values.
> > 
> > I don't undestand this part. It would make the topmost byte in the
> > 4GB bus space unadressable, which seems strange. Why can't we use
> > the entire 4GB? Maybe we should leave at least a page?
> 
> Oh, sorry, that was just a mostly arbitary hacky choice to fit within
> 1 size cell. Using 2 size cells requires an upgrade to skeleton64 for
> all mvebu platforms, eg kirkwood.
> 
> Realistically this size should never be used so it doesn't matter if
> it is 4G or 4G-1 - though obviously 4G is preferred in cases where
> size cells is 2. :)

But the PCI bus already is required to have #size-cells=<2>, and
we would only use this in the ranges property of the PCI node, right?

> So.. I don't think it matters today for mvebu, but something to think
> about - shuffling the firmware's address map could be dangerous.

I would at least expect a secure-mode firmware to prevent the OS
from changing any mappings that the firmware relies on, but I see
what you mean.

	Arnd
