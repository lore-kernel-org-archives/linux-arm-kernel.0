From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:14 -0600
Subject: [GIT PULL 03/10] ARM: tegra: remove board files
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch removes all remaining board files for Tegra; booting is
now through device tree only.

Related, the Harmony DT is augmented with regulators, since this allows
removal of board-harmony-power.c; no other boards had regulator support.
This change depends on an enhancement to the TPS6586x regulator driver,
hence the dependency mentioned below.

This branch is based on v3.6-rc4, followed by a merge of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tps6589x-dt

This branch is a dependency the cleanup2 branch.

----------------------------------------------------------------

The following changes since commit 1ab710fe61b91a2448de9843c746555f9725b9cc:

  Merge commit 'tps6589x-dt' into for-3.7/board-removal

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-board-removal

for you to fetch changes up to be972c3272c354b323afcb7e9552a9b04e675a8b:

  ARM: dt: tegra: harmony: configure power off

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: dt: tegra: harmony: add regulators

Stephen Warren (4):
      ARM: tegra: remove board (but not DT) support for TrimSlice
      ARM: tegra: remove board (but not DT) support for Paz00
      ARM: tegra: remove board (but not DT) support for Harmony
      ARM: dt: tegra: harmony: configure power off

 arch/arm/boot/dts/tegra20-harmony.dts        |  220 +++++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                  |   19 --
 arch/arm/mach-tegra/Makefile                 |   11 +-
 arch/arm/mach-tegra/board-dt-tegra20.c       |   23 +--
 arch/arm/mach-tegra/board-harmony-pcie.c     |   49 +++--
 arch/arm/mach-tegra/board-harmony-pinmux.c   |  156 ---------------
 arch/arm/mach-tegra/board-harmony-power.c    |  156 ---------------
 arch/arm/mach-tegra/board-harmony.c          |  197 ------------------
 arch/arm/mach-tegra/board-harmony.h          |   41 ----
 arch/arm/mach-tegra/board-paz00-pinmux.c     |  156 ---------------
 arch/arm/mach-tegra/board-paz00.c            |  192 ------------------
 arch/arm/mach-tegra/board-paz00.h            |   17 +--
 arch/arm/mach-tegra/board-trimslice-pinmux.c |  155 ---------------
 arch/arm/mach-tegra/board-trimslice.c        |  183 -----------------
 arch/arm/mach-tegra/board-trimslice.h        |   30 ---
 15 files changed, 257 insertions(+), 1348 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-harmony-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-harmony-power.c
 delete mode 100644 arch/arm/mach-tegra/board-harmony.c
 delete mode 100644 arch/arm/mach-tegra/board-harmony.h
 delete mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-trimslice-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-trimslice.c
 delete mode 100644 arch/arm/mach-tegra/board-trimslice.h
