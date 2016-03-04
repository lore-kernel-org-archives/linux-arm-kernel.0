From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  4 Mar 2016 15:56:59 +0100
Subject: [GIT PULL 1/3] ARM: tegra: Core SoC changes for v4.6-rc1
Message-ID: <1457103421-26006-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.6-soc

for you to fetch changes up to 50ca629d08c7141056cdfac573d1cf28d2abe639:

  dt-bindings: Update NVIDIA PMC for Tegra (2016-03-02 18:00:30 +0100)

----------------------------------------------------------------
ARM: tegra: Core SoC changes for v4.6-rc1

This set of patches contains a slew of fixes and cleanups in preparation
for moving Tegra to generic power domains.

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
