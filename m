From: horms@verge.net.au (Simon Horman)
Date: Thu,  1 Nov 2012 08:41:42 +0800
Subject: [GIT PULL v3] Renesas ARM-based SoC for v3.8
Message-ID: <1351730513-2952-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC enhancements for 3.8.

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to 7b9621fb8a7f3602f86773e688e4fa4dd9bbfb73:

  ARM: shmobile: r8a7740: Enable PMU (2012-10-30 15:31:40 +0800)

----------------------------------------------------------------
Bastian Hecht (4):
      ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode
      ARM: shmobile: sh73a0: Replace modify_scu_cpu_psr with scu_power_mode
      ARM: shmobile: r8a7779: Replace modify_scu_cpu_psr with scu_power_mode
      ARM: mach-shmobile: add FLCTL DMA slave definitions for sh7372

Kuninori Morimoto (4):
      ARM: shmobile: r8a7740: fixup DT machine desc name typo
      ARM: shmobile: r8a7779: add HSPI clock support
      ARM: shmobile: r8a7779: add I2C clock support
      ARM: shmobile: r8a7779: add I2C driver support

Nobuhiro Iwamatsu (3):
      ARM: shmobile: Remove SH7367 support
      ARM: shmobile: Remove SH7377 support
      ARM: shmobile: r8a7740: Enable PMU

 arch/arm/boot/dts/sh7377.dtsi                |   21 -
 arch/arm/configs/armadillo800eva_defconfig   |    1 +
 arch/arm/configs/marzen_defconfig            |    2 +
 arch/arm/mach-shmobile/Kconfig               |   12 -
 arch/arm/mach-shmobile/Makefile              |    6 -
 arch/arm/mach-shmobile/clock-r8a7779.c       |   16 +-
 arch/arm/mach-shmobile/clock-sh7367.c        |  355 ------
 arch/arm/mach-shmobile/clock-sh7377.c        |  366 ------
 arch/arm/mach-shmobile/include/mach/common.h |   18 -
 arch/arm/mach-shmobile/include/mach/sh7367.h |  332 -----
 arch/arm/mach-shmobile/include/mach/sh7372.h |    4 +
 arch/arm/mach-shmobile/include/mach/sh7377.h |  360 ------
 arch/arm/mach-shmobile/intc-sh7367.c         |  413 ------
 arch/arm/mach-shmobile/intc-sh7377.c         |  592 ---------
 arch/arm/mach-shmobile/pfc-sh7367.c          | 1727 --------------------------
 arch/arm/mach-shmobile/pfc-sh7372.c          | 1663 -------------------------
 arch/arm/mach-shmobile/pfc-sh7377.c          | 1688 -------------------------
 arch/arm/mach-shmobile/setup-r8a7740.c       |   18 +-
 arch/arm/mach-shmobile/setup-r8a7779.c       |   77 ++
 arch/arm/mach-shmobile/setup-sh7367.c        |  481 -------
 arch/arm/mach-shmobile/setup-sh7372.c        |   20 +
 arch/arm/mach-shmobile/setup-sh7377.c        |  549 --------
 arch/arm/mach-shmobile/smp-emev2.c           |   22 +-
 arch/arm/mach-shmobile/smp-r8a7779.c         |   25 +-
 arch/arm/mach-shmobile/smp-sh73a0.c          |   23 +-
 25 files changed, 143 insertions(+), 8648 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh7377.dtsi
 delete mode 100644 arch/arm/mach-shmobile/clock-sh7367.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh7377.c
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sh7367.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sh7377.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh7367.c
 delete mode 100644 arch/arm/mach-shmobile/intc-sh7377.c
 delete mode 100644 arch/arm/mach-shmobile/pfc-sh7367.c
 delete mode 100644 arch/arm/mach-shmobile/pfc-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/pfc-sh7377.c
 delete mode 100644 arch/arm/mach-shmobile/setup-sh7367.c
 delete mode 100644 arch/arm/mach-shmobile/setup-sh7377.c
