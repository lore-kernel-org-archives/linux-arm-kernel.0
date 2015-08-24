From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:00 +0900
Subject: [PATCH 00/18] ARM: use const and __initconst for smp_operations
Message-ID: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently, SoC code can not add const qualifier to smp_operations
structures although they are never over-written.

01/18 and 02/18 add small changes to the ARM core to fix that.
The rest of this series replace "__initdata" with "const ... __initconst"
for each of SoC code.

I split this series into per-SoC so that each sub-arch maintainer
can easily give their Acked-by.  (Is this better?)

Russell, Olof, and Arnd:

How should this series be applied (if it looks good)?
The first two are ARM-tree wide and looks like in the field of Russell.
The rest are highly SoC-related.



Masahiro Yamada (18):
  ARM: add const qualifier to the argument of smp_set_ops()
  ARM: add const qualifier to smp_operations member in structures
  ARM: alpine: use const and __initconst for smp_operations
  ARM: axxia: use const and __initconst for smp_operations
  ARM: BCM: use const and __initconst for smp_operations
  ARM: berlin: use const and __initconst for smp_operations
  ARM: EXYNOS: use const and __initconst for smp_operations
  ARM: hisi: do not export smp_operations structures
  ARM: hisi: use const and __initconst for smp_operations
  ARM: mvebu: use const and __initconst for smp_operations
  ARM: qcom: use const and __initconst for smp_operations
  ARM: rockchip: use const and __initconst for smp_operations
  ARM: socfpga: use const and __initconst for smp_operations
  ARM: sunxi: use const and __initconst for smp_operations
  ARM: uniphier: use const and __initconst for smp_operations
  ARM: zx: use const and __initconst for smp_operations
  ARM: zynq: use const and __initconst for smp_operations
  ARM: mcpm: use const and __initconst for smp_operations

 arch/arm/common/mcpm_platsmp.c      | 2 +-
 arch/arm/include/asm/mach/arch.h    | 2 +-
 arch/arm/include/asm/smp.h          | 4 ++--
 arch/arm/kernel/smp.c               | 2 +-
 arch/arm/mach-alpine/platsmp.c      | 2 +-
 arch/arm/mach-axxia/platsmp.c       | 2 +-
 arch/arm/mach-bcm/bcm63xx_smp.c     | 2 +-
 arch/arm/mach-bcm/kona_smp.c        | 2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c | 2 +-
 arch/arm/mach-berlin/platsmp.c      | 2 +-
 arch/arm/mach-exynos/common.h       | 2 +-
 arch/arm/mach-exynos/platsmp.c      | 2 +-
 arch/arm/mach-hisi/core.h           | 3 ---
 arch/arm/mach-hisi/platsmp.c        | 6 +++---
 arch/arm/mach-mvebu/armada-370-xp.h | 2 +-
 arch/arm/mach-mvebu/platsmp-a9.c    | 4 ++--
 arch/arm/mach-mvebu/platsmp.c       | 2 +-
 arch/arm/mach-qcom/platsmp.c        | 6 +++---
 arch/arm/mach-rockchip/platsmp.c    | 2 +-
 arch/arm/mach-socfpga/platsmp.c     | 4 ++--
 arch/arm/mach-sunxi/platsmp.c       | 4 ++--
 arch/arm/mach-uniphier/platsmp.c    | 2 +-
 arch/arm/mach-zx/platsmp.c          | 2 +-
 arch/arm/mach-zynq/common.h         | 2 +-
 arch/arm/mach-zynq/platsmp.c        | 2 +-
 25 files changed, 32 insertions(+), 35 deletions(-)

-- 
1.9.1
