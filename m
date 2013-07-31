From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 31 Jul 2013 10:18:41 -0400
Subject: [ARM ATTEND] arch/arm SoC organization
Message-ID: <20130731141841.GP5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I'd like to take the opportunity to discuss the layout/config of the arm
SoCs.  By the time the KS rolls around, we should have at least two or more
use-cases to present and discuss (mvebu, bcm).

Between devicetree and multiplatform the concept of board-specific code
is really disappearing in arm-land.  eg mach-kirkwood/ is almost fully
converted, within the next window or two, we'll be moving all of the DT
capable boards from kirkwood, orion5x, and dove over to mvebu.
mach-mvebu will then hold 5 different SoCs (it already has Armada 370
and Armada XP).

mach-bcm is in a similar situation (multi-SoC).  I'm sure there are
others (nvidia, ti, etc).

So, I'd like to propose we discuss some lessons learned and maybe arrive
at some best practices.  eg, should we just go with mach-$COMPANY/?  How
best to handle config symbols for efficient building?  Deprecation path
for legacy (unconverted) boards?

Also, to head off the demons, I am *not* proposing reorganizing
everything.  Merely to find some consensus and good ideas so that as
things merge together, we are mostly on the same page.

I'm sure we all have different ideas and I think it'd be good to hear
what everyone else is thinking.

thx,

Jason.
