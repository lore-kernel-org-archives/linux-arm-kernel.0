From: adanhawthorn@gmail.com (Nathan Howard)
Date: Fri, 17 Feb 2017 15:16:18 -0500
Subject: [PATCH 2/5] staging: bcm2835-audio: bcm2835.h: fix printk coding
 style issue
In-Reply-To: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487362603-15967-2-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl warning of the form "WARNING: Prefer
subsystem eg: netdev]_info([subsystem]dev, ...
then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ..."

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 66af445..81fdb10 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -37,10 +37,10 @@
 #ifdef AUDIO_VERBOSE_DEBUG_ENABLE
 
 #define audio_debug(fmt, arg...) \
-	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_info(fmt, arg...) \
-	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #else
 
@@ -59,13 +59,13 @@
 #endif /* AUDIO_DEBUG_ENABLE */
 
 #define audio_error(fmt, arg...) \
-	printk(KERN_ERR"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_err("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_warning(fmt, arg...) \
-	printk(KERN_WARNING"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_warn("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define audio_alert(fmt, arg...) \
-	printk(KERN_ALERT"%s:%d " fmt, __func__, __LINE__, ##arg)
+	pr_alert("%s:%d " fmt, __func__, __LINE__, ##arg)
 
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
-- 
2.7.4
