From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:35:14 +0100
Subject: [PATCH 0/6] AT91 Reset cleanup
Message-ID: <20111129173514.GW15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	the following patch series will merge the ddr controler header file
	for sam9 and cap9 and cleanup the reset by

	swtich to arm_pm_restart
	fix the sam9g45 and cap9 reset
	make rstc soc independent

The following changes since commit 15327570807209b5c088382af23ed3fc47558d87:

  ARM: at91/gpio: fix display of number of irq setuped (2011-11-28 22:53:09 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.3-reset

Jean-Christophe PLAGNIOL-VILLARD (6):
      ARM: at91: fix cap9 ddrsdr register
      ARM: at91: merge at91cap9_ddrsdr.h in at91sam9_ddrsdr.h
      ARM: at91: introduce AT91_SAM9_ALT_RESET to select the at91sam9 alternative reset
      ARM: restart: at91: use new restart hook
      ARM: at91: Fix at91sam9g45 and at91cap9 reset
      ARM: at91: make rstc soc independent

 arch/arm/mach-at91/Kconfig                        |   14 +++
 arch/arm/mach-at91/Makefile                       |   14 ++-
 arch/arm/mach-at91/at91cap9.c                     |    9 +--
 arch/arm/mach-at91/at91rm9200.c                   |    4 +-
 arch/arm/mach-at91/at91sam9260.c                  |    3 +-
 arch/arm/mach-at91/at91sam9261.c                  |    3 +-
 arch/arm/mach-at91/at91sam9263.c                  |    3 +-
 arch/arm/mach-at91/at91sam9_alt_reset.S           |   16 +--
 arch/arm/mach-at91/at91sam9g45.c                  |    9 +--
 arch/arm/mach-at91/at91sam9g45_reset.S            |   40 ++++++++
 arch/arm/mach-at91/at91sam9rl.c                   |    3 +-
 arch/arm/mach-at91/generic.h                      |    5 +-
 arch/arm/mach-at91/include/mach/at91_rstc.h       |   18 +++-
 arch/arm/mach-at91/include/mach/at91cap9.h        |    2 +-
 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h |  108 ---------------------
 arch/arm/mach-at91/include/mach/at91sam9260.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |   30 ++++--
 arch/arm/mach-at91/include/mach/at91sam9g45.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h      |    2 +-
 arch/arm/mach-at91/include/mach/system.h          |    5 -
 arch/arm/mach-at91/pm.c                           |    9 +--
 arch/arm/mach-at91/pm.h                           |    8 +-
 arch/arm/mach-at91/pm_slowclock.S                 |    5 +-
 arch/arm/mach-at91/setup.c                        |    9 ++
 26 files changed, 142 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91sam9g45_reset.S
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h

Best Regards,
J.
