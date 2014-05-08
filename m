From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 15:52:13 +0200
Subject: [PATCH 0/8] usb: various fixes for ARM randconfig failures
Message-ID: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These is the usb part of my longer ARM randconfig build bug
series. None of these are actually needed for 3.15 as far as
I can tell, but it would be good to have them included in the
next merge window.

The xhci patch is only for a build warning, not a failure, but
we see this one all the time because it happens in one of the
defconfigs.

Arnd Bergmann (8):
  usb/gadget: s3c2410_udc: don't use pr_debug return value
  usb: musb: tusb-dma can't be built-in if tusb is not
  usb: musb: omap2plus bus glue needs USB host support
  usb: phy: fix isp1301-omap dependency on tps65010
  usb: phy: msm: reset controller is mandatory now
  usb: xhci: avoid warning for !PM_SLEEP
  usb: ohci: sort out dependencies for lpc32xx and omap
  usb: ohci-da8xx can only be built-in

 drivers/usb/gadget/Kconfig         |  4 ++--
 drivers/usb/gadget/s3c2410_udc.c   |  3 ++-
 drivers/usb/host/Kconfig           | 16 +++++++++++++---
 drivers/usb/host/ohci-hcd.c        |  2 +-
 drivers/usb/host/xhci-plat.c       |  2 +-
 drivers/usb/musb/Kconfig           |  4 ++--
 drivers/usb/phy/Kconfig            |  1 +
 drivers/usb/phy/phy-isp1301-omap.c |  2 +-
 8 files changed, 23 insertions(+), 11 deletions(-)

-- 
1.8.3.2
