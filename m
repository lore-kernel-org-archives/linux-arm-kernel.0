From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Feb 2014 17:30:09 -0600
Subject: [GIT PULL] kconfig clean-up and mach-virt removal for 3.15
Message-ID: <CAL_Jsq+vd6XAgj6FawKX4p8Yx0R308mxMxVfzgtNgcBTecx-kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull for 3.15.

BTW, any new platforms for 3.15 will need to either be based on this
or I can clean-up their kconfig entries after they are merged.

Rob

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/kconfig-cleanup-for-3.15

for you to fetch changes up to 4b8b5f25b7485eaf60a40f68451b3b7b741eef59:

  ARM: virt: select ARM_AMBA (2014-02-19 16:47:46 -0600)

----------------------------------------------------------------
- Remove common kconfig options required by multi-platform builds out
of individual platforms as they are redundant.
- Make SMP, CACHE_L2X0 and GPIO config options user visible on
multi-platform builds as most platforms enable these options and all
platforms can run with them enabled.
- Make multi-platform v6 default to more optimal v6k rather than v6
- Remove the last bit of mach-virt and convert it to just a kconfig
option.

----------------------------------------------------------------
Rob Herring (9):
      ARM: centralize common multi-platform kconfig options
      ARM: select HAVE_SMP for V7 multi-platform
      ARM: select MIGHT_HAVE_CACHE_L2X0 for V6 and V7 multi-platform
      ARM: Select V6K instead of V6 by default for multi-platform
      ARM: bcm2835: enable V6K instead of plain V6
      ARM: cns3xxx: enable V6K instead of plain V6
      ARM: vt8500: enable V6K instead of plain V6
      ARM: virt: make mach-virt just a kconfig option
      ARM: virt: select ARM_AMBA

 arch/arm/Kconfig                | 15 ++++++++++++---
 arch/arm/Makefile               |  1 -
 arch/arm/mach-bcm/Kconfig       |  5 -----
 arch/arm/mach-bcm2835/Kconfig   |  4 ----
 arch/arm/mach-berlin/Kconfig    |  4 ----
 arch/arm/mach-cns3xxx/Kconfig   |  3 ---
 arch/arm/mach-highbank/Kconfig  |  7 -------
 arch/arm/mach-hisi/Kconfig      |  4 ----
 arch/arm/mach-imx/Kconfig       | 14 --------------
 arch/arm/mach-keystone/Kconfig  |  4 ----
 arch/arm/mach-moxart/Kconfig    |  5 -----
 arch/arm/mach-mvebu/Kconfig     |  6 ------
 arch/arm/mach-mxs/Kconfig       |  4 ----
 arch/arm/mach-nomadik/Kconfig   |  5 -----
 arch/arm/mach-nspire/Kconfig    |  5 -----
 arch/arm/mach-omap2/Kconfig     | 17 -----------------
 arch/arm/mach-picoxcell/Kconfig |  5 -----
 arch/arm/mach-prima2/Kconfig    |  6 ------
 arch/arm/mach-rockchip/Kconfig  |  3 ---
 arch/arm/mach-shmobile/Kconfig  |  5 -----
 arch/arm/mach-socfpga/Kconfig   |  7 -------
 arch/arm/mach-spear/Kconfig     | 10 ----------
 arch/arm/mach-sti/Kconfig       |  4 ----
 arch/arm/mach-sunxi/Kconfig     |  5 -----
 arch/arm/mach-tegra/Kconfig     |  8 --------
 arch/arm/mach-u300/Kconfig      |  6 ------
 arch/arm/mach-ux500/Kconfig     |  6 ------
 arch/arm/mach-vexpress/Kconfig  |  5 -----
 arch/arm/mach-virt/Kconfig      | 10 ----------
 arch/arm/mach-virt/Makefile     |  5 -----
 arch/arm/mach-virt/virt.c       | 41 -----------------------------------------
 arch/arm/mach-vt8500/Kconfig    |  4 ----
 arch/arm/mach-zynq/Kconfig      |  7 -------
 33 files changed, 12 insertions(+), 228 deletions(-)
 delete mode 100644 arch/arm/mach-virt/Kconfig
 delete mode 100644 arch/arm/mach-virt/Makefile
 delete mode 100644 arch/arm/mach-virt/virt.c
