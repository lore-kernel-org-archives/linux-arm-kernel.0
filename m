From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 18 Apr 2011 10:00:11 +0300
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110418064838.GE12272@atomide.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
	<20110416130929.GL4423@n2100.arm.linux.org.uk>
	<20110418064838.GE12272@atomide.com>
Message-ID: <1303110011.2062.7.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-18 at 09:48 +0300, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110416 16:06]:
> > On Sat, Apr 16, 2011 at 09:01:26PM +0800, Haojian Zhuang wrote:
> > > On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
> > > >
> > > > This uses the physical address, and unlike Davinci's dma address usage,
> > > > it always wants to have the physical address, and will always return
> > > > the corresponding physical address when passed that pointer.
> > > >
> > > > OMAP could probably do with some more work to make the omapfb and other
> > > > allocations use the sram allocator, rather than hooking in before the
> > > > sram allocator is initialized - and then further cleanups so that we
> > > > have an initialization function which just does
> 
> I think we can just remove the omapfb SRAM support for now as it should
> be optional. That will then leave out that dependency and can be added
> back once we have a common framework in place.
> 
> Tomi do you see any problems with that?

I agree. Only OMAP2 has enough SRAM to possibly have a framebuffer
there, and even on OMAP2 the SRAM size is so small that it works only
for rather small displays. I'm not aware of anyone using omapfb's SRAM
support.

The SRAM support also makes our video ram allocator and omapfb more
complex, without much benefit, so I'm more than happy to remove it
totally. Additionally, I believe there is work going on with memory
allocators that omapfb could also use, and migrating to any new mem
allocator will no doubt be much easier if we just handle normal RAM.

So, I can make a patch that removes the SRAM support from omapfb, and
queue it up for the next merge window.

 Tomi
