From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 15 Jun 2016 11:07:15 +0800
Subject: Add MediaTek USB3 DRD Driver
Message-ID: <1465960040-768-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 48552e96e4e33f8830cb6a59154fe148425532fd Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Wed, 15 Jun 2016 10:58:10 +0800
Subject: [PATCH v4,0/5] Add MediaTek USB3 DRD Driver

These patches introduce the MediaTek USB3 dual-role controller
driver.

The driver can be configured as Dual-Role Device (DRD),
Peripheral Only and Host Only (xHCI) modes. It works well
with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
tested on MT8173 platform which only contains USB2.0 device IP,
and on MT6290 platform which contains USB3.0 device IP.

Change in v4:
1. fix build errors on non-mediatek platforms
2. provide manual dual-role switch via debugfs instead of sysfs

Change in v3:
1. fix some typo error
2. rename mtu3.txt to mt8173-mtu3.txt

Change in v2:
1. modify binding docs according to suggestions
2. modify some comments and remove some dummy blank lines
3. fix memory leakage

Chunfeng Yun (5):
  dt-bindings: mt8173-xhci: support host side of dual-role mode
  dt-bindings: mt8173-mtu3: add devicetree bindings
  usb: xhci-mtk: make IPPC register optional
  usb: Add MediaTek USB3 DRD Driver
  arm64: dts: mediatek: add USB3 DRD driver

 .../devicetree/bindings/usb/mt8173-mtu3.txt        |   86 ++
 .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   46 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   28 +-
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/Makefile                               |    1 +
 drivers/usb/host/xhci-mtk.c                        |   32 +-
 drivers/usb/mtu3/Kconfig                           |   48 ++
 drivers/usb/mtu3/Makefile                          |   21 +
 drivers/usb/mtu3/mtu3.h                            |  424 ++++++++++
 drivers/usb/mtu3/mtu3_core.c                       |  879 ++++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c                         |  375 +++++++++
 drivers/usb/mtu3/mtu3_dr.h                         |  108 +++
 drivers/usb/mtu3/mtu3_gadget.c                     |  731 ++++++++++++++++
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  879 ++++++++++++++++++++
 drivers/usb/mtu3/mtu3_host.c                       |  294 +++++++
 drivers/usb/mtu3/mtu3_hw_regs.h                    |  474 +++++++++++
 drivers/usb/mtu3/mtu3_plat.c                       |  490 +++++++++++
 drivers/usb/mtu3/mtu3_qmu.c                        |  599 +++++++++++++
 drivers/usb/mtu3/mtu3_qmu.h                        |   43 +
 20 files changed, 5594 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
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
