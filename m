From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  4 Oct 2018 20:28:45 +0800
Subject: [PATCH v4 00/10] Allwinner H6 USB support
Message-ID: <20181004122855.22981-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces support for the USB ports (both USB2 and USB3)
on the Allwinner H6 SoC.

The first 6 PATCHes are the USB2 part, and the latter 4 PATCHes are the
USB3 part.

PATCH 1, 2, 3, 7, 8 should go through the PHY tree, and the remaining
patches should go through the armsoc tree via sunxi tree.

Icenowy Zheng (10):
  dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
  phy: sun4i-usb: add support for missing USB PHY index
  phy: sun4i-usb: add support for H6 USB2 PHY
  arm64: allwinner: dts: h6: add USB2-related device nodes
  arm64: allwinner: dts: h6: add USB Vbus regulator
  arm64: allwinner: dts: h6: enable USB2 on Pine H64
  dt-bindings: phy: add binding for Allwinner USB3 PHY
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  arm64: allwinner: dts: h6: add USB3 device nodes
  arm64: allwinner: dts: h6: enable USB3 port on Pine H64

 .../devicetree/bindings/phy/sun4i-usb-phy.txt |   8 +-
 .../bindings/phy/sun50i-usb3-phy.txt          |  23 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  46 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 113 +++++++++
 drivers/phy/allwinner/Kconfig                 |  12 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |  26 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 239 ++++++++++++++++++
 8 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.18.0
