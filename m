From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:17:56 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.11
Message-ID: <cover.1483700694.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.11.

This is based on v4.10-rc2 as v4.10-rc1 does not compile using
the defconfig.


The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.11

for you to fetch changes up to b2b9443beee5017ebdb3f2be9ef472c73d260481:

  arm64: dts: r8a7795: Add PWM support (2017-01-04 10:00:44 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.11

* Add PWM, and sound MIX and CTU support to r8a7795 SoC
* Add CAN, CAN FD and all MSIOF nodes to r8a7796 SoC
* Use Gen 3 fallback binding for i2c, msiof, PCIE and USB2 phy
* Enable Ethernet and 4 GiB memory on r8a7796/salvator-x board
* Add r8a7796/salvator-x board part number to bindings

----------------------------------------------------------------
Chris Paterson (3):
      arm64: dts: r8a7796: Add CAN external clock support
      arm64: dts: r8a7796: Add CAN support
      arm64: dts: r8a7796: Add CAN FD support

Geert Uytterhoeven (2):
      arm64: dts: r8a7796: Add all MSIOF nodes
      arm64: renesas: r8a7796/salvator-x: Add board part number to DT bindings

Kuninori Morimoto (2):
      arm64: dts: r8a7795: add sound CTU support
      arm64: dts: r8a7795: add sound MIX support

Laurent Pinchart (3):
      arm64: dts: renesas: r8a7796: Add EthernetAVB instance
      arm64: dts: r8a7796: salvator-x: Enable EthernetAVB
      arm64: dts: r8a7795: Add PWM support

Simon Horman (5):
      arm64: dts: r8a7795: Use renesas,rcar-gen3-usb2-phy fallback binding
      arm64: dts: r8a7795: Use Gen 3 fallback compat string for PCIE
      arm64: dts: r8a7795: Use R-Car Gen 3 fallback binding for i2c nodes
      arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for i2c nodes
      arm64: dts: r8a7796: Use R-Car Gen 3 fallback binding for msiof nodes

Takeshi Kihara (1):
      arm64: dts: r8a7796: salvator-x: Update memory node to 4 GiB map

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 119 ++++++++++++--
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  37 +++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 183 ++++++++++++++++++++-
 5 files changed, 323 insertions(+), 20 deletions(-)
