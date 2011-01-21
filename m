From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 21 Jan 2011 11:28:36 +0100
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <20110121101536.GH14956@pengutronix.de>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110121094338.GE13235@n2100.arm.linux.org.uk>
	<20110121101536.GH14956@pengutronix.de>
Message-ID: <20110121102836.GB23596@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:15:36AM +0100, Uwe Kleine-K?nig wrote:

> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  arch/arm/Kconfig          |    1 +
> > >  arch/arm/mach-mxs/gpio.c  |   30 +++++++++++++++---------------
> > >  arch/arm/mach-mxs/icoll.c |   16 ++++++++--------
> > >  3 files changed, 24 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 5cff165..c8d888e 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -364,6 +364,7 @@ config ARCH_MXS
> > >  	select GENERIC_CLOCKEVENTS
> > >  	select ARCH_REQUIRE_GPIOLIB
> > >  	select CLKDEV_LOOKUP
> > > +	select GENERIC_HARDIRQS_NO_DEPRECATED
> > 
> > No.  Let's do it architecture wide otherwise we're going to get into
> > problems working out what's been done and what hasn't.  By all means
> > use it as a way of ensuring that your platform is converted, but don't
> > submit patches with this in.
>
> OK.
>  
> > I thought the point of Lennert's patches were to convert everyone over,
> > so it should just be those trees which weren't merged at that point who
> > are missing the fixup.
>
> Yes, but he missed mxs, probably because the tree he based his work on
> doesn't contain it yet.
> 
> > We'll set this architecture wide for 2.6.39, and I'll see about queueing
> > it soon so that we catch those places which haven't been done.  That
> > should allow the remainder to be caught.
>
> IMHO doing it the other way round would be better.  (i.e. use a def_bool
> y for the unconverted platforms and then push that down.)  But maybe
> this is just a matter of taste.
> 
> How should we proceed?  Lennert, do you take my patch?  Should I resend
> without the select?  IIRC there were send a few other patches (for tegra
> maybe?).  Don't know if you missed these, too?

I agree with rmk and think that we should just set
GENERIC_HARDIRQS_NO_DEPRECATED globally (i.e. ARM-wide) at some point,
and fix up the few remaining old-style users at that point.

The bulk of the work has been done now, and any further irq_data
conversions that need to be done can be done in a minute or so each,
probably on par with the time it would take to patch Kconfig to
indicate which platforms have been converted and which haven't, so
we might as well just spend that time on doing the conversion.


thanks,
Lennert
