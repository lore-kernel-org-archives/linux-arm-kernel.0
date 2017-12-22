From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:10 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.16
Message-ID: <cover.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for
v4.16.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.16,
which you have already pulled.


The following changes since commit 7f32eddb81ecc06131a643babe2d0f961fbd7f08:

  ARM: dts: alt: Convert to named i2c-gpio bindings (2017-12-04 09:34:53 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.16

for you to fetch changes up to 5b062010675b3d74c9a6c6896e2becf932a4ca74:

  ARM: dts: r8a7745: Add missing clock for secondary CA7 CPU core (2017-12-22 09:24:00 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.16

* r8a7745 (RZ/G1E) SoC
  - Enable SMP

    Fabrizio Castro says "Add DT node for the Advanced Power Management
    Unit (APMU), add the second CPU core, and use "renesas,apmu" as
    "enable-method"."

* r8a7743 (RZ/G1M) SoC
  - Add node for thermal sensor module with thermal-zone support

* r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs
  - Add:
    + Renesas Core Match Timer (CMT) support
    + Renesas Timer Pulse Unit PWM Controller (TPU) support
    + Renesas PWM Timer Controller (PWM) support

* r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven and
  r8a7745 (RZ/G1E) iW-RainboW-G22D development platforms
  - Add sound support

* r8a7743 (RZ/G1M), r8a7745 (RZ/G1E) and r8a7792 (R-Car V2H) SoCs
  - Allow DTBs of boards of these SoCs to build without any warnings when
    compiled with W=1 using gcc-linaro-5.4.1-2017.05
    + Move nodes which have no reg property out of bus, they don't belong there
    + Also sort sub-nodes of root node to allow for easier maintenance

* r8a7790 (R-Car H2), r8a7791 (R-Car M2-W) and r8a7793 (R-Car M2-N) SoCs
  - Correct critical CPU temperature

    Chris Paterson says "The current R-Car Gen2 device trees define the CPU
    critical temperature as 115?C.

    The R-Car hardware manuals state that Tc = ?40?C to +105?C. The thermal
    sensor has an accuracy of ?5?C and there can be a temperature
    difference of 1 or 2 degrees between Tjmax and the thermal sensor due
    to the location of the latter.

    This means that 95?C is a safer value to use.

    This value should also apply to r8a7792 but thermal sensor support has
    not been added yet."

* r8a7740 (R-Mobile A1) SoC
  - Correct TPU register block size

    Geert Uytterhoven says "The Timer Pulse Unit has registers that lie
    outside the declared register block.  Enlarge the register block size to
    fix this.

    This was probably based on the old platform code, which also assumed a
    register block size of 0x100."

----------------------------------------------------------------
Biju Das (20):
      ARM: dts: r8a7743: Add audio clocks
      ARM: dts: r8a7743: Add audio DMAC support
      ARM: dts: r8a7743: Add sound support
      ARM: dts: r8a7743: Add thermal device to DT
      ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio codec
      ARM: dts: iwg20d-q7-common: Sound PIO support
      ARM: dts: iwg20d-q7-common: Sound DMA support on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via BUSIF on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via SRC on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via DVC on DTS
      ARM: dts: r8a7745: Add audio clocks
      ARM: dts: r8a7745: Add audio DMAC support
      ARM: dts: r8a7745: Add sound support
      ARM: dts: iwg22d-sodimm: Enable SGTL5000 audio codec
      ARM: dts: iwg22d-sodimm: Sound PIO support
      ARM: dts: iwg22d-sodimm: Sound DMA support on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via BUSIF on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via SRC on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via DVC on DTS
      ARM: dts: r8a7745: Add missing clock for secondary CA7 CPU core

Chris Paterson (3):
      ARM: dts: r8a7790: Correct critical CPU temperature
      ARM: dts: r8a7791: Correct critical CPU temperature
      ARM: dts: r8a7793: Correct critical CPU temperature

Fabrizio Castro (7):
      ARM: dts: r8a7745: Add APMU node and second CPU core
      ARM: dts: r8a7743: Add PWM SoC support
      ARM: dts: r8a7743: Add TPU support
      ARM: dts: r8a7745: Add PWM SoC support
      ARM: dts: r8a7745: Add TPU support
      ARM: dts: r8a7743: Add CMT SoC specific support
      ARM: dts: r8a7745: Add CMT SoC specific support

Geert Uytterhoeven (1):
      ARM: dts: r8a7740: Correct TPU register block size

Simon Horman (6):
      ARM: dts: r8a7745: sort root sub-nodes alphabetically
      ARM: dts: r8a7745: move timer node out of bus
      ARM: dts: r8a7792: sort root sub-nodes alphabetically
      ARM: dts: r8a7792: move timer node out of bus
      ARM: dts: r8a7743: sort root sub-nodes alphabetically
      ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus

 arch/arm/boot/dts/iwg20d-q7-common.dtsi     |  88 +++++
 arch/arm/boot/dts/r8a7740.dtsi              |   2 +-
 arch/arm/boot/dts/r8a7743.dtsi              | 486 +++++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts |  92 ++++++
 arch/arm/boot/dts/r8a7745.dtsi              | 421 ++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7790.dtsi              |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi              |   2 +-
 arch/arm/boot/dts/r8a7792.dtsi              |  64 ++--
 arch/arm/boot/dts/r8a7793.dtsi              |   2 +-
 9 files changed, 1051 insertions(+), 108 deletions(-)
