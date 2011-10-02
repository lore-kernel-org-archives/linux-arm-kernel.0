From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 2 Oct 2011 15:08:43 +0200
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain framework
	for EXYNOS4210
In-Reply-To: <20111002114811.GU11710@n2100.arm.linux.org.uk>
References: <4E4360B2.2060508@samsung.com> <201110021347.02146.rjw@sisk.pl>
	<20111002114811.GU11710@n2100.arm.linux.org.uk>
Message-ID: <201110021508.44083.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 01:47:01PM +0200, Rafael J. Wysocki wrote:
> > On Sunday, October 02, 2011, Kukjin Kim wrote:
> > > Hmm... Even though each driver cannot know the given situation, the driver
> > > can know each own clock should be alive or not. I think, if clock gating
> > > (enable, disable clock) is required, it should be handled in each driver. In
> > > addition, the clock and power are not always one-on-one match.
> > 
> > If the driver is to be portable and there's no guarantee that the
> > clocks configuration on all systems it's supposed to be working with will
> > always be the same, the driver shouldn't handle clocks directly.
> 
> How do these misconceptions start?
> 
> The clock API.  Drivers are supposed to get a clock (source) when they
> initialize.  Drivers then enable and disable the clock as they _themselves_
> require the use of that clock.

OK

Now think of a driver that should handle the same device on both ARM and
x86-based SoCs.  Is the clock API available on x86?

> The clock enable is counted such that if there is at least one user of
> the clock, it will be enabled.  It is not a forced 'off' when disable is
> called - the number of enable calls must be balanced by the same number
> of disable calls for the clock itself to be disabled.
> 
> Drivers are _expected_ to do this themselves.  Or the runtime PM stuff
> if that's what they're doing.

That I can agree with.

Thanks,
Rafael
