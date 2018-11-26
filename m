From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:53:38 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.21
Message-ID: <cover.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.21.

I am sending out this pull-request at this time as there are a number
of patches queued up in my arm (32) DT branch and I hope that this
will ease the burden later on in the development cycle. I expect to
send a follow-up pull-request for this branch at the usual pre-rc6 timing.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.21

for you to fetch changes up to 83d3483e4977eeedf258f053878a88db507630d4:

  ARM: dts: r9a06g032: Correct the GIC DT node name (2018-11-23 13:20:17 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.21

* RZ/N1D (r9a06g032) SoC:
  - Correct GIC DT node name
  - Enable pin controller

* RZ/G1C (r8a77470) iWave g23S single board computer
  - Add QSPI flash support
  - Add pinctl support for EtherAVB
  - Enable CMT0 (Renesas R-Car Compare Match Timer)
  - Enable RWDT (Renesas Watchdog Timer)
  - Enable uSD and eMMC support

* RZ/G1C (r8a77470) SoC:
  - Describe USB-DMAC and I2C devices in DT

* R-Mobile A1 (r8a7740), Emma Mobile EV2 (emev2) and
  SH-Mobile AG5 (sh72a0) SoCs:
  - Include SoC name in DTSI

* R-Car H2 (r8a7790) based lager, and
  R-Car M2-W (r8a7791) based koelsch and porter boards:
  - Disable unconnected LVDS encoders

----------------------------------------------------------------
Biju Das (6):
      ARM: dts: r8a77470: Add watchdog support to SoC dtsi
      ARM: dts: iwg23s-sbc: Enable watchdog support
      ARM: dts: r8a77470: Add USB-DMAC device nodes
      ARM: dts: r8a77470: Add CMT SoC specific support
      ARM: dts: iwg23s-sbc: Enable cmt0
      ARM: dts: iwg23s-sbc: Add pinctl support for EtherAVB

Fabrizio Castro (6):
      ARM: dts: r8a77470: Add I2C[0123] support
      ARM: dts: r8a77470: Add SDHI0 support
      ARM: dts: r8a77470: Add SDHI1 support
      ARM: dts: iwg23s-sbc: Add uSD and eMMC support
      ARM: dts: r8a77470: Add QSPI support
      ARM: dts: iwg23s-sbc: Add QSPI flash support

Laurent Pinchart (1):
      ARM: dts: r8a779[01]: Disable unconnected LVDS encoders

Magnus Damm (1):
      ARM: dts: r8a7740, emev2, sh73a0: Include SoC name in DTSI

Phil Edworthy (2):
      ARM: dts: r9a06g032: Add pinctrl node
      ARM: dts: r9a06g032: Correct the GIC DT node name

 arch/arm/boot/dts/emev2.dtsi              |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi            |   2 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 119 ++++++++++++++++
 arch/arm/boot/dts/r8a77470.dtsi           | 222 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7790-lager.dts       |   2 -
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   2 -
 arch/arm/boot/dts/r8a7791-porter.dts      |   2 -
 arch/arm/boot/dts/r9a06g032.dtsi          |  10 +-
 arch/arm/boot/dts/sh73a0.dtsi             |   2 +-
 9 files changed, 352 insertions(+), 11 deletions(-)
