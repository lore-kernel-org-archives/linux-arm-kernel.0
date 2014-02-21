From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:51 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v3.15
Message-ID: <cover.1392961872.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC DT updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-dt2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit e02ee513eed4bb780848a5cedbd4b39afb395d3e:

  ARM: shmobile: koelsch dts: Add QSPI nodes (2014-02-06 20:36:12 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.15

for you to fetch changes up to 367aaaea1d6c6496695ffd06b49590b8cfcb8aa5:

  ARM: shmobile: genmai: adapt dts to use native i2c driver (2014-02-18 11:35:30 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC DT Updates for v3.15

* r7s72100 SoC (RZ/A1H)
  - Add nodes for i2c controllers to DT

* r7s72100 (RZ/A1H) based Genmai board
  - genmai: adapt dts to use native i2c driver

* r8a7791 SoC (R-Car M2)
  - Remove superfluous interrupt-parents

* r8a7791 (R-Car M2) based Koelsch board
  - Add i2c2 bus to DT
  - Add DU device to DT

* r8a7790 SoC (R-Car H2)
  - Add i2c aliases
  - Remove superfluous interrupt-parents
  - Add QSPI node

* r8a7790 SoC (R-Car M2) based Lager
  - Add DU, SDHI0/1 and QSPI to DT

* r8a7778 SoC (R-Car M1)
  - Remove duplicate i2c nodes

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: r8a7790 dtsi: Add QSPI node
      ARM: shmobile: lager dts: Add QSPI nodes
      ARM: shmobile: r8a7778 dtsi: Remove duplicate i2c nodes

Kuninori Morimoto (1):
      ARM: shmobile: lager: add SDHI0/2 support on DTS

Laurent Pinchart (2):
      ARM: shmobile: lager: Add DU device to DTS
      ARM: shmobile: koelsch-reference: Add DU device to DTS

Wolfram Sang (7):
      ARM: shmobile: r8a7791: remove superfluous interrupt-parents
      ARM: shmobile: r8a7790: remove superfluous interrupt-parents
      ARM: shmobile: r8a7790: add i2c aliases to dtsi
      ARM: shmobile: r8a7791: add i2c master nodes to dtsi
      ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
      ARM: shmobile: r7s72100: add nodes for i2c controllers to dtsi
      ARM: shmobile: genmai: adapt dts to use native i2c driver

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |  11 +++
 arch/arm/boot/dts/r7s72100.dtsi                 |  72 ++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                  |  40 --------
 arch/arm/boot/dts/r8a7790-lager.dts             | 121 +++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                  |  48 ++++------
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  26 ++++-
 arch/arm/boot/dts/r8a7791.dtsi                  | 100 ++++++++++++++------
 7 files changed, 315 insertions(+), 103 deletions(-)
