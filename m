From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Dec 2017 17:12:52 +0100
Subject: [GIT PULL v2 2/5] soc/tegra: Changes for v4.16-rc1
In-Reply-To: <20171220191900.757-2-thierry.reding@gmail.com>
References: <20171220191900.757-2-thierry.reding@gmail.com>
Message-ID: <20171221161252.12920-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-soc-2

for you to fetch changes up to ccf151847b81a3ad779b64f5f71f0632f2009eb6:

  soc/tegra: fuse: Explicitly request DMA channel from APB DMA driver (2017-12-21 17:04:12 +0100)

This includes two additional patches that have been sitting in patchwork
for a long time and that I had forgotten to include. Please ignore the
first pull request and pull this instead.

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v4.16-rc1

Fuse and chip ID support for Tegra186 is added in this set of changes,
followed by some unification work for the PMC driver in order to avoid
code duplication between Tegra186 and prior chips.

This also contains a couple of fixes for reading fuses on Tegra20.

----------------------------------------------------------------
Dmitry Osipenko (2):
      soc/tegra: fuse: Fix reading registers using DMA on Tegra20
      soc/tegra: fuse: Explicitly request DMA channel from APB DMA driver

Thierry Reding (7):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      Merge branch 'for-4.16/dt-bindings' into for-4.16/soc
      soc/tegra: fuse: Move register mapping check
      soc/tegra: fuse: Warn if accessing unmapped registers
      soc/tegra: fuse: Add Tegra186 chip ID support
      soc/tegra: pmc: Parameterize driver
      soc/tegra: pmc: Consolidate Tegra186 support

Timo Alho (1):
      soc/tegra: fuse: Add Tegra186 support

 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +
 drivers/soc/tegra/Kconfig                          |   5 +-
 drivers/soc/tegra/Makefile                         |   1 -
 drivers/soc/tegra/fuse/fuse-tegra.c                |   4 +
 drivers/soc/tegra/fuse/fuse-tegra20.c              |  13 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  24 +-
 drivers/soc/tegra/fuse/fuse.h                      |   4 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |  11 +-
 drivers/soc/tegra/pmc-tegra186.c                   | 169 ------------
 drivers/soc/tegra/pmc.c                            | 304 +++++++++++++++++----
 include/soc/tegra/pmc.h                            |  12 +
 11 files changed, 322 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 delete mode 100644 drivers/soc/tegra/pmc-tegra186.c
