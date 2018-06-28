From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 28 Jun 2018 01:42:00 -0400
Subject: [RFC PATCH 0/5] arm: dts: zynq: improvements and cleanup
Message-ID: <20180628054205.17737-1-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to standardize device naming and improve
its information for better identification

The values of the "compatible" and "model" device-tree properties
are corrected for some devices, adding complementary information
when necessary

Additionally, a device-tree file is renamed to reflect the real model
of the device

I'm sending the series as an RFC because I don't know if
device-tree files can be renamed and properties be changed
(the last patch in particular)

The patches are sorted (descending) by what I think is
the probability of being accepted

Luis Araneda (5):
  arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
    boards
  dt-bindings: xilinx: Add missing zynq boards
  arm: dts: zynq: correct and improve the model property of dt files
  arm: dts: zynq: rename board zed to zedboard
  arm: dts: zynq: remove "zynq" prefix from compatible property

 .../devicetree/bindings/arm/xilinx.txt        | 34 ++++++++++++++-----
 arch/arm/boot/dts/Makefile                    |  2 +-
 arch/arm/boot/dts/zynq-cc108.dts              |  4 +--
 arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
 arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  4 +--
 arch/arm/boot/dts/zynq-zc706.dts              |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  4 +--
 .../dts/{zynq-zed.dts => zynq-zedboard.dts}   |  4 +--
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  4 +--
 arch/arm/boot/dts/zynq-zybo.dts               |  4 +--
 14 files changed, 50 insertions(+), 32 deletions(-)
 rename arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} (89%)

-- 
2.18.0
