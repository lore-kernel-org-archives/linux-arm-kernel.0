From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:45 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Koelsch Board Removal Updates for
 v3.19
Message-ID: <cover.1415059146.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC koelsch board removal updates for v3.19.

This pull request is based on a merge of:

* "Renesas ARM Based SoC DT DU Updates for v3.19",
  tagged as renesas-dt-du-for-v3.19.

* "Renesas ARM Based SoC DT Cleanups Updates for v3.19",
  tagged as renesas-dt-cleanups-for-v3.19.

Both of which I have also sent a pull-request for.


The following changes since commit 11886d1158e0dc123283891b662381f629ab47a0:

  Merge tag 'renesas-dt-cleanups-for-v3.19' into koelsch-board-removal-for-v3.19.base (2014-10-30 10:14:38 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-koelsch-board-removal-for-v3.19

for you to fetch changes up to 79e69d179cb3391040a3693fca8bc12ec03c05fc:

  ARM: shmobile: koelsch dts: Drop console= bootargs parameter (2014-10-30 10:18:31 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Koelsch Board Removal Updates for v3.19

* Remove lecacy C koelsh board support

----------------------------------------------------------------
Geert Uytterhoeven (3):
      MAINTAINERS: Remove reference to shmobile / koelsch_defconfig
      ARM: dts: koelsch: Stop building r8a7791-koelsch.dtb in legacy builds
      ARM: shmobile: koelsch dts: Drop console= bootargs parameter

Laurent Pinchart (4):
      ARM: shmobile: Remove shmobile_clk_workaround() implementation
      ARM: shmobile: koelsch: Remove legacy C board code
      ARM: shmobile: r8a7791: Remove legacy code
      ARM: shmobile: koelsch: Remove reference board code

 MAINTAINERS                                      |   1 -
 arch/arm/boot/dts/Makefile                       |   1 -
 arch/arm/boot/dts/r8a7791-koelsch.dts            |   2 +-
 arch/arm/configs/koelsch_defconfig               | 113 -----
 arch/arm/configs/shmobile_defconfig              |   1 -
 arch/arm/mach-shmobile/Kconfig                   |  19 -
 arch/arm/mach-shmobile/Makefile                  |   5 +-
 arch/arm/mach-shmobile/Makefile.boot             |   1 -
 arch/arm/mach-shmobile/board-koelsch-reference.c |  40 --
 arch/arm/mach-shmobile/board-koelsch.c           | 523 -----------------------
 arch/arm/mach-shmobile/clock-r8a7791.c           | 338 ---------------
 arch/arm/mach-shmobile/clock.c                   |  32 +-
 arch/arm/mach-shmobile/clock.h                   |  14 -
 arch/arm/mach-shmobile/r8a7791.h                 |   3 -
 arch/arm/mach-shmobile/setup-r8a7791.c           | 181 +-------
 15 files changed, 6 insertions(+), 1268 deletions(-)
 delete mode 100644 arch/arm/configs/koelsch_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-koelsch-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-koelsch.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7791.c
