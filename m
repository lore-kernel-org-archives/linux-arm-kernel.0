From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Feb 2015 22:41:10 +0100
Subject: [GIT PULL] ARM: SoC fixes for 3.20-rc1
Message-ID: <51637341.9W2BTyGyEA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cc4f9c2a91b7be7b3590bb1cbe8148873556aa3f:

  Merge tag '64bit-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2015-02-17 09:47:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 444d2d33d8564f95df851ddaca80f640ca36934d:

  ARM: make of_device_ids const (2015-02-19 09:44:25 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 3.20-rc1

A few fixes that came in too late to make it into the first set of pull
requests but would still be nice to have in -rc1. The majority of these
are trivial build fixes for bugs that I found myself using randconfig
testing, and a set of two patches from Uwe to mark DT strings as 'const'
where appropriate, to resolve inconsistent section attributes.

----------------------------------------------------------------

Arnd Bergmann (12):
      ARM: vexpress: use ARM_CPU_SUSPEND if needed
      ARM: BCM: put back ARCH_MULTI_V7 dependency for mobile
      ARM: davinci: davinci_cfg_reg cannot be init
      ARM: davinci: multi-soc kernels require AUTO_ZRELADDR
      ARM: at91: fix pm declarations
      ARM: prima2: do not select SMP_ON_UP
      ARM: ixp4xx: fix {in,out}s{bwl} data types
      ARM: rockchip: make rockchip_suspend_init conditional
      ARM: sti: always enable RESET_CONTROLLER
      ARM: mvebu: build armada375-smp code conditionally
      ARM: rockchip: force built-in regulator support for PM
      Merge tag 'arm-soc/for-3.20/dts' of http://github.com/broadcom/stblinux into fixes

Florian Fainelli (1):
      ARM: dts: BCM63xx: fix L2 cache properties

Paul Bolle (1):
      ARM: mm: Remove Kconfig symbol CACHE_PL310

Ray Jui (1):
      ARM: dts: add I2C device nodes for Broadcom Cygnus

Uwe Kleine-K?nig (2):
      ARM: make arrays containing machine compatible strings const
      ARM: make of_device_ids const

 arch/arm/boot/dts/bcm-cygnus.dtsi       | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi         |  5 +++--
 arch/arm/kernel/perf_event_cpu.c        |  2 +-
 arch/arm/mach-at91/Kconfig              |  1 -
 arch/arm/mach-at91/at91rm9200_time.c    |  2 +-
 arch/arm/mach-at91/generic.h            |  8 ++++----
 arch/arm/mach-at91/pm.c                 |  4 ++--
 arch/arm/mach-axxia/axxia.c             |  2 +-
 arch/arm/mach-bcm/Kconfig               |  4 ++--
 arch/arm/mach-bcm/brcmstb.c             |  2 +-
 arch/arm/mach-davinci/Kconfig           |  2 ++
 arch/arm/mach-davinci/da8xx-dt.c        |  2 +-
 arch/arm/mach-davinci/mux.c             |  4 ++--
 arch/arm/mach-exynos/exynos.c           |  2 +-
 arch/arm/mach-exynos/suspend.c          |  2 +-
 arch/arm/mach-highbank/highbank.c       |  2 +-
 arch/arm/mach-hisi/hisilicon.c          |  8 ++++----
 arch/arm/mach-imx/mmdc.c                |  2 +-
 arch/arm/mach-ixp4xx/include/mach/io.h  | 19 +++++++++++++------
 arch/arm/mach-keystone/keystone.c       |  2 +-
 arch/arm/mach-keystone/pm_domain.c      |  2 +-
 arch/arm/mach-mmp/time.c                |  2 +-
 arch/arm/mach-mvebu/coherency.c         |  2 +-
 arch/arm/mach-mvebu/pmsu.c              |  2 +-
 arch/arm/mach-mvebu/system-controller.c |  2 +-
 arch/arm/mach-nspire/nspire.c           |  2 +-
 arch/arm/mach-omap2/omap4-common.c      |  2 +-
 arch/arm/mach-omap2/prm3xxx.c           |  2 +-
 arch/arm/mach-omap2/prm44xx.c           |  2 +-
 arch/arm/mach-prima2/Kconfig            |  1 -
 arch/arm/mach-prima2/common.c           |  6 +++---
 arch/arm/mach-prima2/platsmp.c          |  2 +-
 arch/arm/mach-rockchip/Kconfig          |  1 +
 arch/arm/mach-rockchip/pm.h             |  6 ++++++
 arch/arm/mach-s5pv210/s5pv210.c         |  2 +-
 arch/arm/mach-shmobile/setup-emev2.c    |  2 +-
 arch/arm/mach-sti/Kconfig               |  1 +
 arch/arm/mach-ux500/pm_domains.c        |  2 +-
 arch/arm/mach-versatile/versatile_dt.c  |  2 +-
 arch/arm/mach-vexpress/Kconfig          |  1 +
 arch/arm/mm/Kconfig                     |  7 -------
 41 files changed, 88 insertions(+), 58 deletions(-)
