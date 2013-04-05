From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Apr 2013 15:30:15 +0530
Subject: [GIT PULL 1/3] DaVinci SoC updates for v3.10
Message-ID: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following DaVinci SoC updates for v3.10

Thanks,
Sekhar

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/soc

for you to fetch changes up to 93bd65150e4ee783b7366fd0e8172f347515df61:

  ARM: davinci: remove test for undefined Kconfig macro (2013-04-03 09:43:08 +0530)

----------------------------------------------------------------
v3.10 SoC updates for DaVinci

a) adds support for eHRPWM clocks
b) Fix the way MMC/SD IP versions are communicated to driver
   in preparation for DT support
c) Minor cleanup in debug-macro.S

----------------------------------------------------------------
Manjunathappa, Prakash (1):
      ARM: davinci: mmc: derive version information from device name

Paul Bolle (1):
      ARM: davinci: remove test for undefined Kconfig macro

Philip Avinash (2):
      ARM: davinci: clk framework support for enable/disable functionality
      ARM: davinci: da850: add ECAP & EHRPWM clock nodes

 arch/arm/mach-davinci/board-da830-evm.c          |    1 -
 arch/arm/mach-davinci/board-da850-evm.c          |    2 -
 arch/arm/mach-davinci/board-dm355-evm.c          |    1 -
 arch/arm/mach-davinci/board-dm365-evm.c          |    1 -
 arch/arm/mach-davinci/board-dm644x-evm.c         |    1 -
 arch/arm/mach-davinci/board-neuros-osd2.c        |    1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c      |    1 -
 arch/arm/mach-davinci/board-tnetv107x-evm.c      |    1 -
 arch/arm/mach-davinci/clock.c                    |   21 ++++++---
 arch/arm/mach-davinci/clock.h                    |    2 +
 arch/arm/mach-davinci/da830.c                    |    2 +-
 arch/arm/mach-davinci/da850.c                    |   50 +++++++++++++++++++++-
 arch/arm/mach-davinci/devices-da8xx.c            |    4 +-
 arch/arm/mach-davinci/devices-tnetv107x.c        |    4 +-
 arch/arm/mach-davinci/devices.c                  |    6 ++-
 arch/arm/mach-davinci/dm355.c                    |    4 +-
 arch/arm/mach-davinci/dm365.c                    |    4 +-
 arch/arm/mach-davinci/dm644x.c                   |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h       |    1 +
 arch/arm/mach-davinci/include/mach/debug-macro.S |    2 -
 arch/arm/mach-davinci/tnetv107x.c                |    4 +-
 drivers/mmc/host/davinci_mmc.c                   |   18 +++++++-
 include/linux/platform_data/mmc-davinci.h        |    3 --
 23 files changed, 98 insertions(+), 38 deletions(-)
