From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun,  6 Dec 2009 11:38:57 +0200
Subject: [PATCH v2 0/2] ep93xx: TS-72xx watchdog driver
Message-ID: <cover.1260089508.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Technologic Systems TS-72xx SBCs (TS-7200, TS-7250 and TS-7260) have
watchdog timer that is implemented in external CPLD chip. This set of
patches provide implementation of watchdog driver for that chip.

This is version 2 of the patches. Changes to initial version are:
	- changed code according to the comments from
	  Ryan Mallon and H Hartley Sweeten
	- added some error printings to probe function

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
 drivers/watchdog/ts72xx_wdt.c              |  516 ++++++++++++++++++++++++++++
 5 files changed, 551 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/ts72xx_wdt.c
