From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Fri, 20 Jan 2017 17:40:58 +0200
Subject: [PATCH linux-next 0/1] usb: gadget: udc: atmel: Update endpoint
 allocation scheme
Message-ID: <1484926859-4732-1-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Hi,

This patch updates the usb endpoint allocation scheme for atmel usba
driver to make sure all endpoints are allocated in order. This requirement
comes from the datasheet of the controller.

The allocation scheme is decided by fifo_mode parameter. For fifo_mode = 0
the driver tries to autoconfigure the endpoints fifo size. All other modes
contain fixed configurations optimized for different purposes. The idea is
somehow similar with the approach used on musb driver.

Please let me know if you have any comments or suggestions.

Kind regards,
Cristian


Cristian Birsan (1):
  usb: gadget: udc: atmel: Update endpoint allocation scheme

 drivers/usb/gadget/udc/Kconfig          |  14 ++
 drivers/usb/gadget/udc/atmel_usba_udc.c | 236 +++++++++++++++++++++++++++-----
 drivers/usb/gadget/udc/atmel_usba_udc.h |  10 +-
 3 files changed, 227 insertions(+), 33 deletions(-)

-- 
2.7.4
