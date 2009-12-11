From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Dec 2009 20:24:55 -0500 (EST)
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <20091210221415.GA19752@n2100.arm.linux.org.uk>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
	<20091210163920.GA13210@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912101529320.31174@xanadu.home>
	<20091210221415.GA19752@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912102024010.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Dec 2009, Russell King - ARM Linux wrote:

> On Thu, Dec 10, 2009 at 04:21:29PM -0500, Nicolas Pitre wrote:
> > On Thu, 10 Dec 2009, Russell King - ARM Linux wrote:
> > 
> > > If it is just ARMv6 which is affected by this (note that we can not rely
> > > upon ID_MMFR3 telling us since this register has a different purpose
> > > there) then we can solve this by just modifying the ARMv6 DMA cache
> > > methods - which becomes easier if I get the rearrangement of the DMA
> > > stuff finally sorted.  The *only* thing that remains in the way of that
> > > is the stupid flush_ioremap_region() crap for just one MTD driver.
> > 
> > My suggestion: kill flush_ioremap_region() and substitute it by an ARMv5 
> > cache range invalidate loop implementation local to that driver.
> > 
> > While at it, here's the patch:
> 
> Great, can it end up in the patch system?

Patch #5848/1.


Nicolas
