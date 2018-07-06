From: luaraneda@gmail.com (Luis Araneda)
Date: Fri,  6 Jul 2018 02:01:55 -0400
Subject: [PATCH v2 0/3] arm: dts: zynq: improvements and cleanup
Message-ID: <20180706060158.24155-1-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to standardize device naming and improve
its information for better identification

The values of the "compatible" and "model" device-tree properties
are corrected for some devices, adding complementary information
when necessary

Changes since v1 (RFC):
- Add values to compatible property instead of replacing them
- Don't remove "internal" word from Xilinx boards on dt-bindings
- Migrate content of adapteva dt-binding file into Xilinx's
- Sort additional compatible strings alphabetically
  by manufacturer
- Dropped patch that renamed the zedboard development board
  (no apparent benefit)
- Dropped the patch that removed the "zynq" value from the
  compatible strings (breaks the ABI)

Luis Araneda (3):
  arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
    boards
  dt-bindings: xilinx: Add missing zynq boards and sort entries
  arm: dts: zynq: correct and improve the model property of dt files

 .../devicetree/bindings/arm/adapteva.txt      |  7 -----
 .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
 arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
 arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
 arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
 arch/arm/boot/dts/zynq-zed.dts                |  4 +--
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
 14 files changed, 39 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

-- 
2.18.0
