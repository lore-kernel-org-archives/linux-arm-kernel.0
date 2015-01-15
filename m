From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 18:02:30 +0100
Subject: [GIT PULL] at91: drivers for 3.20 #1
Message-ID: <1421341350-13936-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a pull-request about AT91 drivers for 3.20. We took the USB gadget part
with us as it depends on the Matrix syscon part. There is no dependency anyway.

Thanks, best regards,

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-drivers

for you to fetch changes up to a5514d142e7f5cff8e02a6fb4cfcb3e301c0eb59:

  usb: gadget: at91_udc: Allocate udc instance (2015-01-15 14:53:23 +0100)

----------------------------------------------------------------
First batch of drivers changes for 3.20:
- Internal AHB bus matrix (Matrix) and Static Memory Controller (SMC) are now
  mfd/syscon drivers.
- USB gadget full speed (at91_udc): fixes, simplification and multi-platform awareness
  DT enhancement.

----------------------------------------------------------------
Boris Brezillon (12):
      mfd: syscon: Add atmel-matrix registers definition
      mfd: syscon: Add Atmel Matrix bus DT binding documentation
      mfd: syscon: Add atmel-smc registers definition
      mfd: syscon: Add Atmel SMC binding doc
      usb: gadget: at91_udc: Fix clock names
      usb: gadget: at91_udc: Drop uclk clock
      usb: gadget: at91_udc: Document DT clocks and clock-names property
      usb: gadget: at91_udc: Remove non-DT handling code
      usb: gadget: at91_udc: Simplify probe and remove functions
      usb: gadget: at91_udc: Rework for multi-platform kernel support
      usb: gadget: at91_udc: Update DT binding documentation
      usb: gadget: at91_udc: Allocate udc instance

 .../devicetree/bindings/mfd/atmel-matrix.txt       |  24 +
 .../devicetree/bindings/mfd/atmel-smc.txt          |  19 +
 .../devicetree/bindings/usb/atmel-usb.txt          |  10 +-
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/gadget/udc/at91_udc.c                  | 525 +++++++++++----------
 drivers/usb/gadget/udc/at91_udc.h                  |   9 +-
 include/linux/mfd/syscon/atmel-matrix.h            | 117 +++++
 include/linux/mfd/syscon/atmel-smc.h               | 173 +++++++
 8 files changed, 623 insertions(+), 255 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-matrix.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-smc.txt
 create mode 100644 include/linux/mfd/syscon/atmel-matrix.h
 create mode 100644 include/linux/mfd/syscon/atmel-smc.h

-- 
Nicolas Ferre
