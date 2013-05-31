From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Fri, 31 May 2013 17:38:40 +0530
Subject: [PATCH V2 2/2] USB: OHCI: add a name for the platform-private field
In-Reply-To: <1370002120-19495-1-git-send-email-y>
References: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
 <1370002120-19495-1-git-send-email-y>
Message-ID: <51a892e0.3077420a.5699.0f8c@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

This patch adds an ohci->priv field for private use by OHCI
platform drivers.

Until now none of the platform drivers has used this private space,
but that's about to change in the next patch of this series.

In V2:
No changes.

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
