From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:32 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT DU Updates for v3.19
Message-ID: <cover.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT DU updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-du-for-v3.19

for you to fetch changes up to 0ee56d403549fd97d8acac6b7ba3a17f6999c30a:

  ARM: shmobile: koelsch: Enable DU device in DT (2014-10-30 09:47:13 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT DU Updates for v3.19

* Enable DU using DT on marzen/r8a7779, lager/r8a7790 and koelsch/r8a7791

----------------------------------------------------------------
Laurent Pinchart (10):
      ARM: shmobile: Remove FSF address from copyright headers
      ARM: shmobile: r8a7779: Add DU node to device tree
      ARM: shmobile: r8a7790: Add DU node to device tree
      ARM: shmobile: r8a7791: Add DU node to device tree
      ARM: shmobile: dts: Add common file for AA104XD12 panel
      ARM: shmobile: marzen: Enable DU device in DT
      ARM: shmobile: lager-reference: Remove DU platform device
      ARM: shmobile: lager: Enable DU device in DT
      ARM: shmobile: koelsch-reference: Remove DU platform device
      ARM: shmobile: koelsch: Enable DU device in DT

 arch/arm/boot/dts/r8a7779-marzen.dts             | 83 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                   | 24 +++++++
 arch/arm/boot/dts/r8a7790-lager.dts              | 53 +++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                   | 90 ++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 16 ++++-
 arch/arm/boot/dts/r8a7791.dtsi                   | 69 ++++++++++++++++++
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi   | 41 +++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  4 --
 arch/arm/mach-shmobile/board-ape6evm.c           |  4 --
 arch/arm/mach-shmobile/board-armadillo800eva.c   |  5 --
 arch/arm/mach-shmobile/board-bockw-reference.c   |  4 --
 arch/arm/mach-shmobile/board-bockw.c             |  4 --
 arch/arm/mach-shmobile/board-koelsch-reference.c | 77 --------------------
 arch/arm/mach-shmobile/board-koelsch.c           |  4 --
 arch/arm/mach-shmobile/board-kzm9g-reference.c   |  4 --
 arch/arm/mach-shmobile/board-kzm9g.c             |  4 --
 arch/arm/mach-shmobile/board-lager-reference.c   | 84 ----------------------
 arch/arm/mach-shmobile/board-lager.c             |  4 --
 arch/arm/mach-shmobile/board-mackerel.c          |  4 --
 arch/arm/mach-shmobile/board-marzen-reference.c  |  4 --
 arch/arm/mach-shmobile/board-marzen.c            |  4 --
 arch/arm/mach-shmobile/clock-r8a73a4.c           |  4 --
 arch/arm/mach-shmobile/clock-r8a7740.c           |  4 --
 arch/arm/mach-shmobile/clock-r8a7778.c           |  4 --
 arch/arm/mach-shmobile/clock-r8a7779.c           |  4 --
 arch/arm/mach-shmobile/clock-r8a7790.c           |  4 --
 arch/arm/mach-shmobile/clock-r8a7791.c           |  4 --
 arch/arm/mach-shmobile/clock-sh7372.c            |  4 --
 arch/arm/mach-shmobile/clock-sh73a0.c            |  4 --
 arch/arm/mach-shmobile/clock.c                   |  4 --
 arch/arm/mach-shmobile/console.c                 |  4 --
 arch/arm/mach-shmobile/headsmp-scu.S             |  5 --
 arch/arm/mach-shmobile/intc-sh7372.c             |  4 --
 arch/arm/mach-shmobile/intc-sh73a0.c             |  4 --
 arch/arm/mach-shmobile/r8a7740.h                 |  4 --
 arch/arm/mach-shmobile/r8a7778.h                 |  4 --
 arch/arm/mach-shmobile/setup-emev2.c             |  4 --
 arch/arm/mach-shmobile/setup-r7s72100.c          |  4 --
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  4 --
 arch/arm/mach-shmobile/setup-r8a7740.c           |  4 --
 arch/arm/mach-shmobile/setup-r8a7778.c           |  4 --
 arch/arm/mach-shmobile/setup-r8a7779.c           |  4 --
 arch/arm/mach-shmobile/setup-r8a7790.c           |  4 --
 arch/arm/mach-shmobile/setup-r8a7791.c           |  4 --
 arch/arm/mach-shmobile/setup-rcar-gen2.c         |  4 --
 arch/arm/mach-shmobile/setup-sh7372.c            |  4 --
 arch/arm/mach-shmobile/setup-sh73a0.c            |  4 --
 arch/arm/mach-shmobile/sleep-sh7372.S            |  5 --
 arch/arm/mach-shmobile/smp-emev2.c               |  4 --
 arch/arm/mach-shmobile/smp-r8a7779.c             |  4 --
 arch/arm/mach-shmobile/smp-sh73a0.c              |  4 --
 arch/arm/mach-shmobile/timer.c                   |  5 --
 52 files changed, 370 insertions(+), 343 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
