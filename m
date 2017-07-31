From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:45 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.14
Message-ID: <cover.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.14.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.14

for you to fetch changes up to bf38b9ac16c5c8a82d63c79391dd64c5924fc00b:

  ARM: dts: iwg20m: Correct indentation of mmcif0 properties (2017-07-31 17:10:14 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.14

Changes of note:

* Add pin controller support to the RZ/G1M (r8a7743) SoC and
  RZ/A1 (r7s72100) SoCs now that the driver is available in v4.13-rc1.

* Add GPIO support to the RZ/G1M (r8a7743) SoC now that the driver
  is availabe in v4.13-rc1.

* Enable MMCIF0 and Ethernet AVB support on the RZ/G1M (r8a7743) SoC and
  the iWave-RZG1M-20M Qseven SOM. This depends on newly added pin
  controller support noted above.

* Use R-Car Gen 2 fallback binding for vin nodes

  This makes binding use consistent across R-Car Gen 2 SoCs.
  It does not have any run-time effect

* Use SMP jump stub SRAM region from DT on R-Car Gen 2 SoCs

  Geert Uytterhoeven says, "The R-Car Gen2 platform code for CPU core
  bringup needs to copy a jump stub to on-SoC SRAM.  Currently it uses a
  hardcoded address pointing to ICRAM1."

* Add Inter Connect RAM to R-Car Gen 2 and RZ/G1 SoCs

  Geert Uytterhoeven says, "R-Car Gen2 and RZ/G1 SoCs contain two or three
  blocks of SRAM, which can be used for several purposes.  One such purpose
  is holding a jump stub for CPU core bringup."
* Use generic compatible string for I2C EEPROM for RZ/A1 (r7s72100) SoC
  and koelsch board.

  This is part of a tree-wide cleanup by Javier Martinez Canillas

----------------------------------------------------------------
Biju Das (4):
      ARM: dts: r8a7743: Add GPIO support
      ARM: dts: iwg20d-q7: Add pinctl support for scif0
      ARM: dts: r8a7743: Add Ethernet AVB support
      ARM: dts: iwg20d-q7: Add Ethernet AVB support

Chris Brandt (4):
      ARM: dts: rskrza1: Add SCIF2 pin group
      ARM: dts: rskrza1: Add Ethernet pin group
      ARM: dts: rskrza1: Add SDHI1 pin group
      ARM: dts: rskrza1: Add LED0 pin support

Chris Paterson (2):
      ARM: dts: r8a7743: Add MMCIF0 support
      ARM: dts: iwg20m: Add MMCIF0 support

Geert Uytterhoeven (15):
      ARM: dts: r8a7743: Add Inter Connect RAM
      ARM: dts: r8a7745: Add Inter Connect RAM
      ARM: dts: r8a7790: Add Inter Connect RAM
      ARM: dts: r8a7791: Add Inter Connect RAM
      ARM: dts: r8a7792: Add Inter Connect RAM
      ARM: dts: r8a7793: Add Inter Connect RAM
      ARM: dts: r8a7794: Add Inter Connect RAM
      ARM: dts: r8a7743: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7745: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7790: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7791: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7792: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7793: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7794: Reserve SRAM for the SMP jump stub
      ARM: dts: iwg20m: Correct indentation of mmcif0 properties

Jacopo Mondi (5):
      ARM: dts: r7s72100: Add pin controller node
      ARM: dts: genmai: Add SCIF2 pin group
      ARM: dts: genmai: Add RIIC2 pin group
      ARM: dts: genmai: Add user led device nodes
      ARM: dts: genmai: Add ethernet pin group

Javier Martinez Canillas (2):
      ARM: dts: r7s72100: Add generic compatible string for I2C EEPROM
      ARM: dts: koelsch: Add generic compatible string for I2C EEPROM

Sergei Shtylyov (3):
      ARM: dts: r8a7743: add PFC support
      ARM: dts: sk-rzg1m: add SCIF0 pins
      ARM: dts: sk-rzg1m: add Ether pins

Simon Horman (3):
      ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for vin nodes
      ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for vin nodes
      ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for vin nodes

 arch/arm/boot/dts/r7s72100-genmai.dts   |  71 ++++++++++++-
 arch/arm/boot/dts/r7s72100-rskrza1.dts  |  61 +++++++++++
 arch/arm/boot/dts/r7s72100.dtsi         |  78 ++++++++++++++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts |  31 ++++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi   |  26 +++++
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts  |  25 ++++-
 arch/arm/boot/dts/r8a7743.dtsi          | 179 +++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7745.dtsi          |  23 ++++
 arch/arm/boot/dts/r8a7790.dtsi          |  26 ++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts   |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi          |  24 ++++-
 arch/arm/boot/dts/r8a7792.dtsi          |  18 ++++
 arch/arm/boot/dts/r8a7793.dtsi          |  18 ++++
 arch/arm/boot/dts/r8a7794.dtsi          |  22 +++-
 14 files changed, 591 insertions(+), 13 deletions(-)
