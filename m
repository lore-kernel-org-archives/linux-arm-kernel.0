From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Apr 2012 23:08:38 +0200
Subject: [PATCH v4 0/3] ARM: Initial support for Cortex-M3
Message-ID: <20120404210838.GA23126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I rebased the series to 3.4-rc1. Apart from the asm/system.h
disintegration this was trivial and git did it just right for me.

I dropped patch 3 (ARM: force branch instructions to use long distance
encoding) as I don't need that anymore for reasons I didn't try to find
out. With the rework of patch 1 (ARM: protect usage of cr_alignment by
#ifdef CONFIG_CPU_CP15 -> ARM: make cr_alignment read-only #ifndef
CONFIG_CPU_CP15) patch 2 isn't needed anymore, too.

The patches are available via git at

	git://git.pengutronix.de/git/ukl/linux.git cortexm3

I also updated the efm32 branch in the same repository that additionally
contains support for Energymicro's efm32 processor. The patches in this
series were tested on such a machine.

As before interrupt support and Makefile/Kconfig glue are missing. The
former needs some more love as I think it should be possible to
support the Cortex M3's nvic using common/gic.c. I plan to address this
when this series made it into Linus' tree.

See the mails with the respective patches for some more details about
what changed compared to v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
