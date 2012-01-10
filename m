From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 Jan 2012 17:03:49 +0100
Subject: [PATCH 0/5] at91sam9g45 reset fix
Message-ID: <20120110160349.GV2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	this patch series fix the reset on sam9g45 and cap9
	as they share the same sdram IP

	this will also make the rstc soc independent

The following changes since commit e4e11180dfa545233e5145919b75b7fac88638df:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2012-01-09 17:37:37 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git for-arnd-reset-fix

Jean-Christophe PLAGNIOL-VILLARD (5):
      ARM: at91: fix cap9 ddrsdr register
      ARM: at91: merge at91cap9_ddrsdr.h in at91sam9_ddrsdr.h
      ARM: at91: introduce AT91_SAM9_ALT_RESET to select the at91sam9 alternative reset
      ARM: at91: make rstc soc independent
      ARM: at91: Fix at91sam9g45 and at91cap9 reset

 arch/arm/mach-at91/Kconfig                        |   14 +++
 arch/arm/mach-at91/Makefile                       |   14 ++-
 arch/arm/mach-at91/at91cap9.c                     |    9 +--
 arch/arm/mach-at91/at91sam9260.c                  |    1 +
 arch/arm/mach-at91/at91sam9261.c                  |    1 +
 arch/arm/mach-at91/at91sam9263.c                  |    1 +
 arch/arm/mach-at91/at91sam9_alt_reset.S           |    7 +-
 arch/arm/mach-at91/at91sam9g45.c                  |    7 +-
 arch/arm/mach-at91/at91sam9g45_reset.S            |   40 ++++++++
 arch/arm/mach-at91/at91sam9rl.c                   |    1 +
 arch/arm/mach-at91/generic.h                      |    2 +
 arch/arm/mach-at91/include/mach/at91_rstc.h       |   18 +++-
 arch/arm/mach-at91/include/mach/at91cap9.h        |    2 +-
 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h |  108 ---------------------
 arch/arm/mach-at91/include/mach/at91sam9260.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |   30 ++++--
 arch/arm/mach-at91/include/mach/at91sam9g45.h     |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h      |    2 +-
 arch/arm/mach-at91/pm.c                           |    9 +--
 arch/arm/mach-at91/pm.h                           |    8 +-
 arch/arm/mach-at91/pm_slowclock.S                 |    5 +-
 arch/arm/mach-at91/setup.c                        |    9 ++
 24 files changed, 132 insertions(+), 164 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91sam9g45_reset.S
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h

Best Regards,
J.
