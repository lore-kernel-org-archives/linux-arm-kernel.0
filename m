From: alcooperx@gmail.com (Al Cooper)
Date: Fri,  2 Jun 2017 14:01:49 -0400
Subject: [PATCH 0/3] Add Broadcom STB USB phy driver
Message-ID: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new USB Phy driver for Broadcom STB SoCs. This driver
supports Broadcom STB ARM and MIPS SoCs. This driver in
combination with the Broadcom STB ohci, ehci and xhci
drivers will enable USB1.1, USB2.0 and USB3.0 support.
This Phy driver also supports the Broadcom UDC gadget
driver.

Al Cooper (3):
  soc: brcmstb: Add Product ID and Family ID helper functions
  dt-bindings: Add Broadcom STB USB PHY binding document
  phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver

 .../bindings/phy/brcm,brcmstb-usb-phy.txt          |   37 +
 MAINTAINERS                                        |    7 +
 drivers/phy/Makefile                               |    4 +
 drivers/phy/phy-brcm-usb-init.c                    | 1111 ++++++++++++++++++++
 drivers/phy/phy-brcm-usb-init.h                    |  110 ++
 drivers/phy/phy-brcm-usb.c                         |  487 +++++++++
 drivers/soc/bcm/brcmstb/common.c                   |   12 +
 include/linux/soc/brcmstb/brcmstb.h                |   10 +
 8 files changed, 1778 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
 create mode 100644 drivers/phy/phy-brcm-usb-init.c
 create mode 100644 drivers/phy/phy-brcm-usb-init.h
 create mode 100644 drivers/phy/phy-brcm-usb.c

-- 
1.9.0.138.g2de3478
