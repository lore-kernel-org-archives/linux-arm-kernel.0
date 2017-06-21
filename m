From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 21 Jun 2017 17:00:40 +0800
Subject: [PATCH 0/5] enable usb2 function on poplar board.
Message-ID: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is mainly used to enable usb2 function on poplar board.

Jiancheng Xue (4):
  clk: hisilicon: add usb2 clocks for hi3798cv200 SoC
  dt-bindings: phy-hisi-inno-usb2: add support for hisi-inno-usb2 phy
  arm64: dts: hisilicon: add usb2 controller and phy nodes for poplar
    board.
  arm64: defconfig: enable some drivers and configs for
    hi3798cv200-poplar board.

Pengcheng Li (1):
  phy: add inno-usb2-phy driver for hi3798cv200 SoC

 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  36 +++
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  13 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |  47 ++++
 arch/arm64/configs/defconfig                       |  13 +-
 drivers/clk/hisilicon/crg-hi3798cv200.c            |  21 ++
 drivers/phy/Kconfig                                |  10 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-hisi-inno-usb2.c                   | 287 +++++++++++++++++++++
 include/dt-bindings/clock/histb-clock.h            |   9 +-
 9 files changed, 435 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 drivers/phy/phy-hisi-inno-usb2.c

-- 
1.9.1
