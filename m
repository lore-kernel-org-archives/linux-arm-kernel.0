From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:03 +0530
Subject: [PATCH 4/7] ARM: SAMSUNG: Use generic s3c_set_platdata for USB OHCI
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-5-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata to set USB OHCI platform data

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-samsung/dev-usb.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-usb.c b/arch/arm/plat-samsung/dev-usb.c
index 0e0a3bf..33fbaa9 100644
--- a/arch/arm/plat-samsung/dev-usb.c
+++ b/arch/arm/plat-samsung/dev-usb.c
@@ -60,11 +60,6 @@ EXPORT_SYMBOL(s3c_device_ohci);
  */
 void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
 {
-	struct s3c2410_hcd_info *npd;
-
-	npd = kmemdup(info, sizeof(struct s3c2410_hcd_info), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_ohci.dev.platform_data = npd;
+	s3c_set_platdata(info, sizeof(struct s3c2410_hcd_info),
+			 &s3c_device_ohci);
 }
-- 
1.7.2.3
