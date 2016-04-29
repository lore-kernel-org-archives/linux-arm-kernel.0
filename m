From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 18:21:06 +0200
Subject: [GIT PULL] soc/tegra: Add generic PM domain support
Message-ID: <1461946869-26124-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC maintainers,

The following changes since commit 605aa5e48bfc3dbf0272bc4aac8674e06c19c1b3:

  dt-bindings: Update NVIDIA PMC for Tegra (2016-04-05 15:22:54 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-genpd

for you to fetch changes up to a38045121bf42110e6043d07315a7626b021a0db:

  soc/tegra: pmc: Add generic PM domain support (2016-04-29 17:17:47 +0200)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Add generic PM domain support

Implements generic PM domain support on top of the existing Tegra power-
gate API. Drivers are thus allowed to move away from the Tegra-specific
API and towards using generic power domains directly.

----------------------------------------------------------------
Jon Hunter (2):
      dt-bindings: Add power domain info for NVIDIA PMC
      soc/tegra: pmc: Add generic PM domain support

Thierry Reding (1):
      Merge branch 'for-4.7/soc' into for-4.7/genpd

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  80 ++++
 drivers/soc/tegra/pmc.c                            | 485 ++++++++++++++++++---
 include/soc/tegra/pmc.h                            |   1 +
 3 files changed, 505 insertions(+), 61 deletions(-)
