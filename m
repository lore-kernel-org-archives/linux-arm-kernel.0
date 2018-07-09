From: faiz_abbas@ti.com (Faiz Abbas)
Date: Mon, 9 Jul 2018 22:18:35 +0530
Subject: [PATCH v5 0/6] Add MCAN Support for dra76x
Message-ID: <20180709164841.14182-1-faiz_abbas@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add dts and sysconfig support
for MCAN on TI's dra76 SOCs

Changes in v5:
 Return from sysc_reset() with error if syss_mask is not
 present. That is the only supported way of reset

Changes in v4:
 1. Rebased to latest kernel
 2. Using ddata->cfg.syss_mask instead of ddata->cfg.quirks
    for checking if poll on reset status is required.

Changes in v3:
 1. Added reset functionality to the ti-sysc
    driver. This enables me to drop the hwmod
    data patch as everything is being done in dt.

 2. Dropped ti,hwmods from the dts nodes

 3. Fixed the unit address of target-module
    and mcan

 4. Removed the status="disabled" in dtsi
    followed by status="okay" in dts.

Changes in v2:
 1. Added Support for mcan in the ti-sysc driver
    Also added the target-module node for the same

 2. Added clkctrl data for mcan clocks

Faiz Abbas (5):
  clk: ti: dra7: Add clkctrl clock data for the mcan clocks
  bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
  bus: ti-sysc: Add support for software reset
  ARM: dts: Add generic interconnect target module node for MCAN
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (1):
  ARM: dts: dra762: Add MCAN clock support

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 arch/arm/boot/dts/dra76-evm.dts               |  6 ++
 arch/arm/boot/dts/dra76x.dtsi                 | 64 +++++++++++++++++++
 drivers/bus/ti-sysc.c                         | 62 ++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                      |  1 +
 include/dt-bindings/bus/ti-sysc.h             |  2 +
 include/dt-bindings/clock/dra7.h              |  1 +
 include/linux/platform_data/ti-sysc.h         |  1 +
 8 files changed, 138 insertions(+)

-- 
2.17.0
