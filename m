From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:04:47 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.19
Message-ID: <cover.1532345886.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.19.

Changes since v1:
* Dropped patch which removes MTD partitioning from DT,
  Olof requested more discussion of this
* Trimmed text in tag, as per suggestions from Olof

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.19

for you to fetch changes up to c03e2f12a2967f1639ee53299b72922ee3472528:

  ARM: dts: r8a77470: Use r8a77470-cpg-mssr binding definitions (2018-07-23 13:33:06 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.19

* RZ/G1C (r8a77470) SoC: Use r8a77470-cpg-mssr binding definitions
* Add GR-Peach audio camera shield support with MT9V111 image sensor
* Add initial support for RZ/N1D (r9a06g032) SoC and its RZN1D-DB board
* Use SPDX identifiers in DT for all SoCs and boards
* Add missing OPP properties for all CPUs on various SoCs
* Add missing PMIC nodes to R-Car Gen2 M2-W (r8a7791) based porter board

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: r8a77470: Use r8a77470-cpg-mssr binding definitions

Jacopo Mondi (1):
      ARM: dts: gr-peach: Add GR-Peach audiocamerashield support

Marek Vasut (1):
      ARM: dts: porter: Add missing PMIC nodes

Michel Pollet (3):
      ARM: dts: Renesas R9A06G032 base device tree file
      ARM: dts: Renesas RZN1D-DB Board base file
      ARM: dts: Renesas R9A06G032 SMP enable method

Viresh Kumar (1):
      ARM: dts: r8a77(43|9[013]): Add missing OPP properties for CPUs

Wolfram Sang (1):
      ARM: dts: convert to SPDX identifier for Renesas boards

 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/emev2-kzm9d.dts                  |   5 +-
 arch/arm/boot/dts/emev2.dtsi                       |   5 +-
 arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi  |  79 ++++++++++++++
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   5 +-
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |   5 +-
 arch/arm/boot/dts/r7s72100-genmai.dts              |   5 +-
 arch/arm/boot/dts/r7s72100-gr-peach.dts            |   5 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts             |   5 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |   5 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |   5 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   5 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts    |   5 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |   5 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   5 +-
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts             |   5 +-
 arch/arm/boot/dts/r8a7743.dtsi                     |  14 ++-
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |   5 +-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |   5 +-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |   5 +-
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts             |   5 +-
 arch/arm/boot/dts/r8a7745.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a77470.dtsi                    |  16 +--
 arch/arm/boot/dts/r8a7778-bockw.dts                |   5 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   5 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |   5 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  39 +++++--
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   5 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |  38 ++++++-
 arch/arm/boot/dts/r8a7791.dtsi                     |  19 ++--
 arch/arm/boot/dts/r8a7792-blanche.dts              |   5 +-
 arch/arm/boot/dts/r8a7792-wheat.dts                |   5 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |   5 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  20 ++--
 arch/arm/boot/dts/r8a7794-alt.dts                  |   5 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |   5 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi     |   5 +-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi     |   5 +-
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  28 +++++
 arch/arm/boot/dts/r9a06g032.dtsi                   | 115 +++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   5 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |   5 +-
 49 files changed, 374 insertions(+), 186 deletions(-)
 create mode 100644 arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi
