From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 2 Aug 2013 16:37:42 +0800
Subject: [PATCH 3/3] usb: host: delete chipidea dependency
In-Reply-To: <1375432662-32018-1-git-send-email-peter.chen@freescale.com>
References: <1375432662-32018-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1375432662-32018-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, chipidea host has already depended on USB_EHCI_HCD

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/host/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index cf521d6..b548554 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -63,7 +63,7 @@ config USB_EHCI_HCD
 
 config USB_EHCI_ROOT_HUB_TT
 	bool "Root Hub Transaction Translators"
-	depends on USB_EHCI_HCD || USB_CHIPIDEA_HOST
+	depends on USB_EHCI_HCD
 	---help---
 	  Some EHCI chips have vendor-specific extensions to integrate
 	  transaction translators, so that no OHCI or UHCI companion
@@ -75,7 +75,7 @@ config USB_EHCI_ROOT_HUB_TT
 
 config USB_EHCI_TT_NEWSCHED
 	bool "Improved Transaction Translator scheduling"
-	depends on USB_EHCI_HCD || USB_CHIPIDEA_HOST
+	depends on USB_EHCI_HCD
 	default y
 	---help---
 	  This changes the periodic scheduling code to fill more of the low
-- 
1.7.0.4
