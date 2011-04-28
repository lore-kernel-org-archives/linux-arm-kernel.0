From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 19:15:02 +0100
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <1304009792.3081.8.camel@redbox>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
	<1304009792.3081.8.camel@redbox>
Message-ID: <20110428181502.GE17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 06:56:32PM +0200, Andrew Victor wrote:
> hi,
> 
> > > And that's another reason to say no to this.  Please stop inventing new
> > > ways to do things unless you're prepared to provide it as a replacement
> > > for all the (ARM) platforms we have in the kernel.
> > Personally I do not change the current arm way
> > 
> > I init the timer during system_timer->init
> > 
> > I just the the early device their to pass the resources
> > but if switch all arm timer this way is fine to you I'm ready to do the whole
> > update
> 
> Well, attached is a simpler way of passing the base-address to the timer
> drivers.  It will solve the timer issues with a single kernel supporting
> multiple AT91 processors.
> 
> I think it would be cleaner still if the "struct sys_timer" could
> include a register-base-address field.  Russell?

That's not really what all platforms want, and with the advent of
clocksources and clock events, I think the sys_timer thing is mostly
dead.

I've been thinking about killing it off for a while for those platforms
using the GENERIC_CLOCKEVENTS stuff.  From what I can see, the only
real users of it are: acorn (riscpc), at91x40, clps711x, ebsa110,
ep93xx, h720x, ixp2000, ixp23xx, ks8695, nuc93x, pnx4008, and samsung.

It would be nice to get the modern stuff out of that converted to the
clockevents/clocksource stuff - any chance of that happening for
AT91x40?
