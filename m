From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Apr 2011 13:29:42 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <87y63vav01.fsf@ti.com>
References: <201103301906.42429.arnd@arndb.de>
	<201103311723.02301.arnd@arndb.de> <87y63vav01.fsf@ti.com>
Message-ID: <201104011329.42191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 March 2011, Kevin Hilman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >
> > But that's the point. The incentive is there for managing the infrastructure
> > within the SoC, but not across SoCs. 
> 
> OK, but the rest of my thread went on to describe how at least a few ARM
> SoC maintainers are actually actively working infrastructure that is
> cross SoC, like runtime PM.  It might start because of an abstraction
> within an SoC family like supporting both SH and SH-mobile, or
> OMAP[12345], but it does sometimes result in not only cross-SoC code but
> cross-platform frameworks.
> 
> Admiteddly, the percentage of ARM SoC developers actively working on
> these common, cross-platform infrastructure layers is rather small, but
> at least it is non-zero. :)    

True, I was oversimplifying. Still, the problem exists that to a large
degree, infrastructure also gets added to platform specific code where it
has no place.

> With that as background, hwmod was never inteded as something to be
> cross-SoC.  If you look at the data that's in an omap_hwmod, it's
> entirely OMAP hardware specific, and mostly focused on power management
> hardware details, register descriptions, feature capabilities etc.  This
> allows the OMAP PM core code to be generalized and work across all SoCs
> in the OMAP family.  But again, it was intended for OMAP PM core code.
> At that level, there really isn't much to share with other SoCs since
> the PM hardware for the various SoC vendors is so "differentiated"
> (a.k.a fsck'd up in extremely different ways.)

There is an important difference between code that knows about board,
soc and platform specific issues ("drivers") and code that manages
these ("infrastructure"). Obviously, any hardware implementation, broadly
speaking, that is different from the other ones needs a driver.

However, the infrastructure for managing multiple drivers should be
written in a way that works for as many similar drivers as possible.

My complaint about the four examples I've given is that they mix the
driver with the infrastructure.

	Arnd
