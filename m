From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:54 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Boards Cleanups for v3.17
Message-ID: <cover.1406166426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC boards cleanups for v3.17.


This pull request is based on
"Renesas ARM Based SoC DT Timers Updates for v3.17",
tagged as renesas-dt-timers-for-v3.17,
which I have sent a pull request for.

In this pull-request cleanups are added on top of new development
due to the order in which the code was developed. In general
we prefer the reverse ordering.


v2 of this pull request is a rebase of v1 removing
a merge of defconfig changes at the base of the pull-request.
The motivation for that was to avoid attempts to use
genmai_defconfig after the board code it relies on has been removed.
Olof indicated he would prefer not to add that dependency.


The following changes since commit 9394af4314554d15762585a3464cefaa2e6d0420:

  ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-07-15 21:26:42 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-boards-for-v3.17

for you to fetch changes up to d2904bb7cd21844ff5e720083b59a344487fcc9b:

  ARM: shmobile: r7s72100: Remove legacy board support (2014-07-24 10:32:53 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Cleanups for v3.17

d2904bb ARM: shmobile: r7s72100: Remove legacy board support
6f86033 ARM: shmobile: r7s72100: genmai: Remove legacy board file
5cebb8e ARM: shmobile: r7s72100: genmai: Remove reference board file

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
