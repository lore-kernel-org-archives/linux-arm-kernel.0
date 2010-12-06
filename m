From: per.forlin@stericsson.com (Per Forlin)
Date: Mon, 6 Dec 2010 13:52:22 +0100
Subject: [PATCH 0/3] ux500: Add support to boot from eMMC for U5500
Message-ID: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

U5500 now boots from eMMC.
Clock tree for U5500 is not implemented.
* Fix build issue with prcmu
* UART and MMC clock rates are adjusted for U5500
* Basic DMA support

Per Forlin (3):
  ux500: Call prmcu_init only for u8500
  ux500: Add eMMC support in U5500.
  ux500: Add DMA support for U5500

 arch/arm/mach-ux500/Makefile                   |    4 +-
 arch/arm/mach-ux500/board-u5500-sdi.c          |   49 ++++++++++
 arch/arm/mach-ux500/board-u5500.c              |    3 +-
 arch/arm/mach-ux500/clock.c                    |    2 +
 arch/arm/mach-ux500/cpu-db5500.c               |    2 +
 arch/arm/mach-ux500/cpu.c                      |    3 +-
 arch/arm/mach-ux500/dma-db5500.c               |  120 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    4 +
 arch/arm/mach-ux500/include/mach/setup.h       |    5 +
 9 files changed, 188 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c
 create mode 100644 arch/arm/mach-ux500/dma-db5500.c
