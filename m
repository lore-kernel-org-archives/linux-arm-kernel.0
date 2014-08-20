From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:13 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Timers Updates for v3.18
Message-ID: <cover.1408492048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT Timers updates for v3.18.

The patches in this pull request were originally posted as
"Renesas ARM Based SoC DT Timers Updates for v3.17" and tagged as
renesas-dt-timers-for-v3.17.  For various reasons it did not get
pulled for v3.17 so I have rebased it on v3.17-rc1 and am submitting
it for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-timers-for-v3.18

for you to fetch changes up to 9dddfcfacaadb5491b62233b893b510fa00da4e0:

  ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-08-17 09:02:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Timers Updates for v3.18

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
