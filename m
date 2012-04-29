From: stigge@antcom.de (Roland Stigge)
Date: Sun, 29 Apr 2012 16:47:01 +0200
Subject: [PATCH v8 0/5] USB: LPC32xx device tree related OHCI and UDC patch
 series
Message-ID: <1335710826-6684-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series collects the pending LPC32xx patches in one series and forward
ports it onto

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next

There are no other changes since last post.

Roland Stigge (5):
  ohci-nxp: Driver cleanup
  ohci-nxp: Device tree support
  USB: Add driver for NXP ISP1301 USB transceiver
  USB: gadget driver for LPC32xx
  USB: ohci-nxp: Use isp1301 driver

 Documentation/devicetree/bindings/usb/isp1301.txt  |   25 +
 .../devicetree/bindings/usb/lpc32xx-udc.txt        |   28 +
 Documentation/devicetree/bindings/usb/ohci-nxp.txt |   24 +
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/Makefile                               |    1 +
 drivers/usb/gadget/Kconfig                         |   11 +
 drivers/usb/gadget/Makefile                        |    1 +
 drivers/usb/gadget/gadget_chips.h                  |    3 +
 drivers/usb/gadget/lpc32xx_udc.c                   | 3538 ++++++++++++++++++++
 drivers/usb/host/Kconfig                           |    1 +
 drivers/usb/host/ohci-nxp.c                        |  165 +-
 drivers/usb/phy/Kconfig                            |   17 +
 drivers/usb/phy/Makefile                           |    7 +
 drivers/usb/phy/isp1301.c                          |   77 +
 include/linux/usb/isp1301.h                        |   80 +
 15 files changed, 3861 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/isp1301.txt
 create mode 100644 Documentation/devicetree/bindings/usb/lpc32xx-udc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-nxp.txt
 create mode 100644 drivers/usb/gadget/lpc32xx_udc.c
 create mode 100644 drivers/usb/phy/Kconfig
 create mode 100644 drivers/usb/phy/Makefile
 create mode 100644 drivers/usb/phy/isp1301.c
 create mode 100644 include/linux/usb/isp1301.h

-- 
1.7.9
