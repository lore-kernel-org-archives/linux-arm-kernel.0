From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 14 Feb 2017 18:09:06 +0200
Subject: [PATCH 4/4 linux-next] usb: gadget: udc: atmel: Update Kconfig help
 for fifo_mode = 0
In-Reply-To: <cover.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <6ee2cab9ded640d183bf66865624a06ed6c62db8.1487007870.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Update Kconfig help for fifo_mode = 0 to explain the behavior better.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 4b69f28..be94eb9 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -62,8 +62,9 @@ config USB_ATMEL_USBA
 
 	  The fifo_mode parameter is used to select endpoint allocation mode.
 	  fifo_mode = 0 is used to let the driver autoconfigure the endpoints.
-	  In this case 2 banks are allocated for isochronous endpoints and
-	  only one bank is allocated for the rest of the endpoints.
+	  In this case, for ep1 2 banks are allocated if it works in isochronous
+	  mode and only 1 bank otherwise. For the rest of the endpoints
+	  only 1 bank is allocated.
 
 	  fifo_mode = 1 is a generic maximum fifo size (1024 bytes) configuration
 	  allowing the usage of ep1 - ep6
-- 
2.7.4
