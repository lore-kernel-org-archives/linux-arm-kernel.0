From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:18 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.20
Message-ID: <cover.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.20.

I am sending out this pull-request at this time as there are a number
of patches queued up in my arm (32) DT branch and I hope that this
will ease the burden later on in the development cycle. I expect to
send a follow-up pull-request for this branch at the usual pre-rc6 timing.


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.20

for you to fetch changes up to 1926bd6bf20fe306797fbf366902674d2d6c20cc:

  ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions (2018-09-06 11:31:35 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.20

* R-Car Gen1 SoCs: Include product name in DTSI files for ease of maintenance
* R-Car Gen2 SoCs:
  - Convert to new DU DT bindings
  - Correct SATA device sizes to 2 MiB
* R-Car H2 (r8a7790) based Porter board: Add DA9063 OnKey PMIC node
* R-Car E2 (r8a7794) based Silk board: Add DA9063 PMIC, RTC and OnKey nodes
* R-Car M2-N (r8a7793) based Gose board: Add DA9210 node for CPU DVFS
* RZ/G1C (R8A77470) SoC:
  - Add GPIO nodes
  - Add PFC support
  - Use r8a77470-sysc binding definitions
* RZ/G1C (r8a77470) iW-RainboW-G23S dev platform:
  - Specify EtherAVB PHY IRQ
  - Add pinctl support for scif1
* RZ/N1D (r9a06g032) SoC: Use r9a06g032-sysctrl binding definitions

----------------------------------------------------------------
Biju Das (5):
      ARM: dts: r8a77470: Use r8a77470-sysc binding definitions
      ARM: dts: r8a77470: Add PFC support
      ARM: dts: iwg23s-sbc: Add pinctl support for scif1
      ARM: dts: r8a77470: Add GPIO support
      ARM: dts: iwg23s-sbc: specify EtherAVB PHY IRQ

Geert Uytterhoeven (2):
      ARM: dts: rcar: Correct SATA device sizes to 2 MiB
      ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions

Laurent Pinchart (1):
      ARM: dts: rcar-gen2: Convert to new DU DT bindings

Magnus Damm (1):
      ARM: dts: Include R-Car Gen1 product name in DTSI files

Marek Vasut (4):
      ARM: dts: gose: Add DA9210 node for CPU DVFS
      ARM: dts: silk: Add DA9063 PMIC node
      ARM: dts: silk: Add DA9063 RTC and OnKey node
      ARM: dts: stout: Add DA9063 OnKey node

 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts |  12 +++
 arch/arm/boot/dts/r8a77470.dtsi           | 123 ++++++++++++++++++++++++++----
 arch/arm/boot/dts/r8a7778.dtsi            |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi            |   4 +-
 arch/arm/boot/dts/r8a7790-stout.dts       |   4 +
 arch/arm/boot/dts/r8a7790.dtsi            |   4 +-
 arch/arm/boot/dts/r8a7791.dtsi            |   4 +-
 arch/arm/boot/dts/r8a7792.dtsi            |   1 -
 arch/arm/boot/dts/r8a7793-gose.dts        |  16 ++++
 arch/arm/boot/dts/r8a7794-silk.dts        |  25 ++++++
 arch/arm/boot/dts/r8a7794.dtsi            |   1 -
 arch/arm/boot/dts/r9a06g032.dtsi          |   7 +-
 12 files changed, 178 insertions(+), 25 deletions(-)
