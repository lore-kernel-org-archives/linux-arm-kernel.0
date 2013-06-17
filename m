From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 17:12:33 +0900
Subject: [GIT PULL 00/15 v2] Renesas ARM based SoC boot cleanup for v3.11
Message-ID: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This pull request is based on renesas-pinmux-for-v3.11, which you have
already pulled, in order to provide pre-requisites.

The following changes since commit 5fcf4a3c3a5bc08bf72a50ef1332501a3c1b96bb:

  ARM: shmobile: marzen: Use RCAR_GP_PIN macro (2013-06-05 17:18:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-boot-for-v3.11

for you to fetch changes up to 53332005bfde9d2e3c9a66030c0e8c2598eaa1d5:

  ARM: shmobile: Remove Bonito board support (2013-06-17 16:07:31 +0900)

----------------------------------------------------------------
Renesas ARM based SoC boot cleanup for v3.11

Work by Magnus Damm and others to clean up the boot of and move
things closer to supporting multi-arch.

As a side effect of this work it was decided to remove support for
two boards, Bonito and AP4EVB. Those patches are included in this
series as they depend on earlier patches in the series.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: Remove Bonito board support

Magnus Damm (14):
      ARM: shmobile: uImage load address rework
      ARM: shmobile: Let romImage rely on default ATAGS
      ARM: shmobile: Remove romImage CONFIG_MEMORY_START
      ARM: shmobile: Rework sh7372 sleep code to use virt_to_phys()
      ARM: shmobile: Add SMP boot function and argument
      ARM: shmobile: Add SCU boot function using argument
      ARM: shmobile: r8a7779 SMP with SCU boot fn and args
      ARM: shmobile: sh73a0 SMP with SCU boot fn and args
      ARM: shmobile: EMEV2 SMP with SCU boot fn and args
      ARM: shmobile: Remove old SCU boot code
      ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
      ARM: shmobile: Remove MEMORY_START/SIZE
      ARM: shmobile: Remove mach/memory.h
      ARM: shmobile: Remove AP4EVB board support

 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/compressed/head-shmobile.S           |   21 +-
 arch/arm/configs/ap4evb_defconfig                  |   56 -
 arch/arm/configs/bonito_defconfig                  |   72 --
 arch/arm/mach-shmobile/Kconfig                     |   58 -
 arch/arm/mach-shmobile/Makefile                    |    2 -
 arch/arm/mach-shmobile/Makefile.boot               |   18 +-
 arch/arm/mach-shmobile/board-ap4evb.c              | 1310 --------------------
 arch/arm/mach-shmobile/board-bonito.c              |  502 --------
 arch/arm/mach-shmobile/headsmp-scu.S               |   29 +-
 arch/arm/mach-shmobile/headsmp.S                   |   13 +-
 arch/arm/mach-shmobile/include/mach/common.h       |    6 +-
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |   93 --
 arch/arm/mach-shmobile/include/mach/memory.h       |    7 -
 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h    |   29 -
 arch/arm/mach-shmobile/include/mach/mmc.h          |    4 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h       |    2 +
 arch/arm/mach-shmobile/include/mach/zboot.h        |    6 +-
 arch/arm/mach-shmobile/pm-sh7372.c                 |    3 +
 arch/arm/mach-shmobile/sleep-sh7372.S              |    5 +-
 arch/arm/mach-shmobile/smp-emev2.c                 |    6 +-
 arch/arm/mach-shmobile/smp-r8a7779.c               |    6 +-
 arch/arm/mach-shmobile/smp-sh73a0.c                |    6 +-
 23 files changed, 68 insertions(+), 2188 deletions(-)
 delete mode 100644 arch/arm/configs/ap4evb_defconfig
 delete mode 100644 arch/arm/configs/bonito_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ap4evb.c
 delete mode 100644 arch/arm/mach-shmobile/board-bonito.c
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/memory.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
