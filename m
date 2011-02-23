From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 16:36:35 +0000
Subject: [PATCH 1/5] ARM: smp: Select local timers vs dummy
	timersupport runtime
In-Reply-To: <e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
	<20110220110341.GA15494@n2100.arm.linux.org.uk>
	<e3674a4c299e3cc0fad3e15a3cc03db4@mail.gmail.com>
Message-ID: <20110223163635.GA16041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 04:37:36PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Sunday, February 20, 2011 4:34 PM
> > To: Santosh Shilimkar
> > Cc: linux-omap at vger.kernel.org; khilman at ti.com; linux-arm-
> > kernel at lists.infradead.org; tony at atomide.com; David Brown; Daniel
> > Walker; Bryan Huntsman; Kukjin Kim; Paul Mundt; Magnus Damm; Colin
> > Cross; Erik Gilling; Srinidhi Kasagar; Linus Walleij
> > Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs dummy
> > timersupport runtime
> >
> > On Sat, Feb 12, 2011 at 04:59:43PM +0530, Santosh Shilimkar wrote:
> > > -#ifndef CONFIG_LOCAL_TIMERS
> > >  static void broadcast_timer_set_mode(enum clock_event_mode mode,
> > >  	struct clock_event_device *evt)
> > >  {
> > >  }
> > >
> > > -static void local_timer_setup(struct clock_event_device *evt)
> > > +static void dummy_timer_setup(struct clock_event_device *evt)
> >
> > Please call this broadcast_timer_setup().
> 
> Right. Will fix this.

Grr.  This conflicts horribly with the Versatile stuff.  Can you recreate
against what currently appears in devel rather than mainline please?
