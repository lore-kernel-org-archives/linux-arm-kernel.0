From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:10 -0700
Subject: [GIT PULL 08/10] ARM: tegra: SoC-specific core code changes
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains various miscellaneous changes to code in the
mach-tegra/ directory. It is baased on v3.13-rc1, and shouldn't conflict
with anything else.

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-soc

for you to fetch changes up to 7e1161f8af73f0077aa80c1af671d272ed14f37a:

  ARM: tegra: select PINCTRL_TEGRA124 for Tegra124 SoC

----------------------------------------------------------------

Alexandre Courbot (1):
      ARM: tegra: switch FUSE clock on before usage

Laxman Dewangan (1):
      ARM: tegra: select PINCTRL_TEGRA124 for Tegra124 SoC

Stephen Warren (3):
      ARM: tegra: fix DEBUG_LL combined with LPAE
      ARM: tegra: don't hard-code DEBUG_LL baud rate
      ARM: tegra: use section-sized static mappings for LPAE too

 arch/arm/include/debug/tegra.S | 34 +++++-------------------------
 arch/arm/mach-tegra/Kconfig    |  1 +
 arch/arm/mach-tegra/fuse.c     | 41 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/iomap.h    | 14 ++++++-------
 arch/arm/mach-tegra/tegra.c    |  4 +---
 5 files changed, 54 insertions(+), 40 deletions(-)
