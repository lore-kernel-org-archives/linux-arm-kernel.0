From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 27 Sep 2010 11:26:31 +0200
Subject: [PATCH v3 0/3] [ARM] tegra: PCI Express support
Message-ID: <cover.1285579189.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches enable PCI Express support on Tegra2.
The implementation is based on original NVidia code from (1), but it
is heavily reworked to avoid custom PCI enumeration and make the code
more Linux friendly.

This implementation assumes that the PCIe subsystem is fully powered
and ungated by the bootloader.

[1] git://nv-tegra.nvidia.com/linux-2.6.git

v3 changes:
   * Fix spelling: s/_OFSET/_OFFSET/
   * Make Harmony PCIe initialization multi-platform friendly
v2 changes:
   * Update PCIe clocks implementation as per Colin and Gary suggestions
   * Update I/O space access as suggested by Arnd and Russell.
   * Remove debug leftovers and unify error reporting

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
  Linus Torvalds (1):
        Linux 2.6.36-rc5

Mike Rapoport (3):
  [ARM] tegra: add PCI Express clocks
  [ARM] tegra: add PCI Express support
  [ARM] tegra: harmony: enable PCI Express

 arch/arm/mach-tegra/Kconfig                 |    4 +
 arch/arm/mach-tegra/Makefile                |    2 +
 arch/arm/mach-tegra/board-harmony-pcie.c    |   57 ++
 arch/arm/mach-tegra/board.h                 |    1 +
 arch/arm/mach-tegra/include/mach/hardware.h |    4 +
 arch/arm/mach-tegra/include/mach/io.h       |   12 +-
 arch/arm/mach-tegra/pcie.c                  |  915 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c         |   46 ++
 8 files changed, 1040 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
 create mode 100644 arch/arm/mach-tegra/pcie.c
