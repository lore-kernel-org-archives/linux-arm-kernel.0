From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed,  9 Jan 2013 12:15:25 +0100
Subject: [PATCH 0/3] Add and use new macro module_platform_driver_probe()
Message-ID: <1357730128-23018-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For simple modules that contain a single platform_driver without any
additional setup code then ends up being a block of duplicated
boilerplate.  This patch adds a new macro,
module_platform_driver_probe(), which replaces the
module_init()/module_exit() registrations with template functions.
    
This macro use the same idea of module_platform_driver().
    
This macro is useful to stop the misuse of module_platform_driver() for
removing the platform_driver_probe() boilerplate.

Convert drivers/usb/* and drivers/watchdog/* to use
module_platform_driver_probe().

Best regards

Fabio Porcedda (3):
  driver core: add helper macro for platform_driver_probe() boilerplate
  watchdog: convert drivers/watchdog/* to use
    module_platform_driver_probe
  usb: converto drivers/usb/* to use module_platform_driver_probe()

 drivers/usb/gadget/at91_udc.c       | 12 +-----------
 drivers/usb/gadget/atmel_usba_udc.c | 12 +-----------
 drivers/usb/gadget/fusb300_udc.c    | 13 +------------
 drivers/usb/gadget/imx_udc.c        | 12 +-----------
 drivers/usb/gadget/lpc32xx_udc.c    | 12 +-----------
 drivers/usb/gadget/m66592-udc.c     | 12 +-----------
 drivers/usb/gadget/pxa25x_udc.c     | 15 +++------------
 drivers/usb/gadget/r8a66597-udc.c   | 15 ++-------------
 drivers/usb/otg/gpio_vbus.c         | 12 +-----------
 drivers/usb/otg/msm_otg.c           | 13 +------------
 drivers/watchdog/at32ap700x_wdt.c   | 12 +-----------
 drivers/watchdog/at91sam9_wdt.c     | 13 +------------
 drivers/watchdog/coh901327_wdt.c    | 12 +-----------
 drivers/watchdog/imx2_wdt.c         | 12 +-----------
 drivers/watchdog/txx9wdt.c          | 13 +------------
 include/linux/platform_device.h     | 18 ++++++++++++++++++
 16 files changed, 36 insertions(+), 172 deletions(-)

-- 
1.8.0.3
