From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 26 Jul 2017 18:56:21 -0400
Subject: [PATCH v2 0/6] USB3 support for Broadcom NS2 SoC
Message-ID: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
* Addressed Rob Herring's comments on the binding documentation, which
  resulted in a restructing of the device tree and how the driver
  references those nodes.  This, in turn, resulted in a few new
  documentation files being created.

This patch set contains the USB3 support for Broadcom NS2 SoC.  The USB3
PHY is connected through the MDIO interface.

Jon Mason (3):
  dt-bindings: usb: Add documentation for NS2 CDRU USB3
  dt-bindings: usb: Add documentation for NS2 ICFG USB3
  dt-bindings: usb: Add documentation for NS2 IDM USB3

Yendapally Reddy Dhananjaya Reddy (3):
  dt-bindings: phy: Add documentation for NS2 USB3 PHY
  phy: Add USB3 PHY support for Broadcom NS2 SoC
  arm64: dts: ns2: Add USB3 Support

 .../devicetree/bindings/phy/brcm,ns2-usb3-phy.txt  |  48 ++
 .../bindings/usb/brcm,cdru-usb3-ctrl.txt           |  14 +
 .../devicetree/bindings/usb/brcm,icfg-usb.txt      |  13 +
 .../devicetree/bindings/usb/brcm,usb3-idm.txt      |  14 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  16 +
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts           |   8 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  59 +++
 drivers/phy/broadcom/Kconfig                       |   9 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-ns2-usb3.c            | 580 +++++++++++++++++++++
 10 files changed, 762 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,cdru-usb3-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb3-idm.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-ns2-usb3.c

-- 
2.7.4
