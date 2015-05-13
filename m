From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:37 +0200
Subject: [GIT PULL 5/8] ARM: tegra: Add EMC driver for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-6-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-emc

for you to fetch changes up to 9c77a81f215bfeee8f96c50c8ab27dbebffec80d:

  memory: tegra: Add EMC frequency debugfs entry (2015-05-05 11:39:48 +0200)

I've based this pull request on top of the tegra-for-4.2-ramcode pull
request, so pulling only this one should be sufficient to resolve the
dependency.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Add EMC driver for v4.2-rc1

This introduces the EMC driver that's required to scale the external
memory frequency.

----------------------------------------------------------------
Mikko Perttunen (5):
      soc/tegra: fuse: Add RAM code reader helper
      of: Add Tegra124 EMC bindings
      memory: tegra: Add API needed by the EMC driver
      memory: tegra: Add EMC (external memory controller) driver
      memory: tegra: Add EMC frequency debugfs entry

Thierry Reding (1):
      Merge branch 'for-4.2/ramcode' into for-4.2/emc

Tomeu Vizoso (2):
      of: Document long-ram-code property in nvidia,tegra20-apbmisc
      of: Document timings subnode of nvidia,tegra-mc

 .../memory-controllers/nvidia,tegra-mc.txt         |   84 +-
 .../bindings/memory-controllers/tegra-emc.txt      |  374 +++++++
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    2 +
 drivers/memory/tegra/Kconfig                       |   10 +
 drivers/memory/tegra/Makefile                      |    2 +
 drivers/memory/tegra/mc.c                          |  136 +++
 drivers/memory/tegra/tegra124-emc.c                | 1140 ++++++++++++++++++++
 drivers/memory/tegra/tegra124.c                    |   44 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   21 +
 include/soc/tegra/emc.h                            |   19 +
 include/soc/tegra/fuse.h                           |    1 +
 include/soc/tegra/mc.h                             |   14 +-
 12 files changed, 1844 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
 create mode 100644 drivers/memory/tegra/tegra124-emc.c
 create mode 100644 include/soc/tegra/emc.h
