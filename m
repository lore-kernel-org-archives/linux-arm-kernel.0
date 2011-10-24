From: ming.lei@canonical.com (ming.lei at canonical.com)
Date: Mon, 24 Oct 2011 22:45:52 +0800
Subject: [PATCH v5 0/7] arm: pmu: support pmu/perf on OMAP4
Message-ID: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patches support pmu irq routed from CTI, such as implemented
on OMAP4:

	- introduce some CTI helpers and registers' definition
	- introduce .enable_irq and .disable_irq into platform_data,
	so perf irq handler can handle irq correctly if it is routed
	from CTI on OMAP4
	- configure CTI on OMAP4 so that perf can work on OMAP4

The patches have been tested Ok on Pandaboard, and 'perf' does work
after applying them.

v5:
	- build pmu device from hwmod
	- support runtime pm

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
 arch/arm/kernel/perf_event.c               |   20 +++-
 arch/arm/kernel/pmu.c                      |   12 ++-
 arch/arm/mach-omap2/devices.c              |  126 +++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 ++++
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 7 files changed, 367 insertions(+), 14 deletions(-)

thanks,
--
Lei Ming
