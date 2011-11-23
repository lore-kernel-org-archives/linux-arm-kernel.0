From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 23 Nov 2011 18:10:23 +0100
Subject: [AT91 PULL] ioremap pull request for 3.3
Message-ID: <20111123171022.GB15531@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

	this pull containt the first patch series that rework the base address
	of a lots of drivers (aic, rtc, gpio, ecc, dma, rtt, pit, smc, shutdown, watchdog, dbgu)
	to allow the multi soc and simplify the adding of the DT
	
The following changes since commit 8454badc89ed455990b1a060d9e4ed890b9e162c:

  ARM: at91: rename at91sam9260ek_defconfig to at91sam9260_defconfig (2011-11-23 02:45:57 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.3-ioremap

Jean-Christophe PLAGNIOL-VILLARD (14):
      ARM: at91: define CLOCK_TICK_RATE to bogus value except A91X40
      ARM: at91: make gpio register base soc independant
      ARM: at91: make ecc register base soc independant
      ARM: at91: make dma register base soc independant
      ARM: at91: make rtt register base soc independant
      ARM: at91: add ioremap_registers entry point to soc setup
      ARM: at91: make pit register base soc independent
      ARM: at91: make smc register base soc independent
      ARM: at91: drop CCFG
      ARM: at91: make shutdown controler soc independent
      ARM: at91: make watchdog drivers soc independent
      ARM: at91: make DBGU soc independent
      ARM: at91: make aic soc independent
      ARM: at91: make rm9200 rtc drivers soc independent

 arch/arm/Kconfig.debug                         |    8 ++
 arch/arm/mach-at91/Kconfig                     |   24 +++++-
 arch/arm/mach-at91/at91cap9.c                  |   26 +++---
 arch/arm/mach-at91/at91cap9_devices.c          |   23 ++++--
 arch/arm/mach-at91/at91rm9200.c                |   14 +++-
 arch/arm/mach-at91/at91rm9200_devices.c        |   20 ++++-
 arch/arm/mach-at91/at91rm9200_time.c           |    8 +-
 arch/arm/mach-at91/at91sam9260.c               |   24 +++---
 arch/arm/mach-at91/at91sam9260_devices.c       |   23 ++++--
 arch/arm/mach-at91/at91sam9261.c               |   24 +++---
 arch/arm/mach-at91/at91sam9261_devices.c       |   19 +++-
 arch/arm/mach-at91/at91sam9263.c               |   29 ++++---
 arch/arm/mach-at91/at91sam9263_devices.c       |   27 ++++--
 arch/arm/mach-at91/at91sam926x_time.c          |   38 +++++++---
 arch/arm/mach-at91/at91sam9g45.c               |   28 +++---
 arch/arm/mach-at91/at91sam9g45_devices.c       |   43 ++++++++---
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
 arch/arm/mach-at91/gpio.c                      |    8 ++-
 arch/arm/mach-at91/include/mach/at91_aic.h     |   48 +++++++----
 arch/arm/mach-at91/include/mach/at91_dbgu.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91_pit.h     |    8 +-
 arch/arm/mach-at91/include/mach/at91_rtc.h     |   24 +++---
 arch/arm/mach-at91/include/mach/at91_shdwc.h   |   16 +++-
 arch/arm/mach-at91/include/mach/at91cap9.h     |   27 +++---
 arch/arm/mach-at91/include/mach/at91rm9200.h   |   14 ++--
 arch/arm/mach-at91/include/mach/at91sam9260.h  |   23 +++---
 arch/arm/mach-at91/include/mach/at91sam9261.h  |   20 +++---
 arch/arm/mach-at91/include/mach/at91sam9263.h  |   33 ++++----
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   17 ++---
 arch/arm/mach-at91/include/mach/at91sam9g45.h  |   30 ++++----
 arch/arm/mach-at91/include/mach/at91sam9rl.h   |   29 +++----
 arch/arm/mach-at91/include/mach/at91x40.h      |    1 -
 arch/arm/mach-at91/include/mach/debug-macro.S  |   10 ++-
 arch/arm/mach-at91/include/mach/entry-macro.S  |   11 ++-
 arch/arm/mach-at91/include/mach/hardware.h     |   12 +++
 arch/arm/mach-at91/include/mach/irqs.h         |    2 +-
 arch/arm/mach-at91/include/mach/timex.h        |   65 +--------------
 arch/arm/mach-at91/include/mach/uncompress.h   |    6 +-
 arch/arm/mach-at91/irq.c                       |   38 +++++----
 arch/arm/mach-at91/pm.c                        |    7 +-
 arch/arm/mach-at91/sam9_smc.c                  |   62 ++++++++++-----
 arch/arm/mach-at91/sam9_smc.h                  |    3 +-
 arch/arm/mach-at91/setup.c                     |   26 +++++-
 arch/arm/mach-at91/soc.h                       |    1 +
 drivers/rtc/rtc-at91rm9200.c                   |  101 +++++++++++++++---------
 drivers/watchdog/at91sam9_wdt.c                |   22 +++++-
 drivers/watchdog/at91sam9_wdt.h                |    6 +-
 66 files changed, 682 insertions(+), 471 deletions(-)
 
Best Regards,
J.
