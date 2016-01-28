From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:15:12 +0100
Subject: [PATCH 0/7] USB changes for rare warnings
Message-ID: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

This set of patches addresses warnings I got in randconfig builds,
in the USB drivers. The first three patches are for the pxa25x
UDC driver and are a larger scale cleanup triggered by finding
the initial bug. The other four are relatively simple but still
need to be reviewed properly, as I have done only compile-time
testing. After these patches, I get no other warnings for USB
drivers at the moment.

Arnd Bergmann (7):
  usb: gadget: pxa25x_udc: move register definitions from arch
  usb: gadget: pxa25x_udc cleanup
  usb: gadget: pxa25x_udc: use readl/writel for mmio
  usb: fsl: drop USB_FSL_MPH_DR_OF Kconfig symbol
  usb: isp1301-omap: mark power_up as __maybe_unused
  usb: musb: use %pad format string from dma_addr_t
  usb: musb/ux500: remove duplicate check for dma_is_compatible

 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 198 ---------
 arch/arm/mach-pxa/include/mach/pxa25x-udc.h     | 163 --------
 drivers/usb/Makefile                            |   2 +-
 drivers/usb/gadget/udc/Kconfig                  |   1 -
 drivers/usb/gadget/udc/pxa25x_udc.c             | 530 +++++++++++++++++-------
 drivers/usb/gadget/udc/pxa25x_udc.h             |  11 +-
 drivers/usb/host/Kconfig                        |   4 -
 drivers/usb/host/Makefile                       |   3 +-
 drivers/usb/musb/musbhsdma.c                    |   8 +-
 drivers/usb/musb/tusb6010_omap.c                |   4 +-
 drivers/usb/musb/ux500_dma.c                    |   3 -
 drivers/usb/phy/phy-isp1301-omap.c              |   2 +-
 12 files changed, 400 insertions(+), 529 deletions(-)

-- 
2.7.0
