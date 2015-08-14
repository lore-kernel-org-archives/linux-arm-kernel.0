From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Aug 2015 16:48:38 +0200
Subject: [GIT PULL 7/9] ARM: tegra: Memory controller updates for v4.3-rc1
In-Reply-To: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1439563720-13189-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-memory

for you to fetch changes up to 588c43a7bd5a53ae523b318e1db16bdd59963a3c:

  memory: tegra: Add Tegra210 support (2015-08-13 16:07:52 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Memory controller updates for v4.3-rc1

Adds support for Tegra210, which allows the SMMU to be used on this new
SoC generation.

----------------------------------------------------------------
Paul Walmsley (1):
      memory: tegra: Add support for a variable-size client ID bitfield

Thierry Reding (2):
      memory: tegra: Expose supported rates via debugfs
      memory: tegra: Add Tegra210 support

 drivers/iommu/Kconfig                    |    2 +-
 drivers/memory/tegra/Makefile            |    1 +
 drivers/memory/tegra/mc.c                |    8 +-
 drivers/memory/tegra/mc.h                |    4 +
 drivers/memory/tegra/tegra114.c          |    1 +
 drivers/memory/tegra/tegra124-emc.c      |   42 +-
 drivers/memory/tegra/tegra124.c          |    2 +
 drivers/memory/tegra/tegra210.c          | 1080 ++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra30.c           |    1 +
 include/dt-bindings/memory/tegra210-mc.h |   36 +
 include/soc/tegra/mc.h                   |    2 +
 11 files changed, 1174 insertions(+), 5 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra210.c
 create mode 100644 include/dt-bindings/memory/tegra210-mc.h
