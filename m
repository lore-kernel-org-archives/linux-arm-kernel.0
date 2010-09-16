From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 16 Sep 2010 18:53:33 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
Message-ID: <cover.1284655723.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches enable PCI Express support on Tegra2.
The implementation is based on original NVidia code from (1), but it
is heavily reworked to avoid custom PCI enumeration and make the code
more Linux friendly.

This implementation assumes that the PCIe subsystem is fully powered
and ungated by the bootloader.

[1] git://nv-tegra.nvidia.com/linux-2.6.git

The following changes since commit 9c03f1622af051004416dd3e24d8a0fa31e34178:
  Linus Torvalds (1):
        Merge ssh://master.kernel.org/home/hpa/tree/sec

Mike Rapoport (3):
      [ARM] tegra: add PCI Express clocks
      [ARM] tegra: add PCI Express support
      [ARM] tegra: harmony: enable PCI Express

 arch/arm/mach-tegra/Kconfig                 |    4 +
 arch/arm/mach-tegra/Makefile                |    2 +
 arch/arm/mach-tegra/board-harmony-pcie.c    |   52 ++
 arch/arm/mach-tegra/board.h                 |    1 +
 arch/arm/mach-tegra/include/mach/hardware.h |    4 +
 arch/arm/mach-tegra/pcie.c                  |  889 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra2_clocks.c         |   76 +++-
 7 files changed, 1025 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
 create mode 100644 arch/arm/mach-tegra/pcie.c
