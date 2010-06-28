From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 28 Jun 2010 16:39:12 +1200
Subject: [PATCH 0/3] at91: Add support for Bluewater Systems Snapper 9260/9G20
	modules
Message-ID: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Repost of the Snapper 9260/9G20 module support patch series. These
patches add support for the Bluewater Systems Snapper 9260/9G20
modules. As a preliminary for the module support the following patches
are also included in this series:

 - Define NR_BUILTIN_GPIO for at91. The Snapper 9260/9G20 modules have
an io expander which requires this to be defined.
 - Add vbus polarity and polling mode to the at91 udc driver. The
Snapper 9260/9G20 modules have the udc vbus pin connected in inverse
polarity to a sleeping io expander gpio.

Ryan Mallon (3):
  AT91: Define NR_BUILTIN_GPIO
  at91_udc: Add vbus polarity and polling mode
  at91: Add support for Bluewater Systems Snapper 9260/9G20 modules

 arch/arm/mach-at91/Kconfig              |   11 ++
 arch/arm/mach-at91/Makefile             |    3 +
 arch/arm/mach-at91/board-snapper9260.c  |  189 +++++++++++++++++++++++++++++++
 arch/arm/mach-at91/include/mach/board.h |    2 +
 arch/arm/mach-at91/include/mach/gpio.h  |    1 +
 drivers/usb/gadget/at91_udc.c           |   66 +++++++++--
 drivers/usb/gadget/at91_udc.h           |    2 +
 7 files changed, 261 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-snapper9260.c
