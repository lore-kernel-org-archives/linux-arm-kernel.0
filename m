From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jun 2014 16:43:55 +0200
Subject: [GIT PULL] nommu fixes for 3.17-rc1
Message-ID: <20140630144355.GH14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

the following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/nommu-for-rmk

for you to fetch changes up to 7343ab2ad6772f29d6bbb286a7aa0265a7aa5d3b:

  ARM: make user_addr_max more robust (2014-06-30 15:48:30 +0200)

----------------------------------------------------------------
A small collection of ARM-nommu related fixes and cleanups.

Regarding the small user base ("Hello, anyone out there apart from me?") and
the problem being fixed exists since 3.6-rc1 I don't consider the patches
serious enough to justify them going in before the next merge window.

This series makes efm32 boot again.
----------------------------------------------------------------

I have chosen -rc3 as base because -rc1 and -rc2 don't work for me as
they don't have 6980c3e2514e (ARM: 8086/1: Set memblock limit for
nommu).

Uwe Kleine-K?nig (5):
      ARM: nommu: drop support for ARM740T, ARM940T and ARM946E-S processors
      ARM: nommu: don't limit TASK_SIZE
      ARM: nommu: simplify definition of MODULES_END
      ARM: nommu: drop unused Kconfig symbol DRAM_SIZE
      ARM: make user_addr_max more robust

 Documentation/devicetree/bindings/arm/cpus.txt |   3 -
 arch/arm/Kconfig                               |   5 +-
 arch/arm/Kconfig-nommu                         |   4 -
 arch/arm/Makefile                              |   3 -
 arch/arm/configs/at91x40_defconfig             |   1 -
 arch/arm/configs/efm32_defconfig               |   1 -
 arch/arm/include/asm/glue-cache.h              |  16 -
 arch/arm/include/asm/glue-proc.h               |  27 --
 arch/arm/include/asm/memory.h                  |  10 +-
 arch/arm/include/asm/uaccess.h                 |   2 +-
 arch/arm/mm/Kconfig                            |  67 +---
 arch/arm/mm/Makefile                           |   3 -
 arch/arm/mm/proc-arm740.S                      | 151 ---------
 arch/arm/mm/proc-arm940.S                      | 374 ---------------------
 arch/arm/mm/proc-arm946.S                      | 429 -------------------------
 15 files changed, 12 insertions(+), 1084 deletions(-)
 delete mode 100644 arch/arm/mm/proc-arm740.S
 delete mode 100644 arch/arm/mm/proc-arm940.S
 delete mode 100644 arch/arm/mm/proc-arm946.S

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
