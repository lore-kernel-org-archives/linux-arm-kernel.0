From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  3 Dec 2009 21:35:19 +0200
Subject: [PATCH 0/2] ep93xx: TS-72xx watchdog driver
Message-ID: <cover.1259866661.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Technologic Systems TS-72xx SBCs (TS-7200, TS-7250 and TS-7260) have
watchdog timer that is implemented in external CPLD chip. This set of
patches provide implementation of watchdog driver for that chip.

I tested this on TS-7260 board.

Thanks,
MW

Mika Westerberg (2):
  ep93xx: implemented watchdog timer driver for TS-72xx SBCs
  ep93xx: added platform side support for TS-72xx WDT driver

 arch/arm/mach-ep93xx/include/mach/ts72xx.h |    2 +
 arch/arm/mach-ep93xx/ts72xx.c              |   21 ++
 drivers/watchdog/Kconfig                   |   11 +
 drivers/watchdog/Makefile                  |    1 +
 drivers/watchdog/ts72xx_wdt.c              |  458 ++++++++++++++++++++++++++++
 5 files changed, 493 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/ts72xx_wdt.c
