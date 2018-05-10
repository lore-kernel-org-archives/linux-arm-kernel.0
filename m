From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 10 May 2018 14:10:27 +0800
Subject: Add MediaTek XS-PHY driver
Message-ID: <1525932629-10603-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 2ca1243f228633ca9dd96d3e4068af9e2936cd51 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Thu, 10 May 2018 13:55:52 +0800
Subject: [PATCH v3 0/2]  Add MediaTek XS-PHY driver

This patch series support the SuperSpeedPlus XS-PHY transceiver for
USB3.1 GEN2 controller on MediaTek chips. The driver supports multiple
USB2.0, USB3.1 GEN2 ports.

v3: changes in binding (suggested by Rob)
    1. use the correct name of SoC as soc-model's example

v2: changes in binding (suggested by Rob)
    1. list all valid SoCs for compatible
    2. move required child nodes after parent optional ones
    3. remove status property in example
    4. move banks layout example before dts one
    5. remove phy binding example
    6. add #address-cells, #size-cells, ranges properties for parent node


Chunfeng Yun (2):
  dt-bindings: add MediaTek XS-PHY binding
  phy: mediatek: add XS-PHY driver

 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      | 110 ++++
 drivers/phy/mediatek/Kconfig                       |   9 +
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c               | 600 +++++++++++++++++++++
 4 files changed, 720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c

--
1.9.1
