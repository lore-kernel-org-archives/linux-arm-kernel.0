From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:34 +0200
Subject: [GIT PULL 2/8] ARM: tegra: Memory controller updates for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-memory

for you to fetch changes up to 6f0a4d0c26f17e93f296e43c7b9f44733ea188ae:

  memory: tegra: Disable ARBITRATION_EMEM interrupt (2015-05-04 15:09:36 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Memory controller updates for v4.2-rc1

Adds support for Tegra132 (which is mostly the same as for Tegra124,
except for cache maintenance). debugfs support is also introduced for
the SMMU part of the memory controller, which allows users to inspect
the translation state for SWGROUPs and memory clients.

----------------------------------------------------------------
Thierry Reding (3):
      memory: tegra: Add SWGROUP names
      iommu/tegra-smmu: Add debugfs support
      memory: tegra: Add Tegra132 support

Tomeu Vizoso (1):
      memory: tegra: Disable ARBITRATION_EMEM interrupt

 drivers/iommu/Kconfig           |   2 +-
 drivers/iommu/tegra-smmu.c      | 109 ++++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/Makefile   |   1 +
 drivers/memory/tegra/mc.c       |   7 ++-
 drivers/memory/tegra/mc.h       |   4 ++
 drivers/memory/tegra/tegra114.c |  32 ++++++------
 drivers/memory/tegra/tegra124.c |  79 ++++++++++++++++++++---------
 drivers/memory/tegra/tegra30.c  |  32 ++++++------
 include/soc/tegra/mc.h          |   6 +++
 9 files changed, 214 insertions(+), 58 deletions(-)
