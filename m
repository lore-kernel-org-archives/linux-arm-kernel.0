From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 11:00:12 +0100
Subject: [PATCH 0/4] Add a generic struct clk
In-Reply-To: <20110710095013.GZ4812@n2100.arm.linux.org.uk>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.325655.313573683829.0.gpush@pororo>
	<20110710090927.GA23445@opensource.wolfsonmicro.com>
	<20110710095013.GZ4812@n2100.arm.linux.org.uk>
Message-ID: <20110710100012.GA4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 10:50:13AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jul 10, 2011 at 06:09:30PM +0900, Mark Brown wrote:
> > On Fri, May 20, 2011 at 03:27:49PM +0800, Jeremy Kerr wrote:
> > > [This series was originally titled 'Add a common struct clk', but
> > > the goals have changed since that first set of patches. We're now aiming
> > > for a more complete generic clock infrastructure, rather than just
> > > abstracting struct clk]
> 
> ... which will mean the platforms at the simpler end of the spectrum
> will ignore it because it'll be far too heavy weight for them.
> 
> If we're going to do something generic with it, then we need something
> that _can_ scale from damned simple right up to OMAP-type complex.  We
> don't want to start with something OMAP-type complex and have everyone
> use it even for just one or two (or even 30 simple enable/disable
> non-tree like) clocks.  And those platforms should not have to have
> several K of unused code in their kernel because of it.
> 
> Otherwise, we'll just end up going back to people trying to directly
> access clock mask registers from drivers.

And... btw... I'm getting the impression that clk API stuff is being done
behind my back, with decisions on the direction being taken in closed room
scenarios - maybe because I objected fairly strongly to the previous set
of patches.

I hope I'm wrong, but that's the impression I now have, based upon where
the discussion got to last time around and the quoted part of Jeremy's
mail (which is all I have to go on.)
