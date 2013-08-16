From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Aug 2013 00:30:05 -0700
Subject: [GIT PULL 2/2] minimal dra7xx support for v3.12 merge window
In-Reply-To: <pull-1376638205-27268>
Message-ID: <mailman.0.1376638234.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/dra7xx

for you to fetch changes up to cf470a1b1a741bca00080ebc70968b4f22d9b1ea:

  Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)

----------------------------------------------------------------

Minimal DRA7xx based SoC core support via Rajendra Nayak <rnayak@ti.com>

----------------------------------------------------------------
R Sricharan (7):
      ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
      ARM: DRA7: Reuse io tables and add a new .init_early
      ARM: DRA7: Resue the clocksource, clockevent support
      ARM: DRA7: board-generic: Add basic DT support
      ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
      ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
      ARM: DRA7: Add the build support in omap2plus

Rajendra Nayak (1):
      ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5

Tony Lindgren (1):
      Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc

 Documentation/devicetree/bindings/arm/omap/omap.txt |  3 +++
 arch/arm/Kconfig                                    |  2 +-
 arch/arm/configs/omap2plus_defconfig                |  1 +
 arch/arm/mach-omap1/include/mach/soc.h              |  1 +
 arch/arm/mach-omap2/Kconfig                         | 12 ++++++++++--
 arch/arm/mach-omap2/Makefile                        |  6 ++++++
 arch/arm/mach-omap2/board-generic.c                 | 18 ++++++++++++++++++
 arch/arm/mach-omap2/common.h                        |  1 +
 arch/arm/mach-omap2/id.c                            |  4 ++--
 arch/arm/mach-omap2/io.c                            | 20 ++++++++++++++++++--
 arch/arm/mach-omap2/omap54xx.h                      |  4 ++++
 arch/arm/mach-omap2/omap_hwmod.c                    |  2 +-
 arch/arm/mach-omap2/soc.h                           | 17 +++++++++++++++++
 arch/arm/mach-omap2/timer.c                         |  3 ++-
 arch/arm/plat-omap/Kconfig                          |  2 +-
 15 files changed, 86 insertions(+), 10 deletions(-)
