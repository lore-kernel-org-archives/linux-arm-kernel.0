From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 May 2011 12:03:10 +0200
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <20110506090449.GA18408@n2100.arm.linux.org.uk>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110506090449.GA18408@n2100.arm.linux.org.uk>
Message-ID: <20110506100310.GT11574@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, May 06, 2011 at 10:04:49AM +0100, Russell King - ARM Linux wrote:
> On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> > I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> > a flush ARM probably does, too, no?
> > If so, what it the right thing to do? Implement flush_dcache_range for
> > ARM (just wrapping flush_dcache_page?)?
> 
> On ARM, we assume all new pages have dirty dcache, which allows us to
> neatly end the ever-increasing quantity of drivers which need to be
> patched to work on ARM.  PowerPC doesn't do this.
Unless I'm missing something the cache flushed here isn't necessarily
for a new page. (And even if the flush isn't needed here for ARM, not
having flush_dcache_range results in #ifdefs for each user of it. So a
definition would be nice, wouldn't it?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
