From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 17 Oct 2013 11:25:22 -0700
Subject: [PATCH 0/2 v3] usb: ohci: remove ep93xx bus glue driver
Message-ID: <201310171125.22523.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refresh the ep93xx_defconfig then remove the ep93xx OHCI bus glue
driver in favor of the Generic OHCI driver for a platform device.

v3: split patch to refresh the ep93xx_defconfig before removing
    ohci-ep93xx.c in favor of the Generic OHCI driver for a
    platform device.

v2: Use the (*power_off) callback for (*power_suspend), as
    suggested by Alan Stern.
    Remove the Kconfig change to USB_OHCI_HCD_PLATFORM and
    refresh the ep93xx_defconfig to enable this option, as
    suggested by Alan Stern.

H Hartley Sweeten (2):
  ARM: ep93xx_defconfig: cleanup ep93xx_defconfig
  usb: ohci: remove ep93xx bus glue platform driver

 arch/arm/configs/ep93xx_defconfig |  17 +---
 arch/arm/mach-ep93xx/clock.c      |   2 +-
 arch/arm/mach-ep93xx/core.c       |  40 ++++++++-
 drivers/usb/host/ohci-ep93xx.c    | 184 --------------------------------------
 drivers/usb/host/ohci-hcd.c       |  18 ----
 5 files changed, 40 insertions(+), 221 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-ep93xx.c

-- 
1.8.3.2
