From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 18 Jan 2013 12:40:10 +0100
Subject: [PATCH 0/4] add ux500_wdt support
Message-ID: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this set adds support for the ux500_wdt timer, implemented in the PRCMU
unit of ST-Ericsson ux500 architecture.

The first two patches add the necessary definitions and function export
to the PRCMU driver currently in mainline, while the third an fourth
patches add the actual watchdog driver and mfd_cell definition to make
it probe when PRCMU is compiled in.

As the patches touches files in both mfd and watchdog subsystems, what do
you think is the best way to handle this set?

Thanks,
Fabio


Fabio Baltieri (4):
  mfd: dbx500-prcmu: add watchdog ID definitions
  mfd: dbx500-prcmu: export a9wdog functions
  watchdog: add support for ux500_wdt watchdog
  mfd: db8500-prcmu: add ux500_wdt mfd_cell

 drivers/mfd/db8500-prcmu.c              |  17 ++++
 drivers/watchdog/Kconfig                |  12 +++
 drivers/watchdog/Makefile               |   1 +
 drivers/watchdog/ux500_wdt.c            | 171 ++++++++++++++++++++++++++++++++
 include/linux/mfd/dbx500-prcmu.h        |  12 +++
 include/linux/platform_data/ux500_wdt.h |  19 ++++
 6 files changed, 232 insertions(+)
 create mode 100644 drivers/watchdog/ux500_wdt.c
 create mode 100644 include/linux/platform_data/ux500_wdt.h

-- 
1.7.12.1
