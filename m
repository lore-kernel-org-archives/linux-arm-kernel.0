From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 22 Dec 2016 17:13:23 +1300
Subject: [PATCH 0/5] Support for Marvell switches with integrated CPUs
Message-ID: <20161222041328.3303-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
integrated CPUs. They CPU block is common within these product lines and
(as far as I can tell/have been told) is based on the Armada XP. There
are a few differences due to the fact they have to squeeze the CPU into
the same package as the switch.

Chris Packham (4):
  clk: mvebu: support for 98DX3236 SoC
  arm: mvebu: support for SMP on 98DX3336 SoC
  arm: mvebu: Add device tree for 98DX3236 SoCs
  arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards

Kalyan Kinthada (1):
  pinctrl: mvebu: pinctrl driver for 98DX3236 SoC

 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  18 ++
 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  10 +
 .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 231 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  78 +++++++
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  78 +++++++
 arch/arm/boot/dts/db-dxbc2.dts                     | 159 ++++++++++++++
 arch/arm/boot/dts/db-xc3-24g4xg.dts                | 155 ++++++++++++++
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/common.h                       |   1 +
 arch/arm/mach-mvebu/platsmp.c                      |  43 ++++
 arch/arm/mach-mvebu/pmsu-98dx3236.c                |  69 ++++++
 drivers/clk/mvebu/Makefile                         |   2 +-
 drivers/clk/mvebu/armada-xp.c                      |  42 ++++
 drivers/clk/mvebu/clk-cpu.c                        |  33 ++-
 drivers/clk/mvebu/mv98dx3236-corediv.c             | 207 ++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 145 +++++++++++++
 17 files changed, 1314 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
 create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts
 create mode 100644 arch/arm/mach-mvebu/pmsu-98dx3236.c
 create mode 100644 drivers/clk/mvebu/mv98dx3236-corediv.c

-- 
2.11.0.24.ge6920cf
