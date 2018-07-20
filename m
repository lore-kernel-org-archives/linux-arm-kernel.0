From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:40 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.19
Message-ID: <cover.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.19.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.19,
which I have already sent a pull-request for.


The following changes since commit 6b284a81307848b4331453b02cf7a33c09719d4b:

  arm64: dts: renesas: r8a77995: Add MSIOF device nodes (2018-06-25 15:30:39 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.19

for you to fetch changes up to 9a6c158f62ccdd37c921ec8b1484418bad5f7984:

  arm64: dts: renesas: r8a77980: add INTC-EX support (2018-07-20 13:47:34 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.19

Corrections:

* Remove non-existing STBE region from Ether-AVB node in DT of
  R-Car E3 (r8a77990) SoC

  This region does not exist on this SoC

Cleanups:

* Consistently use rwdt as label for Renesas Watchdog Timer devices

* Add second port to rcar_sound placeholder in DT of R-Car M3-N (r8a77965) SoC

  Nodes with #address-cells/#size-cells should have more than one child node

* Fix adv7482 decimal unit addresses in DT of Salvator-X and -XS boards

  Addresses are assumed to be hex by dtc, thus it is not valid to use
  decimal

Enhancements:

* Describe in DT:
  - INTC-EX of R-Car V3H (r8a77980) SoC
  - USB3.0 of R-Car E3 (r8a77980) SoC
  - All SCIF and HSCIF devices of R-Car D3 (r8a77995) SoC.
    Previously only SCIF2, used as the debug consile, was described.
  - All IPMMU devicesof R-Car M3-N (r8a77965), V3H (r8a77980) and
    E3 (r8a77990) SoCs

* Enable USB3.0 in DT of R-Car E3 (r8a77980) based Ebisu board

* Prefer HSCIF1 over SCIF1 in DT of Salvator-X and -XS boards

  HSCIF is superior to SCIF (larger FIFOs, more accurate and wider
  supported range of bitrates).

----------------------------------------------------------------
Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a77990: Remove non-existing STBE region
      arm64: dts: renesas: salvator-common: Fix adv7482 decimal unit addresses
      arm64: dts: renesas: salvator-common: Prefer HSCIF1 over SCIF1

Magnus Damm (1):
      arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes

Sergei Shtylyov (1):
      arm64: dts: renesas: r8a77980: add INTC-EX support

Simon Horman (1):
      arm64: dts: renesas: r8a77965: Add second port to rcar_sound placeholder

Takeshi Kihara (1):
      arm64: dts: renesas: r8a77995: Add SCIF {0,1,3,4,5} and all HSCIF device nodes

Yoshihiro Shimoda (2):
      arm64: dts: renesas: Unify the labels for RWDT
      arm64: dts: renesas: r8a77990: Enable USB3.0 host for Ebisu board

 arch/arm64/boot/dts/renesas/r8a7795.dtsi         |   2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi         |   2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi        |  94 +++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi        |  79 +++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts   |  12 +++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi        |  95 +++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi        | 118 +++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  12 +--
 arch/arm64/boot/dts/renesas/ulcb.dtsi            |   2 +-
 9 files changed, 405 insertions(+), 11 deletions(-)
