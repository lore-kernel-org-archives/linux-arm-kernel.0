From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:52 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.14
Message-ID: <cover.1502962873.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.14.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.14,
which you have already pulled.


The following changes since commit bf38b9ac16c5c8a82d63c79391dd64c5924fc00b:

  ARM: dts: iwg20m: Correct indentation of mmcif0 properties (2017-07-31 17:10:14 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.14

for you to fetch changes up to a4bc74d570a79dbfeb64766b130c0113ac39ec3e:

  ARM: dts: r8a7791: Use R-Car SATA Gen2 fallback compat string (2017-08-17 11:02:51 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.14

* Use newly added Gen-3 fallback compat string

  This is consistent with ongoing efforts to use per-generation
  fallback strings where appropriate across devices found
  on R-Car SoCs. The aim of the effort being to strike a balance
  between the limited information available about the compatibility
  of devices found on different SoCs and the desire to ease enabling
  devices on new SoCs.

  This has no run-time effect due to the presence of a per-SoC
  compat string.

* Enable second CPU core on RZ/G1M (r8a7743)

  The RZ/G1M has two CA15 cores running at up to 1.5GHz

* Enable frequency scaling on RZ/G1M (r8a7743)

* Add six I2C cores to RZ/G1M (r8a7743) SoC DT

  This is a step towards enabling these cores on boards that use this SoC

* Add CEC clock for HDMI transmitter to R-Car M2-W (r8a7791) Koelsch

  Hans Verkuil says "The adv7511 on the Koelsch board has a 12 MHz fixed
  clock for the CEC block. Specify this in the dts to enable CEC support."

* Add PFC support to RZ/G1E (r8a7745) SoC and add Ethernet and SCIF2
  pins to SK-RZG1E board.

  This allows the kernel to control multiplexed pins for Ethernet
  and SCIF2 rather than relying on setup inherited at boot.

----------------------------------------------------------------
Biju Das (3):
      ARM: dts: r8a7743: Add I2C DT support
      ARM: dts: r8a7743: Add APMU node and second CPU core
      ARM: dts: r8a7743: Add OPP table for frequency scaling

Hans Verkuil (1):
      ARM: dts: koelsch: Add CEC clock for HDMI transmitter

Sergei Shtylyov (3):
      ARM: dts: r8a7745: add PFC support
      ARM: dts: sk-rzg1e: add SCIF2 pins
      ARM: dts: sk-rzg1e: add Ether pins

Simon Horman (2):
      ARM: dts: r8a7790: Use R-Car SATA Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car SATA Gen2 fallback compat string

 arch/arm/boot/dts/r8a7743.dtsi         | 122 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts |  25 ++++++-
 arch/arm/boot/dts/r8a7745.dtsi         |   7 +-
 arch/arm/boot/dts/r8a7790.dtsi         |   4 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts  |   8 +++
 arch/arm/boot/dts/r8a7791.dtsi         |   4 +-
 6 files changed, 164 insertions(+), 6 deletions(-)
