From: adrian.hunter@nokia.com (adrian.hunter at nokia.com)
Date: Thu, 7 Jan 2010 08:59:35 +0100
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Message-ID: <1262851175.3933.5.camel@Nokia-N900-51-1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Venkatraman S wrote:
> On Wed, Jan 6, 2010 at 6:46 PM, Adrian Hunter <adrian.hunter at nokia.com<mailto:adrian.hunter@nokia.com>>
> wrote:
> > Venkatraman S wrote:
> > >
> > > On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony at atomide.com<mailto:tony@atomide.com>>
> wrote:
> > > >
> > > > * Venkatraman S <svenkatr at ti.com<mailto:svenkatr@ti.com>> [091211 07:01]:
> > > > >
> > > > > Here is the most updated version of the patch (thanks to Russell's
> > > > > review). This patch is applicable to OMAP4xxx as well as OMAP3630
> > > > > Reference to previous posts
> > > > > v1  http://marc.info/?l=linux-omap&m=125012097403050&w=2
> > > > > v2  http://marc.info/?l=linux-omap&m=125137152606644&w=2
> > > > > v3  http://patchwork.kernel.org/patch/45408/
> > > >
> > > > Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
> > > > use this feature? Or some other driver?
> > > >
> > > > Regards,
> > > >
> > > > Tony
> > >
> > > I am about to start working on omap_hsmmc to use the descriptor load
> > > feature. If the DMA changes are acceptable, I can post the driver
> > > patch as well.
> >
> > I presume this is about performance.  How does it compare to chained
> DMA?
> > We have a patch for omap_hsmmc for chained DMA that we are still
> testing.
> >
>  The main difference would be the number of logical channels used.
> With chaining, I assume you'd request for (or the API internally
> reserves) as many logical channels as there are segments. Here a
> single logical channel would do.
>

How does the performance compare? Which is faster? Does descriptor autoloading reduce the number of interrupts?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100107/02eb339e/attachment-0001.htm>
