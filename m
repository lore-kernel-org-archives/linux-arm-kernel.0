From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:45:04 +0200
Subject: [PATCH 0/8] ARM: at91: make dma/ecc/pit/smc/rtt register base soc
	independant
Message-ID: <20111016194504.GK1459@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	This patch series start to make all AT91 registers soc independant
	to allow to have all soc compiled together and simplify the adding of
	the DT.

The following changes since commit 878aa5c0a050d03e49fdf04bd131286fd8847809:

  at91/yl-9200: Fix section mismatch (2011-10-17 03:57:49 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (8):
      ARM: at91/nand: make ecc register base soc independant
      ARM: at91/dma: make dma register base soc independant
      ARM: at91/rtt: make rtt register base soc independant
      ARM: rtc/at91sam9: use ioremap and iounmap
      ARM: at91: add map_register entry point to soc setup
      ARM: at91/pit: make register base soc independant
      ARM: at91: make smc register base soc independant
      ARM: at91: usart: drop static map regs for dbgu

 arch/arm/mach-at91/at91cap9.c                  |    8 +++
 arch/arm/mach-at91/at91cap9_devices.c          |   13 +++---
 arch/arm/mach-at91/at91rm9200.c                |    6 +++
 arch/arm/mach-at91/at91rm9200_devices.c        |    5 +-
 arch/arm/mach-at91/at91sam9260.c               |    8 +++
 arch/arm/mach-at91/at91sam9260_devices.c       |   13 +++---
 arch/arm/mach-at91/at91sam9261.c               |    8 +++
 arch/arm/mach-at91/at91sam9261_devices.c       |    9 ++--
 arch/arm/mach-at91/at91sam9263.c               |    9 ++++
 arch/arm/mach-at91/at91sam9263_devices.c       |   17 +++----
 arch/arm/mach-at91/at91sam926x_time.c          |   35 ++++++++++----
 arch/arm/mach-at91/at91sam9g45.c               |    8 +++
 arch/arm/mach-at91/at91sam9g45_devices.c       |   17 +++----
 arch/arm/mach-at91/at91sam9rl.c                |    8 +++
 arch/arm/mach-at91/at91sam9rl_devices.c        |   17 +++----
 arch/arm/mach-at91/board-cam60.c               |    2 +-
 arch/arm/mach-at91/board-cap9adk.c             |    4 +-
 arch/arm/mach-at91/board-cpu9krea.c            |    4 +-
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
 arch/arm/mach-at91/generic.h                   |    1 +
 arch/arm/mach-at91/include/mach/at91_pit.h     |    8 ++--
 arch/arm/mach-at91/include/mach/at91cap9.h     |   10 ++--
 arch/arm/mach-at91/include/mach/at91sam9260.h  |    8 ++--
 arch/arm/mach-at91/include/mach/at91sam9261.h  |    6 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h  |   14 +++---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   17 +++-----
 arch/arm/mach-at91/include/mach/at91sam9g45.h  |   10 ++--
 arch/arm/mach-at91/include/mach/at91sam9rl.h   |   10 ++--
 arch/arm/mach-at91/sam9_smc.c                  |   58 +++++++++++++++---------
 arch/arm/mach-at91/sam9_smc.h                  |    3 +-
 arch/arm/mach-at91/setup.c                     |    2 +
 arch/arm/mach-at91/soc.h                       |    1 +
 drivers/rtc/rtc-at91sam9.c                     |    9 +++-
 45 files changed, 232 insertions(+), 148 deletions(-)

Best Regards,
J.
