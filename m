From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 12:48:00 -0600
Subject: [GIT PULL V2 5/7] ARM: tegra: for-3.6/boards branch
In-Reply-To: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
References: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341600482-11020-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains changes to Tegra board files, and related Kconfig and
Makefile changes. Highlights include:

* Removal of Seaboard/Springbank board files; these boards can now only be
  used with device tree.

* Use of small parts of some non-DT board files from the DT board files. This
  enables all features that the non-DT board files have, when booting from DT.
  This will allow almost complete removal of all non-DT board files in v3.7.

* Other miscellaneous changes.

This branch is based on Tegra's for-3.6/cleanup branch from a previous pull
request.

This branch is not included in a later pull request.

Note that there will be a merge conflict between for-3.6/{dt,boards}. The
expected resolution may be found in branch for-3.6/merged-dt-boards.

----------------------------------------------------------------

The following changes since commit 702b0e4f2f2782962aab7d9a0a40ad68770bb1f6:

  ARM: dt: tegra: rename board files to match SoC

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/boards

for you to fetch changes up to 2553dcc6e603e3833990bd3a29bee98d1dbdf251:

  ARM: tegra: use of_default_bus_match_table

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: add device tree AUXDATA for APBDMA

Stephen Warren (7):
      ARM: tegra: make .dts compilation depend on Tegra2 support
      ARM: tegra: remove CONFIG_MACH_TEGRA_DT
      ARM: tegra: remove Seaboard board files
      ARM: tegra: trimslice: enable PCIe when booting from device tree
      ARM: tegra: harmony: init regulators, PCIe when booting from DT
      ARM: tegra: paz00: enable WiFi rfkill when booting from device tree
      ARM: tegra: use of_default_bus_match_table

 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-tegra/Kconfig                 |   36 ---
 arch/arm/mach-tegra/Makefile                |   13 +-
 arch/arm/mach-tegra/Makefile.boot           |   10 +-
 arch/arm/mach-tegra/board-dt-tegra20.c      |   74 +++++-
 arch/arm/mach-tegra/board-dt-tegra30.c      |    8 +-
 arch/arm/mach-tegra/board-harmony-pcie.c    |   15 +-
 arch/arm/mach-tegra/board-harmony-power.c   |   25 ++-
 arch/arm/mach-tegra/board-paz00.c           |    7 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c |  197 --------------
 arch/arm/mach-tegra/board-seaboard.c        |  306 ----------------------
 arch/arm/mach-tegra/board-seaboard.h        |   47 ----
 arch/arm/mach-tegra/board.h                 |    9 +
 13 files changed, 127 insertions(+), 621 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-seaboard-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-seaboard.c
 delete mode 100644 arch/arm/mach-tegra/board-seaboard.h
