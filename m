From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:17:58 +0900
Subject: [GIT PULL 00/12] Second Round of Renesas ARM based SoC Board updates
 for v3.14
Message-ID: <cover.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider the this second round of Renesas ARM based SoC board
updates for v3.14.

This pull request is based on a merge of:

* The first round of Renesas ARM based SoC board
  updates for v3.14, tagged as renesas-boards-for-v3.14,
  which you have already pulled.

* The second round of Renesas ARM based SoC
  updates for v3.14, tagged as renesas-soc-for-v3.14,
  which I have previously sent a pull-request for.

The reason for this merge is to provide SoC dependencies
used by the multiplatform and CCF changes in this series.


The following changes since commit 70d4f2e5576a16120e6bc85b10011032306c1179:

  Merge branch 'heads/soc2' into boards2-base (2013-12-19 19:08:11 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.14

for you to fetch changes up to b58c8e7b43ad804ad18b30f882b16da2e3d4ed9d:

  ARM: shmobile: mackerel: Fix USBHS pinconf entry (2013-12-19 19:08:27 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC Board updates for v3.14

* r8a7791 (R-Car M2) based Koelsch board
  - Let Koelsch multiplatform boot with Koelsch DTB
  - Remove non-multiplatform DT reference support
  - Instantiate clkdevs for SCIF and CMT
  - Remove duplicate CCF initialization
  - Add Ether and DU support

* r8a7790 (R-Car H2) based Lager board
  - Let Lager multiplatform boot with Lager DTB
  - Remove non-multiplatform DT reference support
  - Instantiate clkdevs for SCIF and CMT
  - Enable multiplaform kernel support

* r8a7740 (R-Mobile A1) based Armadillo board
  - Set backlight enable GPIO

* sh7374 (SH-Mobile AP4) based Mackerel board
  - Correct USBHS pinconf entry

----------------------------------------------------------------
Laurent Pinchart (11):
      ARM: shmobile: koelsch: Add DU device
      ARM: shmobile: armadillo: Set backlight enable GPIO
      ARM: shmobile: lager-reference: Enable multiplaform kernel support
      ARM: shmobile: koelsch-reference: Remove duplicate CCF initialization
      ARM: shmobile: lager-reference: Instantiate clkdevs for SCIF and CMT
      ARM: shmobile: koelsch-reference: Instantiate clkdevs for SCIF and CMT
      ARM: shmobile: Remove non-multiplatform Lager reference support
      ARM: shmobile: Remove non-multiplatform Koelsch reference support
      ARM: shmobile: Let Lager multiplatform boot with Lager DTB
      ARM: shmobile: Let Koelsch multiplatform boot with Koelsch DTB
      ARM: shmobile: mackerel: Fix USBHS pinconf entry

Sergei Shtylyov (1):
      ARM: shmobile: Koelsch: add Ether support

 arch/arm/boot/dts/Makefile                       |   4 +-
 arch/arm/mach-shmobile/Kconfig                   |  30 ++----
 arch/arm/mach-shmobile/Makefile                  |   3 +-
 arch/arm/mach-shmobile/Makefile.boot             |   2 -
 arch/arm/mach-shmobile/board-armadillo800eva.c   |   5 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c |  30 +++++-
 arch/arm/mach-shmobile/board-koelsch.c           | 119 ++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c   |  32 ++++++
 arch/arm/mach-shmobile/board-mackerel.c          |   2 +-
 9 files changed, 191 insertions(+), 36 deletions(-)
