From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 13:07:57 -0600
Subject: [GIT PULL 2/6] ARM: tegra: cleanup for 3.13
In-Reply-To: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
References: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1382036881-23339-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch mainly removes dead code and defines that were useful only
when booting using board files. A few other misc cleanups are also
included.

This branch is based on previous pull request
tegra-for-3.13-deps-for-arm-init-time-cleanup.

----------------------------------------------------------------

The following changes since commit d2207071b3c74b144a860cbe6a46496a44963972:

  ARM: tegra: split tegra_pmc_init() in two

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.13-cleanup

for you to fetch changes up to b6bda4e0d23815cb711c16085e03cb23c6d49f21:

  ARM: tegra: fix ARCH_TEGRA_114_SOC select sort order

----------------------------------------------------------------

Stephen Warren (7):
      ARM: tegra: remove common.c
      ARM: tegra: delete stale header content
      ARM: tegra: delete gpio-names.h
      ARM: tegra: move resume vector define to irammap.h
      ARM: tegra: remove much of iomap.h
      ARM: tegra: make tegra_init_fuse() __init
      ARM: tegra: fix ARCH_TEGRA_114_SOC select sort order

 arch/arm/mach-tegra/Kconfig         |   2 +-
 arch/arm/mach-tegra/Makefile        |   1 -
 arch/arm/mach-tegra/board-paz00.c   |   5 +-
 arch/arm/mach-tegra/board-paz00.h   |  25 ----
 arch/arm/mach-tegra/board.h         |  12 --
 arch/arm/mach-tegra/common.c        | 113 --------------
 arch/arm/mach-tegra/fuse.c          |   2 +-
 arch/arm/mach-tegra/gpio-names.h    | 247 -------------------------------
 arch/arm/mach-tegra/iomap.h         | 152 -------------------
 arch/arm/mach-tegra/irammap.h       |   6 +
 arch/arm/mach-tegra/pm.c            |   8 +-
 arch/arm/mach-tegra/pm.h            |   3 -
 arch/arm/mach-tegra/pmc.c           |   9 ++
 arch/arm/mach-tegra/pmc.h           |   4 +
 arch/arm/mach-tegra/reset.c         |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S |   5 +-
 arch/arm/mach-tegra/sleep-tegra30.S |   5 +-
 arch/arm/mach-tegra/tegra.c         |  67 ++++++++-
 18 files changed, 99 insertions(+), 569 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-paz00.h
 delete mode 100644 arch/arm/mach-tegra/common.c
 delete mode 100644 arch/arm/mach-tegra/gpio-names.h
