From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 2 Jun 2011 11:34:31 +0200
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
Message-ID: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Multi Timer Unit (MTU) is currently used as clocksource and sched_clk
for the u8500 machine. The MTU block loose power during cpuidle sleep states
so an alternate clocksource is needed and these patches adds the db8500 PRCMU
timer.

Mattias Wallin (3):
  plat-nomadik: MTU sched_clock as a config option
  clocksource: add DB8500 PRCMU Timer support
  mach-ux500: Initialize the DB8500 PRCMU timer

 arch/arm/mach-ux500/cpu.c                 |    2 +
 arch/arm/plat-nomadik/Kconfig             |    8 ++-
 arch/arm/plat-nomadik/timer.c             |    4 +
 drivers/clocksource/Kconfig               |   15 +++++
 drivers/clocksource/Makefile              |    1 +
 drivers/clocksource/clksrc-db8500-prcmu.c |   90 +++++++++++++++++++++++++++++
 include/linux/clksrc-db8500-prcmu.h       |   17 ++++++
 7 files changed, 136 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clocksource/clksrc-db8500-prcmu.c
 create mode 100644 include/linux/clksrc-db8500-prcmu.h

-- 
1.7.4.3
