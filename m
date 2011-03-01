From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Wed,  2 Mar 2011 00:58:28 +0800
Subject: [patch v1 0/3] arm: support pmu irq routed from CTI
Message-ID: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patches support pmu irq routed from CTI, such as implemented
on OMAP4:

       - introduce some CTI helpers and registers' definition
       - introduce platform_data to pmu driver, so perf irq handler
       can handle irq correctly if it is routed from CTI
       - configure CTI on OMAP4 so that perf can work on OMAP4

The patches have been tested Ok on Pandaboard, and 'perf' does work
after applying them.

v1:
	- rebase the patch set against 2.6.38-rc6-next-20110301, fix
	conflicts, which is pointed out by Will Deacon

 arch/arm/include/asm/cti.h    |  177 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pmu.h    |   12 +++
 arch/arm/kernel/perf_event.c  |   57 ++++++++++----
 arch/arm/mach-omap2/dbg44xx.h |   18 ++++
 arch/arm/mach-omap2/devices.c |   55 +++++++++++++-

thanks,
--
Lei Ming
