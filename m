From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 06:50:42 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <4DB8F140.4030302@codeaurora.org>
References: <20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
	<20110428024559.GK29103@game.jcrosoft.org>
	<20110428030817.GC13539@linux-sh.org>
	<20110428031704.GL29103@game.jcrosoft.org>
	<20110428033808.GE13539@linux-sh.org>
	<20110428043143.GP29103@game.jcrosoft.org>
	<4DB8F140.4030302@codeaurora.org>
Message-ID: <20110428045042.GA3852@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:46 Wed 27 Apr     , Saravana Kannan wrote:
> On 04/27/2011 09:31 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 12:38 Thu 28 Apr     , Paul Mundt wrote:
> >>On Thu, Apr 28, 2011 at 05:17:04AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>On 12:08 Thu 28 Apr     , Paul Mundt wrote:
> >>>>This is a non-argument until you demonstrate a use case where we have a
> >>>>reasonable expectation for the clock framework to be available and the
> >>>>slab allocator not.
> >>>>
> >>>>If you're thinking about the SH earlyprintk case then I suggest you look
> >>>>at the sh-sci driver to see how we presently deal with the situation
> >>>>there.
> >>>the sh-sci driver expect the clock will enable for him
> >>>which did IIRC Magnus on sh-mobile
> >>>I do not want to do so
> >>>
> >>>I've unfortunatly on at91 I use the early device during the map_io
> >>>
> >>>so the slab is available and bootmem either
> >>>
> >>Yes, on sh-sci we assume that the clock is supplied to the port that we
> >>are using for earlyprintk and we simply take over management of it via
> >>the clock framework when the rest of the driver core comes online.
> >>
> >>Oddly enough, 100% of the time that we've wanted to have a serial console
> >>it's been on the same port as the boot loader, which has to do the
> >>initialization anyways. If you're using JTAG or something else for
> >>loading, you've already got to do register writes for setting up bus
> >>timings and the like, so it's not obvious why you can't set up some
> >>sensible defaults for the clock registers supplying your serial port,
> >>either.
> >>
> >>On top of that, ARM also has its own earlyprintk and eartly uart debug
> >>macros available to you. If you're trying to bring more driver core stuff
> >>online before either of slab or bootmem are available to you outside of
> >>the context of the existing functionality: too bad. It's not worth the
> >>world of pain for a corner case of a corner case.
> >>
> >>Again, until you explain concretely why you have this as a real use case
> >>that needs to be solved generically instead of some pointless theoretical
> >>wanking it's simply not possible to take this requirement seriously. This
> >>was the conclusion we came to when modelling the earlytimer and
> >>earlyprintk code for SH in the first place, and the burden of proof is on
> >>you to demonstrate why any of these things are insufficient for your
> >>platform.
> >in the map_io  I need to init the gpio drivers
> 
> Why? Are you under the impression that GPIO is IO and hence needs to
> be mapped by map_io?
because today the at91 configure the serials at that time

Best Regards,
J.
