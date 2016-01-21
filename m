From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:35 -0800
Subject: [GIT PULL 2/9] ARM: SoC cleanups for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A smallish number of general cleanup commits this release cycle. Some
of these are minor tweaks:

- shmobile change of binding for their GIC (using arm,pl390 now)
- ARCH_RENESAS introduction
- Misc other renesas updates

There's also a couple of treewide commits from Masahiro Yamada cleaning up
const/__initconst for SMP operation structs and a switch to using "depends
on" instead of if-constructs on most of the Kconfig platform targets.

----------------------------------------------------------------

The following changes since commit a718ed0e247571cc0d2d34a20e2fb528d4177185:

  Merge branch 'next/fixes-non-critical' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to 0ef917f4fb8342fe2fd0b195f2d65223faf273a2:

  Merge tag 'renesas-gic-cleanup-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/cleanup

----------------------------------------------------------------

Arnd Bergmann (5):
      ARM: mvebu: remove unused mach/gpio.h
      Merge branch 'treewide/cleanup' into next/cleanup
      Merge tag 'renesas-cleanup-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'mvebu-cleanup-4.5-1' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge tag 'arm-soc/for-4.5/cleanup' of git://git.infradead.org/linux-mtd into next/cleanup

Geert Uytterhoeven (6):
      ARM: shmobile: r7s72100 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: r8a7740 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: emev2 dtsi: Use "arm,pl390" for GIC
      ARM: shmobile: r8a7778 dtsi: Use "arm,pl390" for GIC
      staging: board: kzm9d: Use "arm,pl390"
      staging: board: armadillo800eva: Use "arm,pl390"

Laurent Pinchart (1):
      ARM: shmobile: Remove legacy mach/irqs.h

Linus Walleij (1):
      ARM/clocksource: use automatic DT probing for ux500 PRCMU

Masahiro Yamada (3):
      ARM: hisi: do not export smp_operations structures
      ARM: use const and __initconst for smp_operations
      ARM: use "depends on" for SoC configs instead of "if" after prompt

Olof Johansson (1):
      Merge tag 'renesas-gic-cleanup-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/cleanup

