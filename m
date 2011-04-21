From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Apr 2011 16:52:50 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110421114220.GJ13688@atomide.com>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110421103117.GB16776@sirena.org.uk>
	<20110421114220.GJ13688@atomide.com>
Message-ID: <alpine.LFD.2.02.1104211651540.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Tony Lindgren wrote:

> * Mark Brown <broonie@opensource.wolfsonmicro.com> [110421 03:29]:
> > On Thu, Apr 21, 2011 at 11:12:36AM +0200, Thomas Gleixner wrote:
> > > On Thu, 21 Apr 2011, Uwe Kleine-K?nig wrote:
> > 
> > > > If there were a pointer tracking the parent you still needed to program
> > > > out the get_parent function anyhow to set the pointer initially. But I
> > > > agree that in other situations having a pointer is more comfortable and
> > > > saves ugly error handling e.g. in set_parent.
> > 
> > > That's nonsense. Why do you want a get_parent() function at all?
> > > parent is set up when the clock is established in the clock tree. And
> > > that's not done by some random driver. That's a property of the clock.
> > 
> > That's not universal - right now the drivers can and do know about this
> > on some platforms.  In some cases there will be requirements beyond the
> > clock rate which mean that the driver will need to be able to tell the
> > framework that, for example, it needs one clock to be in the same clock
> > domain as another.
> 
> Also there can be multiple parent clocks. An example are the timers on
> omaps where the parent clock can be either the 32KiHz clock or external
> source clock. ?his may need to be reprogrammed dynamically in some cases
> for advanced idle modes as one of the parent clocks may be shut down.

If you need to propagate from bottom up, then you need a list of
childs in struct clk. Right ?

Thanks,

	tglx
