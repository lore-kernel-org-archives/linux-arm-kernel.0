From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Fri, 7 Apr 2017 19:07:20 +0300
Subject: [PATCH v4 0/2] usb: gadget: udc: atmel: Endpoint allocation scheme
 fixes
Message-ID: <cover.1491577793.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch series provides fixes, based on the feedback received on the mailing list, for
the following:
	- fifo table parameters validation against device tree values
	- coding style
	- message display for EP configuration error
	- Kconfig comments for fifo_mode=0

Changes since v1:
	- Removed static for usba_config_fifo_table() function from "Check fifo
	configuration values against device tree" patch

Changes since v2:
	- Use shorter warning message if the fifo table size is greather than device 
	tree value
	- replace dev_warn() with dev_err() for hardware fifo allocation error

Changes since v3:
	- rebase the code on testing/next branch as requested
	- remove from patch series the patches that are already in testing/next branch

Cristian Birsan (2):
  usb: gadget: udc: atmel: Use dev_err() to display EP configuration
    error
  usb: gadget: udc: atmel: Update Kconfig help for fifo_mode = 0

 drivers/usb/gadget/udc/Kconfig          | 5 +++--
 drivers/usb/gadget/udc/atmel_usba_udc.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.4
