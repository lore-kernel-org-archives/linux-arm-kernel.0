From: khilman@ti.com (Kevin Hilman)
Date: Fri, 20 May 2011 15:41:06 +0200
Subject: [PATCH 0/2] GPIO: move OMAP driver to drivers/gpio
Message-ID: <1305898868-9188-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move OMAP GPIO driver to drivers/gpio, but leave OMAP-specific
register definitions in <plat/gpio.h>, where they will be used by
SoC-specific code and passed in via platform_data (in forthcoming
series.)

After the move, I have another series that cleans up this
driver, removing all the SoC-specific checks, #ifdefs, etc. and passes
SoC-specific register offsets in from platform_data.

Kevin Hilman (2):
  GPIO: OMAP: move register offset defines into <plat/gpio.h>
  GPIO: OMAP: move to drivers/gpio

 arch/arm/plat-omap/Makefile            |    2 +-
 arch/arm/plat-omap/gpio.c              | 2128 --------------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  103 ++
 drivers/gpio/Makefile                  |    1 +
 drivers/gpio/gpio_omap.c               | 2023 ++++++++++++++++++++++++++++++
 5 files changed, 2128 insertions(+), 2129 deletions(-)
 delete mode 100644 arch/arm/plat-omap/gpio.c
 create mode 100644 drivers/gpio/gpio_omap.c

-- 
1.7.3.4
