From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:17 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Cleanups for v3.19
Message-ID: <cover.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT cleanups for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-cleanups-for-v3.19

for you to fetch changes up to 120f038cf04b95dc895cba503a7516ff75561438:

  ARM: shmobile: kzm9d dts: Add chosen/stdout-path (2014-10-24 10:44:10 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Cleanups for v3.19

* Add chosen/stdout-path to DTS files for shmobile boards
* Remove r7s72100-genmai.dtb for ARCH_SHMOBILE_LEGACY
  - The corresponding board file has already been removed
* Sort dts nodes by address
* Sort SHMOBILE dtbs alphabetically in Makefile

----------------------------------------------------------------
Geert Uytterhoeven (15):
      ARM: dts: Sort SHMOBILE dtbs alphabetically
      ARM: shmobile: r7s72100: Remove r7s72100-genmai.dtb for ARCH_SHMOBILE_LEGACY
      ARM: shmobile: emev2 dtsi: Use generic names for device nodes
      ARM: shmobile: emev2 dtsi: Add uart* labels for easier referencing
      ARM: shmobile: genmai dts: Add chosen/stdout-path
      ARM: shmobile: ape6evm-reference dts: Add chosen/stdout-path
      ARM: shmobile: armadillo800eva dts: Add chosen/stdout-path
      ARM: shmobile: bockw-reference dts: Add chosen/stdout-path
      ARM: shmobile: marzen dts: Add chosen/stdout-path
      ARM: shmobile: lager dts: Add chosen/stdout-path
      ARM: shmobile: henninger dts: Add chosen/stdout-path
      ARM: shmobile: koelsch dts: Add chosen/stdout-path
      ARM: shmobile: alt dts: Add chosen/stdout-path
      ARM: shmobile: kzm9g-reference dts: Add chosen/stdout-path
      ARM: shmobile: kzm9d dts: Add chosen/stdout-path

Simon Horman (1):
      ARM: shmobile: r8a73a4: Remove spurious dma-multiplexer base addresses

Ulrich Hecht (3):
      ARM: shmobile: r7s72100: sort dtsi file by address
      ARM: shmobile: kzm9d: sort dts file by address
      ARM: shmobile: r8a73a4: sort dtsi file by address

 arch/arm/boot/dts/Makefile                      |  16 +-
 arch/arm/boot/dts/emev2-kzm9d.dts               |  63 +++----
 arch/arm/boot/dts/emev2.dtsi                    |  12 +-
 arch/arm/boot/dts/r7s72100-genmai.dts           |   3 +-
 arch/arm/boot/dts/r7s72100.dtsi                 | 202 ++++++++++-----------
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   3 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  | 232 ++++++++++++------------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |   1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts   |   3 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |   1 +
 arch/arm/boot/dts/r8a7790-lager.dts             |   1 +
 arch/arm/boot/dts/r8a7791-henninger.dts         |   1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   1 +
 arch/arm/boot/dts/r8a7794-alt.dts               |   1 +
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |   1 +
 15 files changed, 276 insertions(+), 265 deletions(-)
