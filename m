From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Jul 2014 09:40:20 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Timers Updates for v3.17
Message-ID: <cover.1405556312.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT Timers updates for v3.17.

This pull request is based on a merge of the following to provide
all dependencies and try to eliminate conflicts. It turns out the changes
in this pull requests are a nexus for dependencies due to modifying DT,
SoC, board and recently moved header files as well as requiring driver
changes.

* The clockevents/renesas-timers-dt branch of Daniel Lezcano's tree.
  He has indicated that this branch has stable commit ids and will
  be included in v3.17. Olof and arm at kernel.org were CCed on the
  thread where he, Laurent Pinchart and I discussed the use of that branch.

  The clockevents/renesas-timers-dt's branch is in turn based on v3.16-rc3.

* "Third Round of Renesas ARM Based SoC DT Updates for v3.17",
  tagged as renesas-dt3-for-v3.17, which I have sent a pull request for.

* "Renesas ARM Based SoC Clock Updates for v3.17",
  tagged as renesas-clock-for-v3.17, which you have merged
  into next/soc

* "Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17",
  tagged as renesas-soc-cleanup2-for-v3.17, which you have merged
  into next/cleanup.

* "Third Round of Renesas ARM Based SoC r8a7779 Multiplatform Updates for
  v3.17", tagged as renesas-r8a7779-multiplatform3-for-v3.17, which
  you have merged into next/soc

* "Renesas ARM Based SoC Boards Updates for v3.17",
  tagged as renesas-boards-for-v3.17, which you have merged
  into next/boards

* "Third Round of Renesas ARM Based SoC Updates for v3.17",
  tagged as renesas-soc3-for-v3.17, which you have merged
  into next/soc


The following changes since commit 5c174afd407acc7a90701900b279578151bc007f:

  Merge branch 'clockevents/renesas-timers-dt' of git://git.linaro.org/people/daniel.lezcano/linux into dt-timers-for-v3.17.base (2014-07-15 16:31:45 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-timers-for-v3.17

for you to fetch changes up to 9394af4314554d15762585a3464cefaa2e6d0420:

  ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-07-15 21:26:42 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Timers Updates for v3.17

* Enable timers using DT when booting boards without Legacy-C code

----------------------------------------------------------------
Laurent Pinchart (8):
      ARM: shmobile: r8a7790: Add CMT devices to DT
      ARM: shmobile: r8a7791: Add CMT devices to DT
      ARM: shmobile: r8a7779: Add TMU devices to DT
      ARM: shmobile: lager-reference: Enable CMT0 in device tree
      ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
      ARM: shmobile: marzen-reference: Enable TMU0 in device tree
      ARM: shmobile: r7s72100: Add MTU2 device to DT
      ARM: shmobile: genmai-reference: Enable MTU2 in device tree

 arch/arm/boot/dts/r7s72100-genmai.dts            |  4 +++
 arch/arm/boot/dts/r7s72100.dtsi                  | 10 ++++++
 arch/arm/boot/dts/r8a7779-marzen.dts             |  4 +++
 arch/arm/boot/dts/r8a7779.dtsi                   | 42 ++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts              |  4 +++
 arch/arm/boot/dts/r8a7790.dtsi                   | 32 ++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  4 +++
 arch/arm/boot/dts/r8a7791.dtsi                   | 32 ++++++++++++++++++
 arch/arm/mach-shmobile/board-genmai-reference.c  | 20 -----------
 arch/arm/mach-shmobile/board-genmai.c            | 14 +++++++-
 arch/arm/mach-shmobile/board-koelsch-reference.c |  2 --
 arch/arm/mach-shmobile/board-lager-reference.c   |  2 --
 arch/arm/mach-shmobile/board-marzen-reference.c  | 10 ------
 arch/arm/mach-shmobile/r7s72100.h                |  1 -
 arch/arm/mach-shmobile/r8a7779.h                 |  1 -
 arch/arm/mach-shmobile/r8a7790.h                 |  1 -
 arch/arm/mach-shmobile/r8a7791.h                 |  1 -
 arch/arm/mach-shmobile/setup-r7s72100.c          | 21 ------------
 arch/arm/mach-shmobile/setup-r8a7779.c           | 17 +++-------
 arch/arm/mach-shmobile/setup-r8a7790.c           |  7 +---
 arch/arm/mach-shmobile/setup-r8a7791.c           |  7 +---
 21 files changed, 152 insertions(+), 84 deletions(-)
