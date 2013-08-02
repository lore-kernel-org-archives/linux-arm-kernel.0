From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 01:33:46 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] arch/arm SoC organization
In-Reply-To: <20130731141841.GP5882@titan.lakedaemon.net>
References: <20130731141841.GP5882@titan.lakedaemon.net>
Message-ID: <20130802083346.GC7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [130731 07:25]:
> All,
> 
> I'd like to take the opportunity to discuss the layout/config of the arm
> SoCs.  By the time the KS rolls around, we should have at least two or more
> use-cases to present and discuss (mvebu, bcm).
> 
> Between devicetree and multiplatform the concept of board-specific code
> is really disappearing in arm-land.  eg mach-kirkwood/ is almost fully
> converted, within the next window or two, we'll be moving all of the DT
> capable boards from kirkwood, orion5x, and dove over to mvebu.
> mach-mvebu will then hold 5 different SoCs (it already has Armada 370
> and Armada XP).
> 
> mach-bcm is in a similar situation (multi-SoC).  I'm sure there are
> others (nvidia, ti, etc).

Well we've pretty much always kept the omaps we can build together in
the same directory, otherwise we would be up to an insane number of
mach-omap related directories by now.. I think getting rid of the
mach- and plat- directories and making everything into drivers is
the next phase after device tree conversion is done.

> So, I'd like to propose we discuss some lessons learned and maybe arrive
> at some best practices.  eg, should we just go with mach-$COMPANY/?  How
> best to handle config symbols for efficient building?  Deprecation path
> for legacy (unconverted) boards?

A lot of that problem goes away by initializing everything as late
as possible, and making things to live under drivers. Of course it
may make sense to combine things meanwhile, but renaming things causes
quite a bit of churn.
 
> Also, to head off the demons, I am *not* proposing reorganizing
> everything.  Merely to find some consensus and good ideas so that as
> things merge together, we are mostly on the same page.
> 
> I'm sure we all have different ideas and I think it'd be good to hear
> what everyone else is thinking.

Yes sharing experiences on this stuff would be good de-briefing and
could help others :)

Regards,

Tony
