From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 11 May 2018 12:19:53 +0200
Subject: [PATCH v2 0/3] Fix an Atmel USBA UDC issue introducted in 4.17-rc1
Message-ID: <20180511101956.11782-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of GPIO descriptors takes care of inversion flags declared in
the device tree. The conversion of the Atmel USBA UDC driver introduced
in 4.17-rc1 missed it, and as a result the inversion will not work.

In addition, cleanup the code to remove an include left behind after
the suppression of the support of platform_data to declare USBA
controllers.

These changes have not been tested on any hardware, as I do not have
a board that needs to use inverted GPIOs.

--
Changes in v2:
- Use the correct format for the "Fixes:" tag
- Collect "Acked-by:" tags


Romain Izard (3):
  usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
  usb: gadget: udc: atmel: Remove obsolete include
  usb: gadget: udc: atmel: Fix indenting

 drivers/usb/gadget/udc/atmel_usba_udc.c | 22 ++++++++++------------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 -
 include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
 3 files changed, 10 insertions(+), 37 deletions(-)
 delete mode 100644 include/linux/usb/atmel_usba_udc.h

-- 
2.14.1
