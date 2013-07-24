From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:32:14 +0900
Subject: [GIT 00/19 v2] Renesas ARM based SoC pinmux updates for v3.12
Message-ID: <cover.1374625203.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following pinmux updates for v3.12.

Difference with v1 of this pull-request:
* Remove bogus i2c portions of the first patch of the series.
* Correct addressing mode used in dts of the first patch of the series.
* Removal of egg from face: wip

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.12

for you to fetch changes up to 1469273960de45275f33276c7254456edcba9da2:

  ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree (2013-07-22 10:12:41 +0900)

----------------------------------------------------------------
Renesas ARM based SoC pinmux updates for v3.12

SH Mobile pinctrl DT support

----------------------------------------------------------------
Laurent Pinchart (19):
      ARM: shmobile: r8a73a4: Add pin control device to device tree
      ARM: shmobile: r8a7740: Add pin control device to device tree
      ARM: shmobile: r8a7778: Add pin control device to device tree
      ARM: shmobile: r8a7778: Add GPIO controller devices to device tree
      ARM: shmobile: r8a7779: Add pin control device to device tree
      ARM: shmobile: r8a7779: Add GPIO controller devices to device tree
      ARM: shmobile: r8a7790: Add pin control device to device tree
      ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
      ARM: shmobile: sh7372: Add pin control device to device tree
      ARM: shmobile: sh73a0: Add pin control device to device tree
      ARM: shmobile: armadillo-reference: Move pinctrl mappings to device tree
      ARM: shmobile: armadillo-reference: Add st1232 pin mappings
      ARM: shmobile: armadillo-reference: Move st1232 reset GPIO to DT
      ARM: shmobile: armadillo-reference: Add LED1-LED4 to the device tree
      ARM: shmobile: marzen-reference: Move pinctrl mappings to device tree
      ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree
      ARM: shmobile: kzm9g-reference: Move pinctrl mappings to device tree
      ARM: shmobile: kzm9g-reference: Move SDHI regulators to DT
      ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree

 arch/arm/boot/dts/r8a73a4.dtsi                     |  7 ++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 34 ++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |  8 ++
 arch/arm/boot/dts/r8a7778.dtsi                     | 66 ++++++++++++++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 49 ++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 90 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 78 +++++++++++++++++++
 arch/arm/boot/dts/sh7372.dtsi                      |  8 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 90 +++++++++++++++++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |  8 ++
 .../board-armadillo800eva-reference.c              | 18 +----
 arch/arm/mach-shmobile/board-kzm9g-reference.c     | 47 -----------
 arch/arm/mach-shmobile/board-marzen-reference.c    | 28 -------
 13 files changed, 437 insertions(+), 94 deletions(-)
