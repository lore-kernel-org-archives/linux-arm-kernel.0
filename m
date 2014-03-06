From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Mar 2014 20:20:12 +0530
Subject: [GIT PULL] DaVinci SoC updates for v3.15
Message-ID: <53188B24.4090708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.15/soc

for you to fetch changes up to 4b9e44f8d7c9cd166d8304b8f619741c1d59b836:

  ARM: davinci: remove da8xx_omapl_defconfig (2014-03-06 19:08:30 +0530)

----------------------------------------------------------------
This pull request removes da8xx_omapl_defconfig
enabling all ARMv5 davinci devices to be built
using davinci_all_defconfig

----------------------------------------------------------------
Sekhar Nori (4):
      ARM: davinci: enable da8xx build concurrently with older devices
      ARM: davinci: add da8xx specific configs to davinci_all_defconfig
      ARM: davinci: da8xx: fix multiple watchdog device registration
      ARM: davinci: remove da8xx_omapl_defconfig

 arch/arm/configs/da8xx_omapl_defconfig |  139 --------------------------------
 arch/arm/configs/davinci_all_defconfig |   20 +++++
 arch/arm/mach-davinci/Makefile.boot    |   20 ++---
 arch/arm/mach-davinci/davinci.h        |    2 +
 arch/arm/mach-davinci/devices.c        |   17 +---
 arch/arm/mach-davinci/dm355.c          |    8 +-
 arch/arm/mach-davinci/dm365.c          |    8 +-
 arch/arm/mach-davinci/dm644x.c         |    8 +-
 arch/arm/mach-davinci/dm646x.c         |    8 +-
 9 files changed, 59 insertions(+), 171 deletions(-)
 delete mode 100644 arch/arm/configs/da8xx_omapl_defconfig
