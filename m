From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 28 Jun 2012 11:37:26 +0800
Subject: [PATCH v8 09/14] usb: chipidea: select USB_EHCI_ROOT_HUB_TT in
 USB_CHIPIDEA_HOST of Kconfig
In-Reply-To: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
References: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340854652-24717-10-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ci13xxx host needs Root Hub Transaction Translators.

Reported-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Marek Vasut <marex@denx.de>
---
 drivers/usb/chipidea/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index fd36dc8..8337fb5 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -20,6 +20,7 @@ config USB_CHIPIDEA_UDC
 
 config USB_CHIPIDEA_HOST
 	bool "ChipIdea host controller"
+	select USB_EHCI_ROOT_HUB_TT
 	help
 	  Say Y here to enable host controller functionality of the
 	  ChipIdea driver.
-- 
1.7.9.5
