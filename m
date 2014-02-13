From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:52 +0900
Subject: [GIT PULL 00/11] Second Round of Renesas ARM Based SoC Board Updates
 for v3.15
Message-ID: <cover.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of Renesas ARM based SoC board updates
for v3.15.

This pull-request is based on the first round of such updates,
tagged as renesas-boards-for-v3.15, which I have previously sent a
pull-request for.


The following changes since commit 235cda29e4d5047622ff9b82b1f0b4cb6cf95f6c:

  ARM: shmobile: Remove Lager USBHS UDC ifdefs (2014-02-04 14:28:33 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.15

for you to fetch changes up to 03fec7dee502d43114f384a1588ce84a3c9bf38d:

  ARM: shmobile: genmai: Enable r7s72100-ether (2014-02-07 09:20:03 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Board Updates for v3.15

* r7s72100 (RZ/A1H) based Genmai board
  - Enable SH ethernet
  - Add RSPI support

* r8a7791 (R-Car M2) based Koelsch board
  - Add QSPI support
  - Add I2C support
  - Pass SH ethernet PHY IRQ

* r8a7790 (R-Car H2) based Lager board
  - Switch QSPI to named IRQs
  - Add sound support
  - Add USB0 cable detection workaround
  - Pass SH ethernet PHY IRQ

* r8a7779 (R-Car H1) based Marzen board
  - Revert conditional selection of SMSC_PHY

* r8a7778 (R-Car M1) based Bock-W board
  - Use wp-gpios instead of WP pin

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: genmai legacy: Add RSPI support
      ARM: shmobile: koelsch legacy: Add QSPI support
      ARM: shmobile: lager legacy: Switch QSPI to named IRQs

Kuninori Morimoto (2):
      ARM: shmobile: bockw: use wp-gpios instead of WP pin
      ARM: shmobile: lager: add sound support

Magnus Damm (1):
      ARM: shmobile: Lager USB0 cable detection workaround

Sergei Shtylyov (2):
      ARM: shmobile: Lager: pass Ether PHY IRQ
      ARM: shmobile: Koelsch: pass Ether PHY IRQ

Simon Horman (2):
      Revert "ARM: shmobile: marzen: Conditionally select SMSC_PHY"
      ARM: shmobile: genmai: Enable r7s72100-ether

Valentine Barshak (1):
      ARM: shmobile: koelsch: Add I2C support

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   4 +-
 arch/arm/mach-shmobile/Kconfig                |   3 +-
 arch/arm/mach-shmobile/board-genmai.c         |  64 +++++++++++++
 arch/arm/mach-shmobile/board-koelsch.c        | 114 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c          | 131 +++++++++++++++++++++++++-
 5 files changed, 309 insertions(+), 7 deletions(-)
