From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu,  3 Jan 2013 16:25:08 +1300
Subject: [PATCH 0/2] Move some mach-vt8500 functions to new directories
Message-ID: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches move the irq and clocksource code out of mach-vt8500
and into drivers/irqchip and drivers/clocksource respectively.

Because they affect the same files in mach-vt8500 I thought it may be
easier if it goes through arm-soc, but I note Thomas is the maintainer for
both irqchip and clocksource so maybe he wants to take both.

CC: John Stultz <johnstul@us.ibm.com>
CC: Thomas Gleixner <tglx@linutronix.de>

Tony Prisk (2):
  timer: vt8500: Move system timer to clocksource
  irqchip: vt8500: Move irq code to drivers/irqchip

 arch/arm/mach-vt8500/Kconfig       |    1 +
 arch/arm/mach-vt8500/Makefile      |    2 +-
 arch/arm/mach-vt8500/common.h      |   12 +-
 arch/arm/mach-vt8500/irq.c         |  253 ------------------------------------
 arch/arm/mach-vt8500/timer.c       |  184 --------------------------
 arch/arm/mach-vt8500/vt8500.c      |    4 -
 drivers/clocksource/Kconfig        |    3 +
 drivers/clocksource/Makefile       |    1 +
 drivers/clocksource/vt8500_timer.c |  187 ++++++++++++++++++++++++++
 drivers/irqchip/Makefile           |    1 +
 drivers/irqchip/irq-vt8500.c       |  253 ++++++++++++++++++++++++++++++++++++
 11 files changed, 454 insertions(+), 447 deletions(-)
 delete mode 100644 arch/arm/mach-vt8500/irq.c
 delete mode 100644 arch/arm/mach-vt8500/timer.c
 create mode 100644 drivers/clocksource/vt8500_timer.c
 create mode 100644 drivers/irqchip/irq-vt8500.c

-- 
1.7.9.5
