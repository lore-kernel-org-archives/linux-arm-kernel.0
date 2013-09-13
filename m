From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:04 -0600
Subject: [PATCH 0/7] ARM: tegra: various misc cleanups
Message-ID: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A bunch of cleanups for arch/arm/mach-tegra, mostly just deleting
stale code.

Stephen Warren (7):
  ARM: tegra: remove common.c
  ARM: tegra: delete stale header content
  ARM: tegra: delete gpio-names.h
  ARM: tegra: move resume vector define to irammap.h
  ARM: tegra: remove much of iomap.h
  ARM: tegra: remove tegra_chip_uid()
  ARM: tegra: make tegra_init_fuse() __init

 arch/arm/mach-tegra/Makefile        |   1 -
 arch/arm/mach-tegra/board-paz00.c   |   5 +-
 arch/arm/mach-tegra/board-paz00.h   |  25 ----
 arch/arm/mach-tegra/board.h         |  12 --
 arch/arm/mach-tegra/common.c        | 113 -----------------
 arch/arm/mach-tegra/fuse.c          |  12 +-
 arch/arm/mach-tegra/gpio-names.h    | 247 ------------------------------------
 arch/arm/mach-tegra/iomap.h         | 152 ----------------------
 arch/arm/mach-tegra/irammap.h       |   6 +
 arch/arm/mach-tegra/pm.c            |   8 +-
 arch/arm/mach-tegra/pm.h            |   3 -
 arch/arm/mach-tegra/pmc.c           |   9 ++
 arch/arm/mach-tegra/pmc.h           |   4 +
 arch/arm/mach-tegra/reset.c         |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S |   5 +-
 arch/arm/mach-tegra/sleep-tegra30.S |   5 +-
 arch/arm/mach-tegra/tegra.c         |  67 +++++++++-
 17 files changed, 98 insertions(+), 578 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-paz00.h
 delete mode 100644 arch/arm/mach-tegra/common.c
 delete mode 100644 arch/arm/mach-tegra/gpio-names.h

-- 
1.8.1.5