Simon Horman (2):
      MAINTAINERS: Remove link to oss.renesas.com which is closed
      ARM: shmobile: Introduce ARCH_RENESAS


 MAINTAINERS                                |  1 -
 arch/arm/Kconfig                           |  3 +-
 arch/arm/boot/dts/emev2.dtsi               |  2 +-
 arch/arm/boot/dts/r7s72100.dtsi            |  2 +-
 arch/arm/boot/dts/r8a7740.dtsi             |  2 +-
 arch/arm/boot/dts/r8a7778.dtsi             |  2 +-
 arch/arm/common/mcpm_platsmp.c             |  2 +-
 arch/arm/configs/multi_v7_defconfig        |  2 +-
 arch/arm/configs/shmobile_defconfig        |  2 +-
 arch/arm/include/asm/psci.h                |  2 +-
 arch/arm/kernel/psci_smp.c                 |  2 +-
 arch/arm/mach-alpine/Kconfig               |  3 +-
 arch/arm/mach-alpine/platsmp.c             |  2 +-
 arch/arm/mach-at91/Kconfig                 | 15 +++++---
 arch/arm/mach-axxia/Kconfig                |  3 +-
 arch/arm/mach-axxia/platsmp.c              |  2 +-
 arch/arm/mach-bcm/Kconfig                  | 27 +++++++++-----
 arch/arm/mach-bcm/bcm63xx_smp.c            |  2 +-
 arch/arm/mach-bcm/kona_smp.c               |  2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c        |  2 +-
 arch/arm/mach-berlin/Kconfig               |  3 +-
 arch/arm/mach-berlin/platsmp.c             |  2 +-
 arch/arm/mach-cns3xxx/Kconfig              |  3 +-
 arch/arm/mach-exynos/Kconfig               |  3 +-
 arch/arm/mach-exynos/common.h              |  2 +-
 arch/arm/mach-exynos/platsmp.c             |  2 +-
 arch/arm/mach-highbank/Kconfig             |  3 +-
 arch/arm/mach-hisi/Kconfig                 | 12 ++++---
 arch/arm/mach-hisi/core.h                  |  3 --
 arch/arm/mach-hisi/platmcpm.c              |  2 +-
 arch/arm/mach-hisi/platsmp.c               |  6 ++--
 arch/arm/mach-imx/Kconfig                  |  6 ++--
 arch/arm/mach-imx/common.h                 |  4 +--
 arch/arm/mach-imx/platsmp.c                |  4 +--
 arch/arm/mach-integrator/Kconfig           |  3 +-
 arch/arm/mach-keystone/keystone.h          |  2 +-
 arch/arm/mach-keystone/platsmp.c           |  2 +-
 arch/arm/mach-mediatek/Kconfig             |  3 +-
 arch/arm/mach-mediatek/platsmp.c           |  4 +--
 arch/arm/mach-meson/Kconfig                |  3 +-
 arch/arm/mach-moxart/Kconfig               |  3 +-
 arch/arm/mach-mvebu/Kconfig                | 24 ++++++++-----
 arch/arm/mach-mvebu/armada-370-xp.h        |  2 +-
 arch/arm/mach-mvebu/include/mach/gpio.h    |  1 -
 arch/arm/mach-mvebu/platsmp-a9.c           |  4 +--
 arch/arm/mach-mvebu/platsmp.c              |  2 +-
 arch/arm/mach-omap2/common.h               |  2 +-
 arch/arm/mach-omap2/omap-smp.c             |  2 +-
 arch/arm/mach-picoxcell/Kconfig            |  3 +-
 arch/arm/mach-prima2/Kconfig               |  3 +-
 arch/arm/mach-prima2/common.h              |  2 +-
 arch/arm/mach-prima2/platsmp.c             |  2 +-
 arch/arm/mach-qcom/Kconfig                 |  3 +-
 arch/arm/mach-qcom/platsmp.c               |  6 ++--
 arch/arm/mach-realview/core.h              |  2 +-
 arch/arm/mach-realview/platsmp.c           |  2 +-
 arch/arm/mach-rockchip/Kconfig             |  3 +-
 arch/arm/mach-rockchip/platsmp.c           |  2 +-
 arch/arm/mach-s5pv210/Kconfig              |  3 +-
 arch/arm/mach-shmobile/Kconfig             | 14 +++++---
 arch/arm/mach-shmobile/include/mach/irqs.h | 10 ------
 arch/arm/mach-shmobile/irqs.h              | 15 --------
 arch/arm/mach-shmobile/r8a7779.h           |  2 +-
 arch/arm/mach-shmobile/r8a7790.h           |  2 +-
 arch/arm/mach-shmobile/r8a7791.h           |  2 +-
 arch/arm/mach-shmobile/setup-emev2.c       |  2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c     |  1 -
 arch/arm/mach-shmobile/sh73a0.h            |  2 +-
 arch/arm/mach-shmobile/smp-emev2.c         |  2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c       |  2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c       |  2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c       |  2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c        |  2 +-
 arch/arm/mach-socfpga/Kconfig              |  3 +-
 arch/arm/mach-socfpga/platsmp.c            |  4 +--
 arch/arm/mach-spear/Kconfig                |  3 +-
 arch/arm/mach-spear/generic.h              |  2 +-
 arch/arm/mach-spear/platsmp.c              |  2 +-
 arch/arm/mach-sti/Kconfig                  |  3 +-
 arch/arm/mach-sti/platsmp.c                |  2 +-
 arch/arm/mach-sti/smp.h                    |  2 +-
 arch/arm/mach-sunxi/Kconfig                |  3 +-
 arch/arm/mach-sunxi/platsmp.c              |  4 +--
 arch/arm/mach-tegra/Kconfig                |  3 +-
 arch/arm/mach-tegra/common.h               |  2 +-
 arch/arm/mach-tegra/platsmp.c              |  2 +-
 arch/arm/mach-u300/Kconfig                 |  4 +--
 arch/arm/mach-uniphier/platsmp.c           |  2 +-
 arch/arm/mach-ux500/Kconfig                |  4 +--
 arch/arm/mach-ux500/Makefile               |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c           |  2 --
 arch/arm/mach-ux500/cpu.c                  |  1 -
 arch/arm/mach-ux500/platsmp.c              |  2 +-
 arch/arm/mach-ux500/setup.h                |  3 --
 arch/arm/mach-ux500/timer.c                | 48 -------------------------
 arch/arm/mach-vexpress/Kconfig             |  3 +-
 arch/arm/mach-vexpress/core.h              |  2 +-
 arch/arm/mach-vexpress/platsmp.c           |  2 +-
 arch/arm/mach-zx/Kconfig                   |  3 +-
 arch/arm/mach-zx/platsmp.c                 |  2 +-
 arch/arm/mach-zynq/Kconfig                 |  3 +-
 arch/arm/mach-zynq/common.h                |  2 +-
 arch/arm/mach-zynq/platsmp.c               |  2 +-
 drivers/clocksource/clksrc-dbx500-prcmu.c  |  9 +++--
 drivers/staging/board/armadillo800eva.c    |  2 +-
 drivers/staging/board/kzm9d.c              |  2 +-
 include/linux/clksrc-dbx500-prcmu.h        | 20 -----------
 107 files changed, 196 insertions(+), 242 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shmobile/irqs.h
 delete mode 100644 arch/arm/mach-ux500/timer.c
 delete mode 100644 include/linux/clksrc-dbx500-prcmu.h
