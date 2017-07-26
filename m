From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 26 Jul 2017 14:05:59 +0800
Subject: [PATCH v2 0/4] Enable usb2 function on poplar board
Message-ID: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is mainly used to enable the usb2 function on poplar board,
including usb2 phy drivers, dts nodes and configs.

Jiancheng Xue (3):
  dt-bindings: phy-hisi-inno-usb2: add support for hisi-inno-usb2 phy
  arm64: dts: hisilicon: add usb2 controller and phy nodes for poplar
    board.
  arm64: defconfig: enable some drivers for hi3798cv200-poplar board.

Pengcheng Li (1):
  phy: add inno-usb2-phy driver for hi3798cv200 SoC

 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  31 +++
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  13 ++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |  60 ++++++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/phy/hisilicon/Kconfig                      |  11 +-
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         | 236 +++++++++++++++++++++
 7 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 drivers/phy/hisilicon/phy-hisi-inno-usb2.c

-- 
1.9.1
