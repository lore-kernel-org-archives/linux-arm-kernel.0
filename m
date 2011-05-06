From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 May 2011 19:47:47 +0100
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <20110506100310.GT11574@pengutronix.de>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110506090449.GA18408@n2100.arm.linux.org.uk>
	<20110506100310.GT11574@pengutronix.de>
Message-ID: <20110506184747.GA3390@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 12:03:10PM +0200, Uwe Kleine-K?nig wrote:
> Hi Russell,
> 
> On Fri, May 06, 2011 at 10:04:49AM +0100, Russell King - ARM Linux wrote:
> > On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> > > I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> > > a flush ARM probably does, too, no?
> > > If so, what it the right thing to do? Implement flush_dcache_range for
> > > ARM (just wrapping flush_dcache_page?)?
> > 
> > On ARM, we assume all new pages have dirty dcache, which allows us to
> > neatly end the ever-increasing quantity of drivers which need to be
> > patched to work on ARM.  PowerPC doesn't do this.
> Unless I'm missing something the cache flushed here isn't necessarily
> for a new page. (And even if the flush isn't needed here for ARM, not
> having flush_dcache_range results in #ifdefs for each user of it. So a
> definition would be nice, wouldn't it?)

Well, the folk introducing it should have added it to cachetlb.txt so
that other folk know what the intentions of it are.  At the moment it
seems to be an unofficial extension with unknown semantics.  Maybe the
PPC folk can clear it up and fix other arches if they wish to make it
an official arch cachetlb extension.
