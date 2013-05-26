From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 May 2013 16:16:59 +0200
Subject: [GIT PULL] ARM SoC cleanups for 3.11
Message-ID: <20130526141659.GA9394@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here the pull request with the cleanup patches that I sent a few weeks
ago about init_irq and map_io cleanups for platforms that were using the
generic functions for both these callbacks.

Please consider pulling it.

Thanks,
Maxime

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/arm-soc-cleanups-for-3.11

for you to fetch changes up to 442f15083eb25229fb95820bced8bea70298a34b:

  ARM: sunxi: Remove the .map_io function declaration (2013-05-24 10:24:43 +0200)

----------------------------------------------------------------
Cleanups in various machine definitions
  - Patches to remove the .init_irq definition when using irqchip_init
  - Make the ARM core code call debug_ll_io_init when no map_io callback is
    declared
  - Remove the .map_io definition in the various machines using it

----------------------------------------------------------------
Maxime Ripard (10):
      ARM: nomadik: Remove init_irq declaration in machine description
      ARM: spear: Remove init_irq declaration in machine description
      ARM: sirf: Remove init_irq declaration in machine description
      ARM: vexpress: Remove init_irq declaration in machine description
      ARM: virt: Remove init_irq declaration in machine description
      ARM: vt8500: Remove init_irq declaration in machine description
      ARM: mmu: Call debug_ll_io_init if no map_io function is specified
      ARM: highbank: remove the .map_io declaration
      ARM: mxs: remove the .map_io declaration
      ARM: sunxi: Remove the .map_io function declaration

 arch/arm/mach-highbank/highbank.c |  1 -
 arch/arm/mach-mxs/mach-mxs.c      |  1 -
 arch/arm/mach-nomadik/cpu-8815.c  |  2 --
 arch/arm/mach-prima2/common.c     |  4 ----
 arch/arm/mach-spear/spear1310.c   |  2 --
 arch/arm/mach-spear/spear1340.c   |  2 --
 arch/arm/mach-spear/spear300.c    |  2 --
 arch/arm/mach-spear/spear310.c    |  2 --
 arch/arm/mach-spear/spear320.c    |  2 --
 arch/arm/mach-spear/spear6xx.c    |  2 --
 arch/arm/mach-sunxi/sunxi.c       | 17 -----------------
 arch/arm/mach-sunxi/sunxi.h       | 20 --------------------
 arch/arm/mach-vexpress/v2m.c      |  2 --
 arch/arm/mach-virt/virt.c         |  2 --
 arch/arm/mach-vt8500/vt8500.c     |  2 --
 arch/arm/mm/mmu.c                 |  2 ++
 16 files changed, 2 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/sunxi.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
