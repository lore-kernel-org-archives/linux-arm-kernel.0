From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:41 -0700
Subject: [PATCH 08/12] ehci-msm: Remove dead dependency
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This dependency no longer exists now that mach-msm has been
removed. Delete it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This can be acked and go through arm-soc or applied directly to usb tree.

 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5ad60e46dc2b..197a6a3e613b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -198,7 +198,7 @@ config USB_EHCI_HCD_AT91
 
 config USB_EHCI_MSM
 	tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
-	depends on ARCH_MSM || ARCH_QCOM
+	depends on ARCH_QCOM
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Enables support for the USB Host controller present on the
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
