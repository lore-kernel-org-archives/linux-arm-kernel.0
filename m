From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu,  3 May 2012 18:19:25 -0400
Subject: [PATCH] ARM: fix watchdog build failure in s3c2410 platform
Message-ID: <1336083565-29093-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4c1134cc961f825370dd9f84ce0169bd0ed97957 (linux-next)

    "watchdog: s3c2410-wdt: Use of_match_ptr()."

caused a compile failure because of a missing header include:

drivers/watchdog/s3c2410_wdt.c:517:3: error: implicit declaration of
function 'of_match_ptr' [-Werror=implicit-function-declaration]

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 04e5a6d..a76f89e 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -37,6 +37,7 @@
 #include <linux/clk.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-- 
1.7.9.1
