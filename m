From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 9 Jul 2011 14:30:22 +0800
Subject: [PATCH v3 0/3] Add device tree probe for imx/mxc gpio
In-Reply-To: <20110708183832.GB9070@ponder.secretlab.ca>
References: <1309970263-13239-1-git-send-email-shawn.guo@linaro.org>
	<20110707192705.GL2824@ponder.secretlab.ca>
	<20110708103622.GF26347@pengutronix.de>
	<20110708183832.GB9070@ponder.secretlab.ca>
Message-ID: <20110709063021.GC13962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 12:38:32PM -0600, Grant Likely wrote:
> On Fri, Jul 08, 2011 at 12:36:22PM +0200, Sascha Hauer wrote:
> > On Thu, Jul 07, 2011 at 01:27:05PM -0600, Grant Likely wrote:
> > > On Thu, Jul 07, 2011 at 12:37:40AM +0800, Shawn Guo wrote:
> > > > The first patch removes the uses of cpu_is_mx(), the second one
> > > > changes mxc gpio number macro, and the third one adds actual device
> > > > tree probe support.
> > > > 
> > > > Changes since v2:
> > > >  * Keep platform case gpio range code path unchanged, and get range
> > > >    from gpio core only for dt case.
> > > > 
> > > > Changes since v1:
> > > >  * Address review comments given by Grant and Sascha
> > > >  * Add patch #1 to get gpio range/base from gpio core
> > > > 
> > > > Shawn Guo (3):
> > > >       gpio/mxc: get rid of the uses of cpu_is_mx()
> > > >       ARM: mxc: use ARCH_NR_GPIOS to define gpio number
> > > >       gpio/mxc: add device tree probe support
> > > 
> > > Sascha; so are we good?  Should I merge this series?
> > 
> > These patches neither fit onto your gpio tree nor on the i.MX tree. I
> > suggest that we give these patches a rest until both trees are merged.
> > 
> > That's the downside of moving core drivers to drivers/ and thus to
> > different maintainers, but I think things will become better once
> > the actual move is completed.
> 
> It's a trivial conflict though.  I've gone ahead and picked up this

There is conflict because I based the series off linux-next.  I
checked the code and I think the conflict was resolved correctly.

> series and pushed it out to gpio/next.  Shawn, please test the
> gpio/next branch and make sure there aren't any regressions.  I've
> only done a bit of build testing.
> 

There is no problem was seen with my testing.

-- 
Regards,
Shawn
