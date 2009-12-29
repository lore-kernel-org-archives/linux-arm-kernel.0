From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:59:18 +0200
Subject: [patch-v2.6.34 0/9] arm omap patches for -next merge window
Message-ID: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

here are the patches I have prepared for you for
the next merge window.

There's one patch on musb which is a dependency for
for not passing the clk name down to the driver.

The same patch will be going through Greg so you don't
need to queue that patch on your tree.

Felipe Balbi (9):
  arm: omap: musb: remove unused data
  arm: omap: musb: we can use clk framework
  arm: omap: musb: remove unused soft_con field
  arm: omap: musb: remove unused dma data
  arm: omap: musb: remove unnecessary return
  arm: omap: gpmc: avoid section definitions on headers
  usb: musb: use only clk framework for clk handling
  arm: omap: musb: do not pass clock name to driver
  arm: omap: musb: get rid of dyn_fifo

 arch/arm/mach-omap2/usb-musb.c         |   71 +-------------------------------
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 drivers/usb/musb/musb_core.c           |   48 +++++++--------------
 drivers/usb/musb/musb_core.h           |    2 -
 drivers/usb/musb/omap2430.c            |   10 +----
 drivers/usb/musb/tusb6010.c            |   16 +++----
 include/linux/usb/musb.h               |    4 +-
 7 files changed, 28 insertions(+), 125 deletions(-)
