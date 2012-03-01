From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Mar 2012 15:31:01 -0800
Subject: [GIT PULL 3/5] First set of omap1 related changes
In-Reply-To: <3378572.m1z82NvySs@acer>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de>
 <201202292106.40731.arnd@arndb.de>
 <20120229211331.GP18901@atomide.com> <3378572.m1z82NvySs@acer>
Message-ID: <20120301233101.GC18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120301 13:56]:
> 
> Any chance for the continuation series [1] as well as two section 
> mismatch related fixes [2] [3] getting your attention? NB, that 
> continuation series needs another section mismatch fix, which I was 
> planing to submit once there was a stable base for it.
> 
> [1] http://www.spinics.net/lists/linux-omap/msg64146.html
> [2] http://www.spinics.net/lists/linux-omap/msg64441.html
> [3] http://www.spinics.net/lists/linux-omap/msg64442.html

Hmm sorry I guess I was waiting for the missing section
mismatch patch.

I've pushed ams-delta branch that's based on -rc5 merged
with what Arnd pulled yesterday as -rc1 has i2c-omap.c
a compile bug for omap1. I've applied these two patches
there as the second one depends on what got pulled:

ARM: OMAP1: ams-delta: clean up init data section assignments
ARM: OMAP1: ams-delta: fix incorrect section tags

Looks like your patch "ARM: OMAP1: ams-delta: set up regulator
over modem reset GPIO pin" causes the following error with
CONFIG_DEBUG_SECTION_MISMATCH=y:

arch/arm/mach-omap1/board-ams-delta.c:273:36: error:
modem_nreset_config causes a section type conflict

So care to update and repost that (and possibly the following
two patches) with your missing fixes?

Regards,

Tony
