From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Jul 2014 08:59:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Cleanups Updates for v3.17
Message-ID: <cover.1405641497.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC Boards Cleanups updates for v3.17.

This pull request is based on a merge of:

* "Fourth Round of Renesas ARM Based SoC Defconfig Updates for v3.17",
  tagged as renesas-defconfig4-for-v3.17,
  which I have sent a pull request for.

  The reason for this dependency is to avoid attempts to use
  genmai_defconfig after the board code it relies on has been removed.

* "Renesas ARM Based SoC DT Timers Updates for v3.17",
  tagged as renesas-dt-timers-for-v3.17,
  which I have sent a pull request for.


The following changes since commit b34fd6184cf689db8570d89c66b9ab9742c3e813:

  Merge branch 'defconfig-for-v3.17' into cleanup-boards-for-v3.17.base (2014-07-17 00:03:15 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-boards-for-v3.17

for you to fetch changes up to 53b04e7fb3b28517ff86a7ac9fcff86101fe6d5a:

  ARM: shmobile: r7s72100: Remove legacy board support (2014-07-17 00:14:44 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Cleanups for v3.17

Remove Genmai board code

----------------------------------------------------------------
Laurent Pinchart (3):
      ARM: shmobile: r7s72100: genmai: Remove reference board file
      ARM: shmobile: r7s72100: genmai: Remove legacy board file
      ARM: shmobile: r7s72100: Remove legacy board support

 arch/arm/mach-shmobile/Kconfig                  |  17 --
 arch/arm/mach-shmobile/Makefile                 |   3 -
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-genmai-reference.c |  35 ----
 arch/arm/mach-shmobile/board-genmai.c           | 174 ------------------
 arch/arm/mach-shmobile/clock-r7s72100.c         | 231 ------------------------
 arch/arm/mach-shmobile/r7s72100.h               |   6 -
 arch/arm/mach-shmobile/setup-r7s72100.c         |   2 -
 8 files changed, 469 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-genmai.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
 delete mode 100644 arch/arm/mach-shmobile/r7s72100.h
