From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:16 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v3.16
Message-ID: <cover.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC DT updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v3.16,
which I have already sent a pull-request for.


The following changes since commit 5a62ec57004f1a434bfd3feed43e447b5780baf6:

  ARM: shmobile: henninger: enable SATA0 (2014-04-28 09:12:04 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.16

for you to fetch changes up to 3fa3985e624aea24334abc9a33b484c3d316e64e:

  ARM: shmobile: r8a7740 dtsi: Remove duplicate interrupt-parent property (2014-05-15 08:09:59 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v3.16

r8a7791 (R-Car M2), r8a7779 (R-Car H1), r8a7778 (R-Car M1),
r8a7740 (R-Mobile A1) and r8a73a4 (R-Mobile APE6) SoCs
* Move interrupt-parent property to root node

r8a7791 (R-Car M2) and r8a7790 (R-Car H2) SoCs
* Add GPIO clocks

r8a7791 (R-Car M2) based Henninger board
* Add MSIOF0, QSPI and SDHI0/2 support
* Specify EXTAL frequency

r8a7779 (R-Car H1) based Marzen board
* Set SMSC lan to use irq-push-pull

r8a7740 (R-Mobile A1) SoC
* Remove duplicate interrupt-parent property

r8a7740 (R-Mobile A1) based Armadillo800 EVA board
* Add Ethernet support

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: r8a7740 dtsi: Add Ethernet support
      ARM: shmobile: armadillo-reference dts: Add Ethernet support
      ARM: shmobile: r8a7790 dtsi: Add GPIO clocks
      ARM: shmobile: r8a7791 dtsi: Add GPIO clocks
      ARM: shmobile: r8a7740 dtsi: Remove duplicate interrupt-parent property

Laurent Pinchart (1):
      ARM: shmobile: dts: Move interrupt-parent property to root node

Sergei Shtylyov (4):
      ARM: shmobile: henninger: specify EXTAL frequency
      ARM: shmobile: henninger: add SDHI0/2 DT support
      ARM: shmobile: henninger: add QSPI DT support
      ARM: shmobile: henninger: add MSIOF0 DT support

Simon Horman (1):
      ARM: shmobile: marzen-reference: Set SMSC lan to use irq-push-pull

 arch/arm/boot/dts/r8a73a4.dtsi                     |  18 ---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  17 +++
 arch/arm/boot/dts/r8a7740.dtsi                     |  24 ++--
 arch/arm/boot/dts/r8a7778.dtsi                     |  18 +--
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |   1 +
 arch/arm/boot/dts/r8a7779.dtsi                     |  21 +---
 arch/arm/boot/dts/r8a7790.dtsi                     |  13 +-
 arch/arm/boot/dts/r8a7791-henninger.dts            | 139 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  22 +++-
 9 files changed, 200 insertions(+), 73 deletions(-)
