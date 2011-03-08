From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Tue,  8 Mar 2011 23:38:46 +0800
Subject: [patch v4 0/3] arm: pmu: support pmu/perf on OMAP4 
Message-ID: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patches support pmu irq routed from CTI, such as implemented
on OMAP4:

       - introduce some CTI helpers and registers' definition
       - introduce .enable_irq and .disable_irq into platform_data,
       so perf irq handler can handle irq correctly if it is
       routed from CTI on OMAP4
       - configure CTI on OMAP4 so that perf can work on OMAP4

The patches have been tested Ok on Pandaboard, and 'perf' does work
after applying them.

v4:
	- some minor fix(add __iomem, comments, checkpatch warning...)

v3:
	- fix typo of patch 2/3 title, pointed by Will
	- move cti addresses to plat/omap44xx.h, suggested by
	Santosh Shilimkar

v2:
	- move cti related code out of perf_event.c
	- introduce .enable_irq and .disable_irq into platform_data
	as suggested by Will.

v1:
	- rebase the patch set against 2.6.38-rc6-next-20110301, fix
	conflicts, which is pointed out by Will Deacon

 arch/arm/include/asm/cti.h                 |  179 ++++++++++++++++++++++++++++
 arch/arm/include/asm/pmu.h                 |   15 ++-
 arch/arm/kernel/perf_event.c               |   15 ++-
 arch/arm/mach-omap2/devices.c              |   82 ++++++++++++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +
 5 files changed, 284 insertions(+), 9 deletions(-)


thanks,
--
Lei Ming
