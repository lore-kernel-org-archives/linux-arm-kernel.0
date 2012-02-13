From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 13 Feb 2012 17:48:56 +0100
Subject: [PATCH 0/6] ARM: at91: more at91_sys_read/write cleanup
Message-ID: <20120213164856.GE3378@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This path serie continue to cleanup the use of at91_sys_read/write
	and make pmc and memory controller soc independant.

	It will also make pm_slowclock soc independant and detect the memory
	controller at runtime

	this patch serie depends on irq_domain patch serie send by Nicolas

The following changes since commit 32c2e70e8a7fdb509c890ffd48642ebf49478d72:

  ARM: at91: make st soc independent (2012-02-14 00:42:19 +0800)

are available in the git repository at:
  git at github.com:at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (6):
      ARM: at91: pm_slowclock rename register to named define
      ARM: at91: pm_slowclock move register definition to pm.c
      ARM: at91: rm9200 move sdramc define to at91rm9200_sdramc
      ARM: at91: make sdram/ddr register base soc independent
      ARM: at91: pm_slowclock add runtime memory contoller detection
      ARM: at91: make pmc register base soc independent

 arch/arm/mach-at91/at91rm9200.c                    |    3 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   13 +-
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9261.c                   |    1 +
 arch/arm/mach-at91/at91sam9263.c                   |    2 +
 arch/arm/mach-at91/at91sam9_alt_reset.S            |   12 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45_reset.S             |   12 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    1 +
 arch/arm/mach-at91/at91sam9x5.c                    |    1 +
 arch/arm/mach-at91/board-cpuat91.c                 |    1 +
 arch/arm/mach-at91/board-eco920.c                  |    5 +-
 arch/arm/mach-at91/board-kb9202.c                  |    1 +
 arch/arm/mach-at91/board-picotux200.c              |    1 +
 arch/arm/mach-at91/board-rm9200dk.c                |    1 +
 arch/arm/mach-at91/board-rm9200ek.c                |    1 +
 arch/arm/mach-at91/board-yl-9200.c                 |    3 +-
 arch/arm/mach-at91/clock.c                         |   75 +++---
 arch/arm/mach-at91/generic.h                       |    3 +
 arch/arm/mach-at91/include/mach/at91_pmc.h         |   56 +++--
 arch/arm/mach-at91/include/mach/at91_ramc.h        |   32 +++
 arch/arm/mach-at91/include/mach/at91rm9200.h       |    6 +-
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h    |   58 +----
 .../arm/mach-at91/include/mach/at91rm9200_sdramc.h |   63 +++++
 arch/arm/mach-at91/include/mach/at91sam9260.h      |    3 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h      |    3 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h      |    5 +-
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h  |    6 -
 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h  |    6 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h      |    5 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h       |    3 +-
 arch/arm/mach-at91/include/mach/at91sam9x5.h       |    5 +-
 arch/arm/mach-at91/include/mach/hardware.h         |    3 +-
 arch/arm/mach-at91/pm.c                            |   35 ++-
 arch/arm/mach-at91/pm.h                            |   11 +-
 arch/arm/mach-at91/pm_slowclock.S                  |  271 ++++++++++----------
 drivers/pcmcia/at91_cf.c                           |    5 +-
 drivers/usb/gadget/atmel_usba_udc.c                |    6 +-
 38 files changed, 409 insertions(+), 312 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h

Best Regards,
J.
