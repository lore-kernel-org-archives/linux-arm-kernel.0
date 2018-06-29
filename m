From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 29 Jun 2018 17:38:57 +0900
Subject: [PATCH 0/4]  phy: socionext: add new UniPhier USB PHY driver support
Message-ID: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for PHY interface built into USB controller
implemented in Socionext UniPhier SoCs.

The USB3 PHY driver supports High-Speed PHY and Super-Speed PHY included in
the USB3 glue layer, and the USB2 PHY driver supports High-Speed PHY
integrated into system controller.

Kunihiko Hayashi (4):
  dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
  phy: socionext: add USB3 PHY driver for UniPhier SoC
  dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
  phy: socionext: add USB2 PHY driver for UniPhier SoC

 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |  45 +++
 .../devicetree/bindings/phy/uniphier-usb3-phy.txt  | 118 ++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  25 ++
 drivers/phy/socionext/Makefile                     |   7 +
 drivers/phy/socionext/phy-uniphier-usb2.c          | 218 +++++++++++
 drivers/phy/socionext/phy-uniphier-usb3hs.c        | 422 +++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c        | 369 ++++++++++++++++++
 9 files changed, 1206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-phy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

-- 
2.7.4
