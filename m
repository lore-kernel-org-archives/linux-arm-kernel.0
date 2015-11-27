From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:56 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.5
Message-ID: <cover.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.5.

This pull request extends support for Renesas ARM Based SoCs via DT
and includes several minor fixes and cleanups.


The following changes since commit 998f468f34f41905051556a9897dbc204b1b75b4:

  Merge tag 'v4.4-rc1' into HEAD (2015-11-24 12:00:02 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.5

for you to fetch changes up to c8d9fdbe2d648caaa510d45dc13eba2e9957140b:

  ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node (2015-11-25 10:42:38 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.5

* sh73a0, r8a7740: Add L2 cache-controller node
* r8a7791, r8a7794: remove deprecated #gpio-range-cells
* r8a7793: Add DU support and enable for VGA port
* r8a7790: switch console back to scif0
* alt: Correct ether and scif2 pinmux
* koelsch: Correct hdmi pinmux
* silk, lager, porter, bockw: Move SPI FLASH partitions to subnode
* bockw: Add schi0 pinmux

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: bockw: Move SPI FLASH partition to subnode
      ARM: shmobile: porter: Move SPI FLASH partitions to subnode
      ARM: shmobile: lager: Move SPI FLASH partitions to subnode
      ARM: shmobile: silk: Move SPI FLASH partitions to subnode
      ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
      ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node

Laurent Pinchart (2):
      ARM: shmobile: r8a7793: Add DU node to device tree
      ARM: shmobile: r8a7791: koelsch: Fix pinmux for HDMI

Magnus Damm (1):
      ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA port

Simon Horman (2):
      ARM: shmobile: alt: Correct scif2 pfc
      ARM: shmobile: alt: Correct ether pfc

Ulrich Hecht (2):
      ARM: shmobile: r8a7790: switch console back to scif0
      ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups

Wolfram Sang (2):
      ARM: shmobile: r8a7791: remove deprecated #gpio-range-cells from dtsi
      ARM: shmobile: r8a7794: remove deprecated #gpio-range-cells from dtsi

 arch/arm/boot/dts/r8a7740.dtsi        | 13 ++++++++++
 arch/arm/boot/dts/r8a7778-bockw.dts   | 23 +++++++++++------
 arch/arm/boot/dts/r8a7790-lager.dts   | 47 +++++++++++++++++++----------------
 arch/arm/boot/dts/r8a7791-koelsch.dts |  2 +-
 arch/arm/boot/dts/r8a7791-porter.dts  | 33 +++++++++++++-----------
 arch/arm/boot/dts/r8a7791.dtsi        |  1 -
 arch/arm/boot/dts/r8a7793.dtsi        | 30 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794-alt.dts     | 19 +++++++++++---
 arch/arm/boot/dts/r8a7794-silk.dts    | 33 +++++++++++++-----------
 arch/arm/boot/dts/r8a7794.dtsi        |  1 -
 arch/arm/boot/dts/sh73a0.dtsi         | 14 +++++++++++
 11 files changed, 150 insertions(+), 66 deletions(-)
