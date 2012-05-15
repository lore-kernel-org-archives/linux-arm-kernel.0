From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:17 +0800
Subject: [PATCH v1 1/7] usb: chipidea: permit user select USB_EHCI_ROOT_HUB_TT
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ci13xxx hcd require USB_EHCI_ROOT_HUB_TT.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 684a7bb..89d0371 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -65,7 +65,7 @@ config USB_EHCI_HCD
 
 config USB_EHCI_ROOT_HUB_TT
 	bool "Root Hub Transaction Translators"
-	depends on USB_EHCI_HCD
+	depends on USB_EHCI_HCD || USB_CHIPIDEA
 	---help---
 	  Some EHCI chips have vendor-specific extensions to integrate
 	  transaction translators, so that no OHCI or UHCI companion
-- 
1.7.5.4
