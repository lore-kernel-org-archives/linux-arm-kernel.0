From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Nov 2011 16:48:56 +0000
Subject: PLEASE FIX: lack of trailing , on structure initializers
Message-ID: <20111105164855.GG12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lack of trailing ','s on initializers is causing me quite an amount
of grief while trying to prepare the set of patches for arch_reset.
It's really annoying to add a new initializer at the end of a structure,
not notice the lack of trailing ',' on the last entry, and then end up
having to rework the patches because of that.  E.g.:

arch/arm/mach-orion5x/mv2120-setup.c:238: error: request for member ?restart? in something not a structure or union

caused by the lack of trailing comma for the .fixup initializer on the
preceding line.

We have around 778 of these in arch/arm, and it's about time that number
started to be reduced.  This will cause a lot of conflicts, so the
earlier it can be done in the cycle (and merged into each platform tree)
the less (hopefully) it'll conflict with other work that goes through
the appropriate maintainer tree.
