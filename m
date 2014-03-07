From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 13:28:06 -0700
Subject: [GIT PULL 3/5] ARM: tegra: core SoC changes for 3.15
In-Reply-To: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
References: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394224088-28910-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of minor fixes, plus the removal of the EMC scaling driver,
which hasn't been active since we converted clocks to device tree.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.15-soc

for you to fetch changes up to 357281ed092ac5713137fa42b447cdd68a4aa56e:

  ARM: tegra: Export I/O rail functions

----------------------------------------------------------------

Stefan Agner (1):
      ARM: tegra: don't timeout if CPU is powergated

Stephen Warren (1):
      ARM: tegra: remove tegra EMC scaling driver

Thierry Reding (1):
      ARM: tegra: Export I/O rail functions

 arch/arm/mach-tegra/Makefile     |   1 -
 arch/arm/mach-tegra/platsmp.c    |   2 +-
 arch/arm/mach-tegra/powergate.c  |   2 +
 arch/arm/mach-tegra/tegra2_emc.c | 347 ----------------------------------
 arch/arm/mach-tegra/tegra2_emc.h |  24 ---
 5 files changed, 3 insertions(+), 373 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/tegra2_emc.c
 delete mode 100644 arch/arm/mach-tegra/tegra2_emc.h
