From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 20 Sep 2018 15:00:41 +0530
Subject: [RFC PATCH v2 0/4] Add support for SD Tap Delay setting for ZynqMP
Message-ID: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches are created On top of the
below series of patches.
1. https://lkml.org/lkml/2018/8/3/687 
2. https://lkml.org/lkml/2018/9/18/1034

As the ZynqMP Firmware Driver is not yet merged, sending RFC to make
modifications before sending the final patches.

Changes in v2:
- s/_/-/ in the property name
- Changed order of the patches : DT binding change -> driver change -> DT change

Manish Narani (4):
  dt: bindings: Add SD tap value properties details for
    'xlnx,zynqmp-8.9a'
  firmware: xilinx: Add macros and API for SD tap delays
  sdhci: arasan: Add support to read and set tap delays from DT for
    ZynqMP
  arm64: zynqmp: Add 'xlnx,mio-bank' property in SDHCI node

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  19 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   2 +
 drivers/firmware/xilinx/Makefile                   |   1 +
 drivers/firmware/xilinx/zynqmp-tap-delays.c        |  39 ++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 215 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  33 +++-
 6 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp-tap-delays.c

-- 
2.1.1
