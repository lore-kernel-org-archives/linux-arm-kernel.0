From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:38 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.16
Message-ID: <cover.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.16.


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.16

for you to fetch changes up to 7f32eddb81ecc06131a643babe2d0f961fbd7f08:

  ARM: dts: alt: Convert to named i2c-gpio bindings (2017-12-04 09:34:53 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.16

* Convert to named i2c-gpio bindings

  Geert Uytterhoeven says "Commits 7d29f509d2cfd807 ("dt-bindings: i2c:
  i2c-gpio: Add support for named gpios") and 05c74778858d7d99 ("i2c: gpio:
  Add support for named gpios in DT") introduced named i2c-gpio DT
  bindings, and deprecated the more error-prone unnamed variant.

  This patch series switches all Renesas boards to the new bindings, and
  adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
  assumed before..."

  ...  Note that after this series is applied, the i2c-gpio buses are no
  longer detected when booting new DTBs on old (v4.14 and older) kernels,
  which should not be an issue.  Booting old DTBs on new kernels is not
  affected."

* Update DTS for CMT DT binding rework

  Geert Uytterhoeven says "This patch series updates the CMT device nodes
  in the various Renesas DTS files sh_cmt clocksource driver for the recent
  DT binding rework that was merged in v4.14-rc1 and v4.15-rc1..."

* Add SMP support to r8a7794 (R-Car E2) SoC

  Sergei Shtylyov says "Add the device tree node for the Advanced Power
  Management Unit (APMU).  Use the "enable-method" prop to  point out that
  the APMU should be used for the SMP support."

* Correct primary compatible value for eeprom
  on r7s72100 (RZ/A1H) genmai and r8a7791 (R-Car M2-W) koelsh boards

  Geert Uytterhoeven says "The Renesas part numbers of the two-wire serial
  interface EEPROMs do not follow the 24Cxx pattern, but the R1EX24xxx
  pattern.

  Hence change the primary compatible values to the appropriate variant of
  "renesas,r1ex24xxx", like is already done on Gose.""

* Move cec_clock to root node on r8a7791 (R-Car M2-W) koelsh board
  r8a7791 (R-Car M2-W) koelsh board

* Use R-Car SDHI and Ether Gen1 and 2 fallback compat strings

  Use recently posted R-Car SDHI and Ether Gen 1 and 2 fallback
  compat strings in the DT of Renesas ARM based SoCs.

* Add IIC cores to dtsi of r8a7745 (RZ/G1E) SoC

* Rework DT architecture for r8a7745 (RZ/G1E) iW-RainboW-G22D development
  platform and add serial support.

  Fabrizio Castro says "... define a new DT architecture for the
  iW-RainboW-G22D SODIMM Development Platform to include the configuration
  with the HDMI daughter board and to define the serial interfaces."

* Add USB function support to
  r8a7745 (RZ/G1E) iW-RainboW-G22D development platform

* Add PCIEC and ttySC3 support to r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven SoM

* Add VIN support to r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs

* Add CAN and HDMI support to r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven and
  r8a7745 (RZ/G1E) iW-RainboW-G22D development platforms

----------------------------------------------------------------
Biju Das (7):
      ARM: dts: r8a7745: Add HS-USB device node
      ARM: dts: r8a7745: Add USB-DMAC device nodes
      ARM: dts: r8a7745: Enable DMA for HSUSB
      ARM: dts: iwg22d-sodimm: Enable HS-USB
      ARM: dts: r8a7743: Add default PCIe bus clock
      ARM: dts: r8a7743: Add PCIe Controller device node
      ARM: dts: iwg20d-q7: Enable PCIe Controller

Fabrizio Castro (18):
      ARM: dts: r8a7743: Add DU support
      ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI video output
      ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
      ARM: dts: iwg22d: Add /dev/ttySC5 support
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for HDMI DB
      ARM: dts: iwg22d-sodimm: sort dt nodes
      ARM: dts: r8a7745: Add IIC cores to dtsi
      ARM: dts: iwg20d-q7: Add support for ttySC3
      ARM: dts: r8a7745: Add DU support
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add HDMI video output
      ARM: dts: r8a7745: Add CAN[01] SoC support
      ARM: dts: iwg22d-sodimm: Add can0 support to carrier board
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add can1 support to HDMI DB
      ARM: dts: r8a7743: Add CAN[01] SoC support
      ARM: dts: iwg20d-q7-common: Add can0 support to carrier board
      ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera DB
      ARM: dts: r8a7743: add VIN dt support
      ARM: dts: r8a7745: add VIN dt support

Geert Uytterhoeven (6):
      ARM: dts: koelsch: Correct primary compatible value for eeprom
      ARM: dts: genmai: Correct primary compatible value for eeprom
      ARM: dts: armadillo800eva: Convert to named i2c-gpio bindings
      ARM: dts: lager: Convert to named i2c-gpio bindings
      ARM: dts: koelsch: Convert to named i2c-gpio bindings
      ARM: dts: alt: Convert to named i2c-gpio bindings

Magnus Damm (12):
      ARM: dts: r8a73a4: Update CMT compat string
      ARM: dts: r8a7790: Update CMT compat strings
      ARM: dts: r8a7791: Update CMT compat strings
      ARM: dts: r8a7793: Update CMT compat strings
      ARM: dts: r8a7794: Update CMT compat strings
      ARM: dts: r8a73a4: Remove CMT renesas,channels-mask
      ARM: dts: r8a7740: Remove CMT renesas,channels-mask
      ARM: dts: r8a7790: Remove CMT renesas,channels-mask
      ARM: dts: r8a7791: Remove CMT renesas,channels-mask
      ARM: dts: r8a7793: Remove CMT renesas,channels-mask
      ARM: dts: r8a7794: Remove CMT renesas,channels-mask
      ARM: dts: sh73a0: Remove CMT renesas,channels-mask

Sergei Shtylyov (1):
      ARM: dts: r8a7794: Add SMP support

Simon Horman (17):
      ARM: dts: r8a7743: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7745: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7778: Use R-Car Gen1 Ether fallback compat string
      ARM: dts: r8a7790: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7791: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7793: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7794: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7743: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7745: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7778: Use R-Car SDHI Gen1 fallback compat string
      ARM: dts: r8a7779: Use R-Car SDHI Gen1 fallback compat string
      ARM: dts: r8a7790: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7792: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7793: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7794: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: koelsch: Move cec_clock to root node

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  34 ++++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |  87 ++++++++++
 arch/arm/boot/dts/r7s72100-genmai.dts              |   2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   5 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |   3 -
 arch/arm/boot/dts/r8a7743.dtsi                     | 149 ++++++++++++++++-
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 158 ++++++++++++++++++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |  99 ++++++++----
 arch/arm/boot/dts/r8a7745.dtsi                     | 180 ++++++++++++++++++++-
 arch/arm/boot/dts/r8a7778.dtsi                     |  12 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |  12 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |   5 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  23 +--
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  19 ++-
 arch/arm/boot/dts/r8a7791.dtsi                     |  20 +--
 arch/arm/boot/dts/r8a7792.dtsi                     |   3 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  20 +--
 arch/arm/boot/dts/r8a7794-alt.dts                  |   5 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  27 ++--
 arch/arm/boot/dts/sh73a0.dtsi                      |   3 -
 22 files changed, 753 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
