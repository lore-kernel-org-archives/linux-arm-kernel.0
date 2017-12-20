From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Dec 2017 20:18:58 +0100
Subject: [GIT PULL 3/5] memory: tegra: Changes for v4.16-rc1
In-Reply-To: <20171220191900.757-1-thierry.reding@gmail.com>
References: <20171220191900.757-1-thierry.reding@gmail.com>
Message-ID: <20171220191900.757-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-memory

for you to fetch changes up to 83476bfaf6ac1cebf0cc5a3bdcf5031ef875cf42:

  iommu/tegra-smmu: Fix return value check in tegra_smmu_group_get() (2017-12-20 18:32:08 +0100)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v4.16-rc1

The Tegra memory controller driver will now instruct the SMMU driver to
create groups, which will make it easier for device drivers to share an
IOMMU domain between multiple devices.

Initial Tegra186 support is also added in a separate driver.

----------------------------------------------------------------
Thierry Reding (6):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      dt-bindings: memory: Add Tegra186 support
      Merge branch 'for-4.16/dt-bindings' into for-4.16/memory
      memory: tegra: Add Tegra186 support
      memory: tegra: Create SMMU display groups
      iommu/tegra: Allow devices to be grouped

Wei Yongjun (1):
      iommu/tegra-smmu: Fix return value check in tegra_smmu_group_get()

 .../memory-controllers/nvidia,tegra30-mc.txt       |   2 +
 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +
 drivers/iommu/tegra-smmu.c                         | 124 ++++-
 drivers/memory/tegra/Makefile                      |   1 +
 drivers/memory/tegra/tegra114.c                    |  15 +
 drivers/memory/tegra/tegra124.c                    |  17 +
 drivers/memory/tegra/tegra186.c                    | 600 +++++++++++++++++++++
 drivers/memory/tegra/tegra210.c                    |  15 +
 drivers/memory/tegra/tegra30.c                     |  15 +
 include/dt-bindings/memory/tegra186-mc.h           | 111 ++++
 include/soc/tegra/mc.h                             |   9 +
 11 files changed, 917 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 drivers/memory/tegra/tegra186.c
 create mode 100644 include/dt-bindings/memory/tegra186-mc.h
