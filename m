From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 12 Aug 2011 17:55:18 +0300
Subject: [PATCH] s3c-adc-battery: fix compilation error due to missing header
Message-ID: <1313160918-20697-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add linux/module.h to fix this compilation error:

drivers/power/s3c_adc_battery.c:435:15: error: expected declaration specifiers or ?...? before string constant
drivers/power/s3c_adc_battery.c:435:1: warning: data definition has no type or storage class
drivers/power/s3c_adc_battery.c:435:1: warning: type defaults to ?int? in declaration of ?MODULE_AUTHOR?
drivers/power/s3c_adc_battery.c:435:15: warning: function declaration isn?t a prototype
drivers/power/s3c_adc_battery.c:436:20: error: expected declaration specifiers or ?...? before string constant
drivers/power/s3c_adc_battery.c:436:1: warning: data definition has no type or storage class
drivers/power/s3c_adc_battery.c:436:1: warning: type defaults to ?int? in declaration of ?MODULE_DESCRIPTION?
drivers/power/s3c_adc_battery.c:436:20: warning: function declaration isn?t a prototype
drivers/power/s3c_adc_battery.c:437:16: error: expected declaration specifiers or ?...? before string constant
drivers/power/s3c_adc_battery.c:437:1: warning: data definition has no type or storage class
drivers/power/s3c_adc_battery.c:437:1: warning: type defaults to ?int? in declaration of ?MODULE_LICENSE?
drivers/power/s3c_adc_battery.c:437:16: warning: function declaration isn?t a prototype
make[2]: *** [drivers/power/s3c_adc_battery.o] Error 1

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/power/s3c_adc_battery.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
index a675e31..d32d0d7 100644
--- a/drivers/power/s3c_adc_battery.c
+++ b/drivers/power/s3c_adc_battery.c
@@ -20,6 +20,7 @@
 #include <linux/s3c_adc_battery.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/module.h>
 
 #include <plat/adc.h>
 
-- 
1.7.5.rc3
