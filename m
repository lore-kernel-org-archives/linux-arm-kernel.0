From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  7 May 2018 23:18:12 +0800
Subject: [PATCH 0/5] Allwinner H6 USB3 support
Message-ID: <20180507151817.55663-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains USB3 support for Allwinner H6 SoC (DWC3 with a custom PHY).

The first patch adds the PHY driver, and the second/third patch adds
compatible to adapt DWC3 platform glue to Allwinner platform. The last
two patches are DT changes.

Icenowy Zheng (5):
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  dt-bindings: usb: add binding for the DWC3 controller on Allwinner SoC
  usb: dwc3: of-simple: Add compatible for Allwinner H6 platform
  arm64: allwinner: h6: add USB3 device nodes
  arm64: allwinner: h6: enable USB3 port on Pine H64

 .../bindings/phy/sun50i-usb3-phy.txt          |  24 +++
 .../bindings/usb/allwinner,dwc3.txt           |  39 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  23 +++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  38 ++++
 drivers/phy/allwinner/Kconfig                 |  13 ++
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 +
 8 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,dwc3.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.17.0
