From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 19 Apr 2018 16:01:44 +0800
Subject: [PATCH resend] usb: chipidea: Don't select EXTCON
Message-ID: <20180419160144.0412a510@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all chipidea users need EXTCON, so it's better to avoid
unconditionally select EXTCON, this could save us 2KB kernel Image size.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/usb/chipidea/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 785f0ed037f7..97509172d536 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -1,7 +1,6 @@
 config USB_CHIPIDEA
 	tristate "ChipIdea Highspeed Dual Role Controller"
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
-	select EXTCON
 	select RESET_CONTROLLER
 	help
 	  Say Y here if your system has a dual role high speed USB
-- 
2.17.0
