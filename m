From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 14 Oct 2016 18:30:24 +0530
Subject: [PATCH 0/9] ARM: DRA7: Add support for DRA718-evm
Message-ID: <20161014130033.14172-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series does minor dts cleanup for dra72-evm and adds support for
DRA718-evm.

Logs:
DRA718-evm: http://pastebin.ubuntu.com/23323331/
DRA72-evm-revc: http://pastebin.ubuntu.com/23323356/

Lokesh Vutla (7):
  ARM: dts: dra72-evm: Remove pinmux configurations for erratum i869
  ARM: dra72-evm: Fix modelling of regulators
  ARM: dts: dra72: Add separate dtsi for tps65917
  regulator: lp873x: Add support for populating input supply
  ARM: OMAP2+: board-generic: add support for DRA71x family
  ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
  ARM: omap2plus_defconfig: Enable LP873X support

Nishanth Menon (2):
  ARM: DRA7: hwmod: Do not register RTC on DRA71
  ARM: dts: Add support for dra718-evm

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 Documentation/devicetree/bindings/mfd/lp873x.txt   |   8 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/dra71-evm.dts                    | 230 ++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 348 +++------------------
 arch/arm/boot/dts/dra72-evm-revc.dts               |  21 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          | 134 ++++++++
 arch/arm/boot/dts/dra72-evm.dts                    |  14 +-
 arch/arm/configs/omap2plus_defconfig               |   3 +
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  10 +-
 drivers/regulator/lp873x-regulator.c               |   1 +
 12 files changed, 453 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra71-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi

-- 
2.9.3
