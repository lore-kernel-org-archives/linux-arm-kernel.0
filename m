From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:44 +0900
Subject: [GIT PULL 00/13] Second Round of Renesas ARM Based SoC Updates for
 v3.14
Message-ID: <cover.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC updates for v3.14.
It is based on the first round of such changes, tagged as
renesas-soc2-for-v3.14, which you have already pulled.


The following changes since commit fee05eb3d2ce4813b5e9a70ab888d2bc0047f4e1:

  ARM: shmobile: r8a7779: add HSPI clock support for DT (2013-12-10 17:20:15 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.14

for you to fetch changes up to 250d829f68ecb5e775a99deb03c56832acec28f4:

  arm: shmobile: clks: remove duplicated clock from r7s72100 (2013-12-19 18:21:57 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.14

* Global
  - Add select MIGHT_HAVE_PCI for PCI-AHB bridge code

* r7s72100 SoC (RZ/A1H)
  - clks: remove duplicated clock from r7s72100

* R-Car Gen 2: r8a7791 (R-Car M2) and r8a7790 (R-Car H2)
  * Initialize CCF before clock sources
  * Do not setup timer in non-secure mode

* r8a7791 (R-Car M2)
  - Conditionally select MICREL_PHY
  - Add clock index macros for DT sources
  - Add Ether clock

* r8a7790 (R-Car H2)
  - Add clock index macros for DT sources
  - Add I2C support

* r8a7778 (R-Car M1)
  - Add USB Func DMAEngine support
  - camera-rcar header cleanup
  - Add SSIx DMAEngine support

* sh73a0 (SH-Mobile AG5)
  - Add FSI clock support for DT

----------------------------------------------------------------
Ben Dooks (2):
      ARM: rcar-gen2: Do not setup timer in non-secure mode
      ARM: shmobile: Add select MIGHT_HAVE_PCI for PCI-AHB bridge code

Kuninori Morimoto (5):
      ARM: shmobile: r8a7778: add SSIx DMAEngine support
      ARM: shmobile: r8a7790: add I2C support
      ARM: shmobile: sh73a0: add FSI clock support for DT
      ARM: shmobile: r8a7778: camera-rcar header cleanup
      ARM: shmobile: r8a7778: add USB Func DMAEngine support

Laurent Pinchart (3):
      ARM: shmobile: r8a7790: Add clock index macros for DT sources
      ARM: shmobile: r8a7791: Add clock index macros for DT sources
      ARM: shmobile: rcar-gen2: Initialize CCF before clock sources

Sergei Shtylyov (1):
      ARM: shmobile: r8a7791: add Ether clock

Simon Horman (1):
      ARM: shmobile: koelsch: Conditionally select MICREL_PHY

Wolfram Sang (1):
      arm: shmobile: clks: remove duplicated clock from r7s72100

 arch/arm/mach-shmobile/Kconfig                |   5 ++
 arch/arm/mach-shmobile/board-bockw.c          |   1 +
 arch/arm/mach-shmobile/clock-r7s72100.c       |   1 -
 arch/arm/mach-shmobile/clock-r8a7790.c        |   4 +
 arch/arm/mach-shmobile/clock-r8a7791.c        |   3 +
 arch/arm/mach-shmobile/clock-sh73a0.c         |   1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  21 +++++-
 arch/arm/mach-shmobile/setup-r8a7778.c        |  69 +++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7790.c        |  25 ++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c      |  29 +++++--
 include/dt-bindings/clock/r8a7790-clock.h     | 100 ++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7791-clock.h     | 105 ++++++++++++++++++++++++++
 12 files changed, 356 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 create mode 100644 include/dt-bindings/clock/r8a7791-clock.h
