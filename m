From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jul 2011 12:20:06 -0000
Subject: Updated mach-types update
In-Reply-To: <201105231839.57083.arnd@arndb.de>
References: <201105231652.28497.arnd@arndb.de>
	<20110523151051.GB6489@sirena.org.uk>
	<20110523153326.GB15153@n2100.arm.linux.org.uk>
	<201105231839.57083.arnd@arndb.de>
Message-ID: <20110524020653.GA28118@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 06:39:56PM +0200, Arnd Bergmann wrote:
> On Monday 23 May 2011, Russell King - ARM Linux wrote:

> > Don't get me wrong - 15k LOC removal is a good start, but it's just that,
> > a start.  It's well below what I was hoping for.

> Agreed. The 15k LOC were also partially just the low-hanging fruit, so
> we won't be able to do much larger reductions without doing more
> groundwork first, like the stuff that is going in now (clkdev, irq,
> clksource, device tree, ...).

Indeed.

> We need to do more of those before we see significant reductions from
> being able to remove a lot of the existing board files. At the same
> time, a number of people obviously have new boards that they want to
> see supported. The tactical answer that I'd give to them is that they
> can still add board files, provided that they also help do the work
> that is required to remove them later (depends the specific capabilities
> of the people and the complexity of the code they want to add).

This should also be really helpful for getting people to actually work
on the infrastructure.  If we're just telling anyone working on actual
systems on ARM to go away then we're creating additional barriers to
working with the improved infrastructure and reducing the visibility the
community has of what's going on, pushing people back into BSP land
which really isn't where we want things to be going.

It's also coming back to the thing I was saying when this approach was
originally announced - if we're just telling people that there's no way
they can work with mainline until some non-specific set of generic ARM
improvements has been done that's really not going them anything
concrete they can work with.  The work that needs doing is both open
ended and long term, it's not something with any end in sight and it
requires a good degree of comfortability with working with tree wide
changes.  That's tough and it seems more likely to put people off than
to stimulate new contributors.

If we can give people specific feedback on their code that they can
directly address that's entirely reasonable.  Saying things like "your
code isn't up to standard, you should be doing this other thing" or
"this thing you're doing is actually pretty generic, you should submit
some infrastructure for it then build on top of that" gives people a
clear thing they can actually do that they can relate to the work
they're doing.  Saying that we're not going to be accepting any support
for new hardware into Linux for the forseeable future is more of an
impenetrable cliff face.

If Linus is pushing back in this way it seems like the thing to do is
push back on him, it seems like we should be able to point to concrete
things that are being done to improve the situation without also stalling
work on new platforms.
