From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:28:53 -0600
Subject: [PATCH 0/8] ux500: support for snowball board V2 
Message-ID: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

This suite of patches is the second, re-worked version for
the support of the snowball board.

Mathieu J. Poirier (8):
  ux500: adding machine ID for snowball.
  ux500: adding new board file for snowball.
  ux500: setting proper uart for snowball
  ux500: adding custom pin configuration file for snowball
  ux500: adding SDI support for snowball board
  ux500: fixing irq header file dependency.
  ux500: adding config file options for snowball board.
  ux500: Kconfig for snowball board

 arch/arm/configs/u8500_defconfig                   |   18 +-
 arch/arm/mach-ux500/Kconfig                        |    6 +
 arch/arm/mach-ux500/Makefile                       |    3 +
 arch/arm/mach-ux500/board-mop500-sdi.c             |   31 ++-
 arch/arm/mach-ux500/board-mop500.h                 |    5 +
 arch/arm/mach-ux500/board-snowball-pins.c          |  133 ++++++++
 arch/arm/mach-ux500/board-snowball.c               |  359 ++++++++++++++++++++
 arch/arm/mach-ux500/board-snowball.h               |   12 +
 .../mach-ux500/include/mach/irqs-board-mop500.h    |   44 +++
 arch/arm/mach-ux500/include/mach/irqs.h            |   43 ---
 arch/arm/mach-ux500/include/mach/uncompress.h      |    3 +-
 arch/arm/tools/mach-types                          |    1 +
 12 files changed, 606 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball-pins.c
 create mode 100644 arch/arm/mach-ux500/board-snowball.c
 create mode 100644 arch/arm/mach-ux500/board-snowball.h
