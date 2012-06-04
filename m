From: stigge@antcom.de (Roland Stigge)
Date: Mon,  4 Jun 2012 21:20:08 +0200
Subject: [PATCH] ohci-hub: Mark ohci_finish_controller_resume() as
 __maybe_unused
Message-ID: <1338837608-23976-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ohci_finish_controller_resume() is intended to be used in platform specific
drivers ohci-*.c, included from ohci-hcd.c. Some of them don't actually use
ohci_finish_controller_resume(), so mark it as __maybe_unused.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/usb/host/ohci-hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/usb/host/ohci-hub.c
+++ linux-2.6/drivers/usb/host/ohci-hub.c
@@ -317,7 +317,7 @@ static int ohci_bus_resume (struct usb_h
 }
 
 /* Carry out the final steps of resuming the controller device */
-static void ohci_finish_controller_resume(struct usb_hcd *hcd)
+static void __maybe_unused ohci_finish_controller_resume(struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
 	int			port;
