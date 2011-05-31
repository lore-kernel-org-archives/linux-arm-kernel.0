From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Tue, 31 May 2011 10:29:45 +0200
Subject: [PATCH 0/3] clocksource: add db8500 PRCMU timer
Message-ID: <1306830585-9457-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches makes it possible to use the PRCMU timer as clocksource
for the db8500 chip. Previously the Multi Timer Unit (MTU) was used alone
but the MTU block loose power during sleep states so an alternate
clocksource is needed.
These patches also adds a configuration option to use either the MTU or the PRCMU
as the sched_clk.

Mattias Wallin (3):
  plat-nomadik: MTU sched_clock as an option
  clocksource: add DB8500 PRCMU Timer support
  mach-ux500: add support for clocksource DB8500 PRCMU

 arch/arm/mach-ux500/cpu.c                 |    2 +
 arch/arm/plat-nomadik/Kconfig             |    8 ++-
 arch/arm/plat-nomadik/timer.c             |    4 +
 drivers/clocksource/Kconfig               |   15 +++++
 drivers/clocksource/Makefile              |    1 +
 drivers/clocksource/clksrc-db8500-prcmu.c |   89 +++++++++++++++++++++++++++++
 include/linux/clksrc-db8500-prcmu.h       |   17 ++++++
 7 files changed, 135 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clocksource/clksrc-db8500-prcmu.c
 create mode 100644 include/linux/clksrc-db8500-prcmu.h

-- 
1.7.4.3
