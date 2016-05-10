From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 10 May 2016 16:23:28 +0800
Subject: Add MediaTek USB3 DRD Driver
Message-ID: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 5e3e992dc3c02eda12f5cf984a18a57f0207333d Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Tue, 10 May 2016 16:04:25 +0800
Subject: [PATCH 0/6] Add MediaTek USB3 DRD Driver

These patches introduce the MediaTek USB3 dual-role controller
driver.

The driver can be configured as Dual-Role Device (DRD),
Peripheral Only and Host Only (xHCI) modes. It works well
with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
tested on MT8173 platform which only contains USB2.0 device IP,
and on MT6290 platform which contains USB3.0 device IP.


Chunfeng Yun (6):
  dt-bindings: mt8173-xhci: support host side of dual-role mode
  usb: xhci-mtk: make IPPC register optional
  dt-bindings: mtu3: add devicetree bindings
  usb: Add MediaTek USB3 DRD Driver
  arm64: dts: mediatek: add USB3 DRD driver
  pinctrl: mt8173: set GPIO16 to usb iddig mode

 .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++
 Documentation/devicetree/bindings/usb/mtu3.txt     |   86 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   46 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   28 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h      |    2 +-
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/Makefile                               |    1 +
 drivers/usb/host/xhci-mtk.c                        |   32 +-
 drivers/usb/mtu3/Kconfig                           |   47 ++
 drivers/usb/mtu3/Makefile                          |   20 +
 drivers/usb/mtu3/mtu3.h                            |  422 ++++++++++
 drivers/usb/mtu3/mtu3_core.c                       |  877 +++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c                         |  353 ++++++++
 drivers/usb/mtu3/mtu3_dr.h                         |  108 +++
 drivers/usb/mtu3/mtu3_gadget.c                     |  735 ++++++++++++++++
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  889 ++++++++++++++++++++
 drivers/usb/mtu3/mtu3_host.c                       |  294 +++++++
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  474 +++++++++++
 drivers/usb/mtu3/mtu3_plat.c                       |  496 +++++++++++
 drivers/usb/mtu3/mtu3_qmu.c                        |  599 +++++++++++++
 drivers/usb/mtu3/mtu3_qmu.h                        |   43 +
 21 files changed, 5587 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mtu3.txt
 create mode 100644 drivers/usb/mtu3/Kconfig
 create mode 100644 drivers/usb/mtu3/Makefile
 create mode 100644 drivers/usb/mtu3/mtu3.h
 create mode 100644 drivers/usb/mtu3/mtu3_core.c
 create mode 100644 drivers/usb/mtu3/mtu3_dr.c
 create mode 100644 drivers/usb/mtu3/mtu3_dr.h
 create mode 100644 drivers/usb/mtu3/mtu3_gadget.c
 create mode 100644 drivers/usb/mtu3/mtu3_gadget_ep0.c
 create mode 100644 drivers/usb/mtu3/mtu3_host.c
 create mode 100644 drivers/usb/mtu3/mtu3_hw_regs.h
 create mode 100644 drivers/usb/mtu3/mtu3_plat.c
 create mode 100644 drivers/usb/mtu3/mtu3_qmu.c
 create mode 100644 drivers/usb/mtu3/mtu3_qmu.h

-- 
1.7.9.5
