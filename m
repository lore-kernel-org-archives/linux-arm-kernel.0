From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Nov 2014 12:53:49 +0100
Subject: [GIT PULL 1/4] ARM: tegra: IOMMU support for v3.19
Message-ID: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi ARM SoC maintainers,

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-iommu

for you to fetch changes up to a2257374a4bdc936896262382530921b4953c4cd:

  memory: Add NVIDIA Tegra memory controller support (2014-11-21 10:14:36 +0100)

While preparing these pull requests I noticed that there will be two
tiny conflicts in drivers/memory/tegra-smmu.c between this pull request
and Joerg's IOMMU tree (iommu_ops.map_sg) as well as the driver core
tree (device_driver.owner). They are fairly trivial to resolve so I
didn't see a reason to delay this any further, but if this causes any
problems please let me know if there's anything I can do to help sort
them out.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: IOMMU support for v3.19

This adds the driver pieces required for IOMMU support on Tegra30,
Tegra114 and Tegra124.

----------------------------------------------------------------
Thierry Reding (5):
      clk: tegra: Implement memory-controller clock
      amba: Add Kconfig file
      ARM: tegra: Move AHB Kconfig to drivers/amba
      of: Add NVIDIA Tegra memory controller binding
      memory: Add NVIDIA Tegra memory controller support

 .../memory-controllers/nvidia,tegra-mc.txt         |   36 +
 arch/arm/Kconfig                                   |    3 -
 arch/arm/mach-tegra/Kconfig                        |    9 +-
 arch/arm64/Kconfig                                 |    3 -
 drivers/Kconfig                                    |    2 +
 drivers/amba/Kconfig                               |   14 +
 drivers/clk/tegra/clk-divider.c                    |   13 +
 drivers/clk/tegra/clk-tegra114.c                   |    7 +-
 drivers/clk/tegra/clk-tegra124.c                   |    7 +-
 drivers/clk/tegra/clk-tegra20.c                    |    8 +-
 drivers/clk/tegra/clk-tegra30.c                    |    7 +-
 drivers/clk/tegra/clk.h                            |    2 +
 drivers/iommu/Kconfig                              |   12 +-
 drivers/iommu/tegra-smmu.c                         | 1602 +++++++-------------
 drivers/memory/Kconfig                             |   12 +-
 drivers/memory/Makefile                            |    3 +-
 drivers/memory/tegra/Kconfig                       |    7 +
 drivers/memory/tegra/Makefile                      |    7 +
 drivers/memory/tegra/mc.c                          |  301 ++++
 drivers/memory/tegra/mc.h                          |   53 +
 drivers/memory/tegra/tegra114.c                    |  948 ++++++++++++
 drivers/memory/tegra/tegra124.c                    |  995 ++++++++++++
 drivers/memory/tegra/tegra30.c                     |  970 ++++++++++++
 drivers/memory/tegra30-mc.c                        |  378 -----
 include/dt-bindings/clock/tegra114-car.h           |    2 +-
 include/dt-bindings/clock/tegra124-car.h           |    2 +-
 include/dt-bindings/clock/tegra20-car.h            |    2 +-
 include/dt-bindings/memory/tegra114-mc.h           |   25 +
 include/dt-bindings/memory/tegra124-mc.h           |   31 +
 include/dt-bindings/memory/tegra30-mc.h            |   24 +
 include/soc/tegra/mc.h                             |  107 ++
 31 files changed, 4088 insertions(+), 1504 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra-mc.txt
 create mode 100644 drivers/amba/Kconfig
 create mode 100644 drivers/memory/tegra/Kconfig
 create mode 100644 drivers/memory/tegra/Makefile
 create mode 100644 drivers/memory/tegra/mc.c
 create mode 100644 drivers/memory/tegra/mc.h
 create mode 100644 drivers/memory/tegra/tegra114.c
 create mode 100644 drivers/memory/tegra/tegra124.c
 create mode 100644 drivers/memory/tegra/tegra30.c
 delete mode 100644 drivers/memory/tegra30-mc.c
 create mode 100644 include/dt-bindings/memory/tegra114-mc.h
 create mode 100644 include/dt-bindings/memory/tegra124-mc.h
 create mode 100644 include/dt-bindings/memory/tegra30-mc.h
 create mode 100644 include/soc/tegra/mc.h
