From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:49 +0200
Subject: [PATCH 00/11] Generic ARM fixes for randconfig
Message-ID: <1317496920-7764-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This is a set of patches that I've been sitting on for a while
without ever getting them ready for inclusion. Out of the total
~150 patches I have to make 'make randconfig' work for a
number of ARM platforms, these are the ones that mostly for
common code within the ARM architecture.

I've now started going through the whole set and split them up
by topic so I can reduce the number of patches that are required.

Please pull these into your tree, or alternatively cherry-pick the
ones that you are happy with if you disagree with some of them.

This branch is available from

 git pull git://git.linaro.org/people/arnd/arm-soc.git randconfig/arm

For reference, I have another branch "for-next+randconfig" that
contains my entire set of patches merged with the arm-soc for-next
branch, and the individual branches are available at
git://git.linaro.org/people/arnd/linux.git

Arnd Bergmann (11):
  ARM: export rtc_lock for nvram driver
  ARM: SMP depends on MMU
  ARM: always use ARM_UNWIND for thumb2 kernels
  ARM: allow building alignment.c without PROC_FS
  ARM: vfp: use -mfloat-abi=soft to build vfp
  ARM: pm: let platforms select cpu_suspend support
  ARM: limit CONFIG_HAVE_IDE to platforms that do
  ARM: add io{read,write}{16,32}be functions
  ARM: pci: always export pcibios_bus_to_resource
  ARM: OC_ETM should not select ARM_AMBA
  ARM: common/vic: use proper __iomem annotations

 arch/arm/Kconfig              |   12 +++++++++++-
 arch/arm/Kconfig.debug        |    2 +-
 arch/arm/common/vic.c         |    3 ++-
 arch/arm/include/asm/io.h     |    6 ++++++
 arch/arm/kernel/Makefile      |    2 +-
 arch/arm/kernel/bios32.c      |    9 ++++-----
 arch/arm/kernel/time.c        |    6 ++----
 arch/arm/mach-exynos4/Kconfig |    1 +
 arch/arm/mach-omap2/Kconfig   |    2 ++
 arch/arm/mm/alignment.c       |   20 ++++++++++----------
 arch/arm/mm/proc-v7.S         |    2 +-
 arch/arm/plat-omap/Kconfig    |    1 +
 arch/arm/vfp/Makefile         |    2 +-
 lib/Kconfig.debug             |    4 ++--
 14 files changed, 45 insertions(+), 27 deletions(-)

-- 
1.7.5.4
