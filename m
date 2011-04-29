From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2011 13:26:25 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1304024836.2513.198.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop>
Message-ID: <201104291326.25634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Benjamin Herrenschmidt wrote:
> > > 
> > > For PCI you can have the flag propagate from the PHB down, for busses
> > > without a bus type (platform) then whoever instanciate them (the
> > > platform code) can set that appropriately.
> > 
> > How can you do that when it changes mid-bus heirarchy?  I'm thinking
> > of the situation where the DRM stuff is on a child bus below the
> > root bus, and the root bus has DMA coherent devices on it but the DRM
> > stuff doesn't.
> 
> But that's not PCI right ? IE. with PCI, coherency is a property of the
> PHB... 

That is my understanding at least, but I'd like to have a confirmation
from the DRM folks.

I believe that the PC graphics cards that have noncoherent DMA mappings
are all of the unified memory (integrated into the northbridge) kind,
so they are not on the same host bridge as all regular PCI devices,
even if they appear as a PCI device.

	Arnd
