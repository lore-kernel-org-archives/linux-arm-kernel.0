From: rogerq@ti.com (Roger Quadros)
Date: Mon, 4 Feb 2013 17:58:47 +0200
Subject: [PATCH 00/13] Device tree support for OMAP HS USB Host
Message-ID: <1359993540-20780-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds device tree support for OMAP's High Speed USB Host
subsystem. Board adaptation for Panda and Beagleboard is also provided.

Tested on Beagleboard.

Will only work with Panda if we provide a reference to the PHY clock
generator in the device tree in PATCH 11. I do not know how to do that
as there is no way to provide a phandle to any of the OMAP generated clocks
in the device tree. Suggestions welcome :).

Based on linux-next:next-20130204

Depends on "USB: omap-ehci: Move PHY management to PHY driver"
	git at github.com:rogerq/linux.git next-usbhost16

The following changes since commit 8c00470e1308d08df1f2b2c7e9a561d868ec0526:

  USB: ehci-omap: Select NOP USB transceiver driver (2013-02-04 16:36:06 +0200)

are available in the git repository at:
  git at github.com:rogerq/linux.git next-usbhost16-dt

Roger Quadros (13):
  usb: phy: nop: Add device tree support and binding information
  USB: phy: nop: Defer probe if device needs VCC/RESET
  mfd: omap-usb-tll: move configuration code to omap_tll_init()
  mfd: omap-usb-tll: Add device tree support
  USB: ehci-omap: Get platform resources by index rather than by name
  USB: ohci-omap3: Get platform resources by index rather than by name
  USB: ohci-omap3: Add device tree support and binding information
  USB: ehci-omap: Add device tree support and binding information
  mfd: omap-usb-host: Add device tree support and binding information
  ARM: dts: OMAP4: Add HS USB Host IP nodes
  ARM: dts: omap4-panda: Add USB Host support
  ARM: dts: OMAP3: Add HS USB Host IP nodes
  ARM: dts: omap3-beagle: Add USB Host support

 .../devicetree/bindings/mfd/omap-usb-host.txt      |   68 +++++++
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 ++
 .../devicetree/bindings/usb/omap-ehci.txt          |   34 +++
 .../devicetree/bindings/usb/omap3-ohci.txt         |   17 ++
 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 +++
 arch/arm/boot/dts/omap3-beagle.dts                 |   71 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |   31 +++
 arch/arm/boot/dts/omap4-panda.dts                  |   55 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   30 +++
 drivers/mfd/omap-usb-host.c                        |   90 ++++++++-
 drivers/mfd/omap-usb-tll.c                         |  213 ++++++++++----------
 drivers/mfd/omap-usb.h                             |    5 +-
 drivers/usb/host/ehci-omap.c                       |   41 ++++-
 drivers/usb/host/ohci-omap3.c                      |   24 ++-
 drivers/usb/otg/nop-usb-xceiv.c                    |   39 ++++
 include/linux/usb/nop-usb-xceiv.h                  |    4 +
 16 files changed, 651 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-host.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

-- 
1.7.4.1
