From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Dec 2017 20:18:57 +0100
Subject: [GIT PULL 2/5] soc/tegra: Changes for v4.16-rc1
In-Reply-To: <20171220191900.757-1-thierry.reding@gmail.com>
References: <20171220191900.757-1-thierry.reding@gmail.com>
Message-ID: <20171220191900.757-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-soc

for you to fetch changes up to c641ec6eab8587a78160d37f085a5ed6e542ca88:

  soc/tegra: pmc: Consolidate Tegra186 support (2017-12-13 13:06:44 +0100)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v4.16-rc1

Fuse and chip ID support for Tegra186 is added in this set of changes,
followed by some unification work for the PMC driver in order to avoid
code duplication between Tegra186 and prior chips.

----------------------------------------------------------------
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
 drivers/soc/tegra/fuse/fuse-tegra.c                |   3 +
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  24 +-
 drivers/soc/tegra/fuse/fuse.h                      |   4 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |  11 +-
 drivers/soc/tegra/pmc-tegra186.c                   | 169 ------------
 drivers/soc/tegra/pmc.c                            | 304 +++++++++++++++++----
 include/soc/tegra/pmc.h                            |  12 +
 10 files changed, 310 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 delete mode 100644 drivers/soc/tegra/pmc-tegra186.c
