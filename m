From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 30 May 2013 15:20:54 +0530
Subject: [RFC PATCH 2/2] USB: OHCI: add a name for the platform-private field
In-Reply-To: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
References: <y> <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369907454-11003-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an ohci->priv field for private use by OHCI
platform drivers.

Until now none of the platform drivers has used this private space,
but that's about to change in the next patch of this series.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 3b58482..e2e5faa 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -421,6 +421,9 @@ struct ohci_hcd {
 	struct dentry		*debug_periodic;
 	struct dentry		*debug_registers;
 #endif
+	/* platform-specific data -- must come last */
+	unsigned long           priv[0] __aligned(sizeof(s64));
+
 };
 
 #ifdef CONFIG_PCI
-- 
1.7.9.5
