From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Thu,  3 Mar 2011 18:53:50 +0800
Subject: [patch v3 0/3] arm: pmu: support pmu/perf on OMAP4
Message-ID: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
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
