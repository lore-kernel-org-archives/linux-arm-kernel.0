From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 1 Apr 2015 13:50:54 -0700
Subject: [PATCH v2 0/3] USB PHY driver for Broadcom's Cygnus chipset
Message-ID: <1427921457-18235-1-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the USB phy driver and documentation 
for Broadom's Cygnus chipset. The phy is configurable from device tree
and is capable of both device and host functions. It also provides
a clock and reset to the host controller

History:
v1:
    - Included Dmitry Torokhov's patch that addresed Kishon Vijay Abraham's 
    comments on multiple phy model
    - Inlucded Dmitry Torokhov's patch to use phy regulator
    - Addressed Arnd Bergmann's comments on usage of this phy driver by
    ehci-platform and ohci-platform driver in a separate patchset. 
v2:
    - Addressed Kishon's comments on documentation and function names
    - Dmitry Addressed Kishon's comments on per port phy regulators

Arun Ramamurthy (3):
  phy: phy-core: allow specifying supply at port level
  Phy: DT binding documentation for Broadcom Cygnus USB PHY driver
  phy: cygnus-usbphy: Add Broadcom Cygnus USB phy driver

 .../bindings/phy/brcm,cygnus-usb-phy.txt           |  69 +++
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-cygnus-usb.c                   | 484 +++++++++++++++++++++
 drivers/phy/phy-core.c                             |  23 +-
 5 files changed, 576 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
 create mode 100644 drivers/phy/phy-bcm-cygnus-usb.c

-- 
2.3.4
