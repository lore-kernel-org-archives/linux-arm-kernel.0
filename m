From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2016 23:06:30 +0200
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <2747538.eI4c21NGdR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f7b32e4c021fd788f13f6785e17efbc3eb05b351:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2016-08-02 12:41:13 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 12beb346710b766b8e74a7a3ac8165835bd68def:

  Merge tag 'pxa-fixes-v4.8' of https://github.com/rjarzmik/linux into randconfig-4.8 (2016-08-11 08:43:03 +0200)

----------------------------------------------------------------
ARM: SoC fixes

A couple of bug fixes have come in for v4.8 so far. Since the first few were
originally meant to go into -rc1 (but didn't get sent in time for travel
reasons), the branch is unfortunately based on top of a commit in the
middle of the merge window rather than -rc1.

Content-wise we have

- A fix for the last remaining broken build in kernelci,
  getting mach-shmobile to build again with SMP disabled
- A fix for a realview regression that broke real hardware but
  not the qemu model that everyone uses in practice (needed
  for v4.7 as well)
- A merge conflict fix for Tegra that also broke v4.7
- Two Kconfig fixes for arm64 build regressions
- A couple of arm32 build warning fixes (all harmless)
- Fixing the RTC on Exynos7 Espresso (which apparently
  never worked right)

----------------------------------------------------------------
Alim Akhtar (1):
      arm64: dts: Fix RTC by providing rtc_src clock

Antoine Tenart (1):
      MAINTAINER: alpine: add a mailing list

Arnd Bergmann (6):
      ARM: shmobile: don't call platform_can_secondary_boot on UP
      Revert "ARM: aspeed: adapt defconfigs for new CONFIG_PRINTK_TIME"
      ARM: don't include removed directories
      ARM: hide mach-*/ include for ARM_SINGLE_ARMV7M
      ARM: oxnas: select reset controller framework
      Merge tag 'pxa-fixes-v4.8' of https://github.com/rjarzmik/linux into randconfig-4.8

Linus Walleij (3):
      ARM: do away with final ARCH_REQUIRE_GPIOLIB
      ARM: dts: add syscon compatible string for CP syscon
      ARM: dts: add syscon compatible string for AP syscon

Ralf Ramsauer (1):
      ARM: tegra: fix erroneous address in dts

Robin Murphy (1):
      ARM: dts: realview: Fix PBX-A9 cache description

Sudeep Holla (2):
      arm64: Kconfig: select ALPINE_MSI only if PCI is selected
      arm64: Kconfig: select HISILICON_IRQ_MBIGEN only if PCI is selected

 MAINTAINERS                                     | 1 +
 arch/arm/Makefile                               | 2 ++
 arch/arm/boot/dts/arm-realview-pbx-a9.dts       | 9 ++++-----
 arch/arm/boot/dts/integratorap.dts              | 2 +-
 arch/arm/boot/dts/integratorcp.dts              | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       | 4 ++--
 arch/arm/configs/aspeed_g4_defconfig            | 2 +-
 arch/arm/configs/aspeed_g5_defconfig            | 2 +-
 arch/arm/mach-clps711x/Kconfig                  | 2 +-
 arch/arm/mach-mvebu/Makefile                    | 3 +--
 arch/arm/mach-oxnas/Kconfig                     | 2 ++
 arch/arm/mach-pxa/corgi.c                       | 1 +
 arch/arm/mach-pxa/spitz.c                       | 1 +
 arch/arm/mach-realview/Makefile                 | 3 +--
 arch/arm/mach-s5pv210/Makefile                  | 2 +-
 arch/arm/mach-shmobile/platsmp.c                | 3 +++
 arch/arm64/Kconfig.platforms                    | 4 ++--
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 3 +++
 18 files changed, 29 insertions(+), 19 deletions(-)
