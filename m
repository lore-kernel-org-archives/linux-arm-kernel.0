From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:42:01 +0200
Subject: [GIT PULL 1/3] soc/tegra: Changes for v4.7-rc1
Message-ID: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-soc

for you to fetch changes up to 605aa5e48bfc3dbf0272bc4aac8674e06c19c1b3:

  dt-bindings: Update NVIDIA PMC for Tegra (2016-04-05 15:22:54 +0200)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v4.7-rc1

This contains a bunch of preparatory patches to the PMC driver which are
a prerequisite to moving the driver to generic power domains.

----------------------------------------------------------------
Jon Hunter (14):
      soc/tegra: pmc: Add missing structure members to kernel-doc
      soc/tegra: pmc: Fix sparse warning for tegra_pmc_init_tsense_reset()
      soc/tegra: pmc: Remove debugfs entry on probe failure
      soc/tegra: pmc: Remove non-existing power partitions for Tegra210
      soc/tegra: pmc: Remove non-existing L2 partition for Tegra124
      soc/tegra: pmc: Restore base address on probe failure
      soc/tegra: pmc: Protect public functions from potential race conditions
      soc/tegra: pmc: Change powergate and rail IDs to be an unsigned type
      soc/tegra: pmc: Fix testing of powergate state
      soc/tegra: pmc: Fix verification of valid partitions
      soc/tegra: pmc: Remove additional check for a valid partition
      soc/tegra: pmc: Ensure GPU partition can be toggled on/off by PMC
      soc/tegra: pmc: Wait for powergate state to change
      dt-bindings: Update NVIDIA PMC for Tegra

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  12 +-
 arch/arm/mach-tegra/platsmp.c                      |  16 +--
 drivers/gpu/drm/tegra/drm.h                        |   2 +-
 drivers/soc/tegra/pmc.c                            | 150 +++++++++++++--------
 include/soc/tegra/pmc.h                            |  35 ++---
 5 files changed, 124 insertions(+), 91 deletions(-)
