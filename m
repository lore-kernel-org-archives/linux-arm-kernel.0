From: stigge@antcom.de (Roland Stigge)
Date: Fri, 12 Oct 2012 21:11:19 +0200
Subject: [PATCH RFC 0/6 v3] gpio: Add block GPIO
Message-ID: <1350069085-13283-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds:

* Block GPIO API to gpiolib
* Sysfs support for GPIO API, to provide userland access
* Devicetree support to instantiate GPIO blocks via DT
* Example implementations in several gpio drivers since they need
  special accessor functions for block wise GPIO access

Signed-off-by: Roland Stigge <stigge@antcom.de>

--

Changes since v2:
* Added sysfs support
* Added devicetree support
* Added support for lpc32xx, generic
* Added functions for GPIO block registration
* Added more error checking
* Bit remapping bugfix

Roland Stigge (6):
 gpio: Add a block GPIO API to gpiolib
 gpio: Add sysfs support to block GPIO API
 gpio: Add device tree support to block GPIO API
 gpio-max730x: Add block GPIO API
 gpio-lpc32xx: Add block GPIO API
 gpio-generic: Add block GPIO API

 Documentation/ABI/testing/sysfs-gpio                  |    6 
 Documentation/devicetree/bindings/gpio/gpio-block.txt |   36 
 Documentation/gpio.txt                                |   45 +
 drivers/gpio/Makefile                                 |    1 
 drivers/gpio/gpio-generic.c                           |   56 +
 drivers/gpio/gpio-lpc32xx.c                           |   78 +
 drivers/gpio/gpio-max730x.c                           |   60 +
 drivers/gpio/gpioblock-of.c                           |   83 +
 drivers/gpio/gpiolib.c                                |  449 +++++++++-
 include/asm-generic/gpio.h                            |   25 
 include/linux/gpio.h                                  |   74 +
 11 files changed, 911 insertions(+), 2 deletions(-)
