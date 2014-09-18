From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Sep 2014 11:51:30 -0600
Subject: [GIT PULL 1/3] ARM: tegra: core SoC code changes for 3.18
Message-ID: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the primary change here gets its address information from DT rather than
iomap.h. This removes one more user of iomap.h, and will help allow the
code to move to a location that can be shared between arch/arm and
arch/arm64.

An unused header file was also removed.

----------------------------------------------------------------

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.18-soc

for you to fetch changes up to d37aba521379203b740a2929e6e6f6bd2485f5d7:

  ARM: tegra: remove unused tegra_emc.h

----------------------------------------------------------------

Rasmus Villemoes (1):
      ARM: tegra: remove unused tegra_emc.h

Thierry Reding (2):
      of: Add NVIDIA Tegra flow controller bindings
      ARM: tegra: Initialize flow controller from DT

 .../arm/tegra/nvidia,tegra20-flowctrl.txt       | 12 ++++++
 arch/arm/mach-tegra/flowctrl.c                  | 44 ++++++++++++++++----
 arch/arm/mach-tegra/flowctrl.h                  |  2 +
 arch/arm/mach-tegra/tegra.c                     |  2 +
 include/linux/platform_data/tegra_emc.h         | 34 ---------------
 5 files changed, 53 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
 delete mode 100644 include/linux/platform_data/tegra_emc.h
