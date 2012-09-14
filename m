From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:13 -0600
Subject: [GIT PULL 02/10] ARM: tegra: first round of cleanup
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a few early cleanups; consistent use of IO_ADDRESS,
always selecting USE_OF since we're converting to device-tree-only this
merge window, and removing includes of some header files as part of
working towards single zImage.

This branch is based on v3.6-rc4.

----------------------------------------------------------------

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-cleanup

for you to fetch changes up to a5b64ce64d6bdceecd45a07893affbf88d7bb7d2:

  mmc: tegra: remove useless include of <mach/*.h>

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: use IO_ADDRESS for getting virtual address

Stephen Warren (3):
      ARM: tegra: remove duplicate select USE_OF
      gpio: tegra: remove useless includes of <mach/*.h>
      mmc: tegra: remove useless include of <mach/*.h>

 arch/arm/mach-tegra/Kconfig    |    1 -
 arch/arm/mach-tegra/apbio.c    |    4 ++--
 arch/arm/mach-tegra/fuse.c     |    4 ++--
 drivers/gpio/gpio-tegra.c      |    3 ---
 drivers/mmc/host/sdhci-tegra.c |    1 -
 5 files changed, 4 insertions(+), 9 deletions(-)
