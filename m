From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 May 2011 17:40:11 +0200
Subject: [GIT PULL] GIC FastEOI changes for 2.6.40
Message-ID: <1305128411.2252.5.camel@craptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull the following for 2.6.40? There are some patches
included here from Colin and Santosh which are related to the FastEOI
GIC changes so they have asked me to carry them along with the rest of
the platform changes.

Thanks,

Will



The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca876f:
  Linus Torvalds (1):
        Linux 2.6.39-rc7

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git gic-fasteoi

Colin Cross (4):
      ARM: tegra: irq: convert to gic arch extensions
      ARM: tegra: irq: Remove PM support
      ARM: tegra: irq: Move legacy_irq.c into irq.c
      ARM: tegra: irq: Add tegra_eoi

Santosh Shilimkar (1):
      ARM: GIC: Convert GIC library to use the IO relaxed operations

Will Deacon (6):
      ARM: omap: update GPIO chained IRQ handler to use entry/exit functions
      ARM: s5pv310: update IRQ combiner to use chained entry/exit functions
      ARM: msm: update GPIO chained IRQ handler to use entry/exit functions
      ARM: nmk: update GPIO chained IRQ handler to entry/exit functions
      ARM: tegra: update GPIO chained IRQ handler to use entry/exit functions
      ARM: gic: use handle_fasteoi_irq for SPIs

 arch/arm/common/gic.c                         |   84 +++++-----
 arch/arm/mach-exynos4/irq-combiner.c          |    6 +-
 arch/arm/mach-msm/gpio-v2.c                   |   10 +-
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/gpio.c                    |    9 +-
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   35 ----
 arch/arm/mach-tegra/irq.c                     |  174 +++++++++------------
 arch/arm/mach-tegra/legacy_irq.c              |  215 -------------------------
 arch/arm/plat-nomadik/gpio.c                  |   12 +-
 arch/arm/plat-omap/gpio.c                     |    7 +-
 10 files changed, 144 insertions(+), 410 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/legacy_irq.h
 delete mode 100644 arch/arm/mach-tegra/legacy_irq.c
