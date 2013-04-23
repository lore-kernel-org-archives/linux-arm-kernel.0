From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:52 +0200
Subject: [PATCH 20/21] MFD: ab8500: export ab8500_gpadc_sw_hw_convert properly
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-21-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently the ab8500_gpadc_sw_hw_convert function got renamed
from ab8500_gpadc_convert to ab8500_gpadc_sw_hw_convert in
commit 734823462 "mfd: ab8500-gpadc: Add gpadc hw conversion",
but the export for this function did not get changed at the
same time, causing this allyesconfig error:

ERROR: "ab8500_gpadc_sw_hw_convert" [drivers/hwmon/ab8500.ko] undefined!

This patch fixes the export.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: M'boumba Cedric Madianga <cedric.madianga@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mattias WALLIN <mattias.wallin@stericsson.com>
Cc: Michel JAOUEN <michel.jaouen@stericsson.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/ab8500-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 5f341a5..184df96 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -269,7 +269,7 @@ int ab8500_gpadc_convert(struct ab8500_gpadc *gpadc, u8 channel)
 
 	return voltage;
 }
-EXPORT_SYMBOL(ab8500_gpadc_convert);
+EXPORT_SYMBOL(ab8500_gpadc_sw_hw_convert);
 
 /**
  * ab8500_gpadc_read_raw() - gpadc read
-- 
1.8.1.2
