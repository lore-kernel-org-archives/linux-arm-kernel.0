From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 13 Nov 2011 19:09:54 +0100
Subject: [PATCH 0/12] ARM: at91: make
 aic/ccfg/dbgu/dma/ecc/gpio/pit/rtt/smc/watchdog register base soc.h
 independant
Message-ID: <20111113180954.GD15318@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	This patch series start to make all AT91 registers soc independant
	to allow to have all soc compiled together and simplify the adding of
	the DT.

The following changes since commit 28847f302d2173398ee798a9b65924dad6d424ee:

  ARM: at91: drop ARCH_AT91SAM9G20 (2011-11-11 00:31:46 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (12):
      ARM: at91: make gpio register base soc independant
      ARM: at91: make ecc register base soc independant
      ARM: at91: make dma register base soc independant
      ARM: at91: make rtt register base soc independant
      ARM: at91: add ioremap_registers entry point to soc setup
      ARM: at91: make pit register base soc independent
      ARM: at91: make smc register base soc independent
      ARM: at91: make CCFG soc independent
      ARM: at91: make shutdown controler soc independent
      ARM: at91: make watchdog drivers soc independent
      ARM: at91: make DBGU soc independent
      ARM: at91: make aic soc independent

 arch/arm/mach-at91/Kconfig                     |   36 +++++++-
 arch/arm/mach-at91/at91_devices.c              |  122 ++++++++++++++++++++++++
 arch/arm/mach-at91/at91cap9.c                  |   26 +++---
 arch/arm/mach-at91/at91cap9_devices.c          |   23 +++--
 arch/arm/mach-at91/at91rm9200.c                |   14 ++-
 arch/arm/mach-at91/at91rm9200_devices.c        |    4 +-
 arch/arm/mach-at91/at91sam9260.c               |   24 +++---
 arch/arm/mach-at91/at91sam9260_devices.c       |   23 +++--
 arch/arm/mach-at91/at91sam9261.c               |   24 +++---
 arch/arm/mach-at91/at91sam9261_devices.c       |   19 +++-
 arch/arm/mach-at91/at91sam9263.c               |   29 +++---
 arch/arm/mach-at91/at91sam9263_devices.c       |   27 ++++--
 arch/arm/mach-at91/at91sam926x_time.c          |   35 +++++--
 arch/arm/mach-at91/at91sam9g45.c               |   28 +++---
 arch/arm/mach-at91/at91sam9g45_devices.c       |   27 ++++--
 arch/arm/mach-at91/at91sam9rl.c                |   26 +++---
 arch/arm/mach-at91/at91sam9rl_devices.c        |   27 ++++--
 arch/arm/mach-at91/board-cam60.c               |    2 +-
 arch/arm/mach-at91/board-cap9adk.c             |    4 +-
 arch/arm/mach-at91/board-cpu9krea.c            |    4 +-
 arch/arm/mach-at91/board-dt.c                  |    2 +-
 arch/arm/mach-at91/board-neocore926.c          |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c        |    4 +-
 arch/arm/mach-at91/board-qil-a9260.c           |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c          |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c           |    4 +-
 arch/arm/mach-at91/board-sam9263ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c            |    2 +-
 arch/arm/mach-at91/board-snapper9260.c         |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c           |    2 +-
 arch/arm/mach-at91/board-usb-a926x.c           |    4 +-
 arch/arm/mach-at91/generic.h                   |    6 +-
 arch/arm/mach-at91/gpio.c                      |    8 +-
 arch/arm/mach-at91/include/mach/at91_aic.h     |   46 ++++++----
 arch/arm/mach-at91/include/mach/at91_dbgu.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91_pit.h     |    8 +-
 arch/arm/mach-at91/include/mach/at91_shdwc.h   |    6 +-
 arch/arm/mach-at91/include/mach/at91cap9.h     |   28 +++---
 arch/arm/mach-at91/include/mach/at91rm9200.h   |   12 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h  |   24 +++---
 arch/arm/mach-at91/include/mach/at91sam9261.h  |   20 ++--
 arch/arm/mach-at91/include/mach/at91sam9263.h  |   34 ++++----
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   17 +--
 arch/arm/mach-at91/include/mach/at91sam9g45.h  |   28 +++---
 arch/arm/mach-at91/include/mach/at91sam9rl.h   |   28 +++---
 arch/arm/mach-at91/include/mach/at91x40.h      |    1 -
 arch/arm/mach-at91/include/mach/debug-macro.S  |   10 ++-
 arch/arm/mach-at91/include/mach/entry-macro.S  |   10 +-
 arch/arm/mach-at91/include/mach/hardware.h     |   12 +++
 arch/arm/mach-at91/include/mach/irqs.h         |    2 +-
 arch/arm/mach-at91/include/mach/uncompress.h   |    6 +-
 arch/arm/mach-at91/irq.c                       |   38 ++++---
 arch/arm/mach-at91/sam9_smc.c                  |   58 +++++++----
 arch/arm/mach-at91/sam9_smc.h                  |    3 +-
 arch/arm/mach-at91/setup.c                     |   24 ++++-
 arch/arm/mach-at91/soc.h                       |    1 +
 drivers/watchdog/at91sam9_wdt.c                |   22 ++++-
 drivers/watchdog/at91sam9_wdt.h                |    6 +-
 61 files changed, 667 insertions(+), 351 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91_devices.c

Best Regards,
J.
