From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Tue,  1 Mar 2011 21:17:11 +0800
Subject: [PATCH 0/3] arm: support pmu irq routed from CTI
Message-ID: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com>
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


 arch/arm/include/asm/cti.h    |  177 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pmu.h    |   12 +++
 arch/arm/kernel/perf_event.c  |   51 ++++++++++--
 arch/arm/mach-omap2/devices.c |   54 ++++++++++++-
 4 files changed, 286 insertions(+), 8 deletions(-)

thanks,
Ming Lei
