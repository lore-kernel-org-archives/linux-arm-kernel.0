From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:02 -0700
Subject: [PATCH 00/10] ux500: support for snowball board.
Message-ID: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

This suite of patches introduce support for the u8500 based
snowball board.

Alessandro Rubini (3):
  smsc911x: use shifted register access
  ux500: added snowball-netev with latest fixes
  ux500: added snowball-digio.c

Mathieu J. Poirier (7):
  ux500: Introducing foundation for snowball board.
  ux500: Adding new board files for snowball.
  ux500: Adding custom pin configuration file for snowball. - Adding
    dependency in Makefile. - Adding init function call to
    board-snowball.c - New header file.
  ux500: Adding sdi support on snowball.
  ux500: hooking up netdev and digio to compilation.
  ux500: Addressing irq header file dependency for snowball.
  ux500: adding config file options for snowball board.

 arch/arm/configs/u8500_defconfig              | 1497 +++++++++++++++++++++++++
 arch/arm/mach-ux500/Kconfig                   |    6 +
 arch/arm/mach-ux500/Makefile                  |    5 +
 arch/arm/mach-ux500/board-mop500-sdi.c        |   32 +-
 arch/arm/mach-ux500/board-mop500.h            |    5 +
 arch/arm/mach-ux500/board-snowball-digio.c    |  122 ++
 arch/arm/mach-ux500/board-snowball-netdev.c   |   86 ++
 arch/arm/mach-ux500/board-snowball-pins.c     |  133 +++
 arch/arm/mach-ux500/board-snowball.c          |  265 +++++
 arch/arm/mach-ux500/board-snowball.h          |   18 +
 arch/arm/mach-ux500/include/mach/irqs.h       |    2 +-
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 +-
 arch/arm/tools/mach-types                     |    1 +
 drivers/net/smsc911x.c                        |   27 +-
 include/linux/smsc911x.h                      |    1 +
 15 files changed, 2185 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball-digio.c
 create mode 100644 arch/arm/mach-ux500/board-snowball-netdev.c
 create mode 100644 arch/arm/mach-ux500/board-snowball-pins.c
 create mode 100644 arch/arm/mach-ux500/board-snowball.c
 create mode 100644 arch/arm/mach-ux500/board-snowball.h
