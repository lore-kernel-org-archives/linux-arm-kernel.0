From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 17 Jun 2010 09:20:21 +1200
Subject: [PATCH 0/3] at91: Add support for Snapper 9260/9G20 modules
Message-ID: <1276723224-23252-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Bluewater Systems Snapper 9260/9G20 modules. 

In order to fully support the modules, NR_BUILTIN_GPIO must be defined
for at91 and vbus polarity and polling have been added to the at91 udc
driver.

Ryan Mallon (3):
  AT91: Define NR_BUILTIN_GPIO
  at91_udc: Add vbus polarity and polling mode
  at91: Add support for Bluewater Systems Snapper 9260/9G20 modules

 arch/arm/mach-at91/Kconfig              |   11 ++
 arch/arm/mach-at91/Makefile             |    3 +
 arch/arm/mach-at91/board-snapper9260.c  |  189 +++++++++++++++++++++++++++++++
 arch/arm/mach-at91/include/mach/board.h |    2 +
 arch/arm/mach-at91/include/mach/gpio.h  |    1 +
 drivers/usb/gadget/at91_udc.c           |   45 ++++++--
 drivers/usb/gadget/at91_udc.h           |    1 +
 7 files changed, 242 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-snapper9260.c
