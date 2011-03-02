From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Wed,  2 Mar 2011 18:56:57 +0800
Subject: [patch v2 0/3] arm: pmu: support pmu/perf on OMAP4
Message-ID: <1299063420-22203-1-git-send-email-tom.leiming@gmail.com>
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

v2:
	- move cti related code out of perf_event.c
	- introduce .enable_irq and .disable_irq into platform_data
	as suggested by Will.

v1:
       - rebase the patch set against 2.6.38-rc6-next-20110301, fix
       conflicts, which is pointed out by Will Deacon

 arch/arm/include/asm/cti.h    |  177 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pmu.h    |   15 +++-
 arch/arm/kernel/perf_event.c  |   15 +++-
 arch/arm/mach-omap2/dbg44xx.h |   18 ++++
 arch/arm/mach-omap2/devices.c |   83 ++++++++++++++++++-
 5 files changed, 299 insertions(+), 9 deletions(-)

thanks,
--
Lei Ming
