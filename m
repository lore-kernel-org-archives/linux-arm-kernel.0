From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 23:37:24 +0200
Subject: [PATCH v3 09/10] rtc: s3c: make header file local
In-Reply-To: <1365716245-99231-1-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
Message-ID: <1365716245-99231-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing outside of the rtc driver includes plat/regs-rtc.h,
so we can simply move the file into the same directory,
which allows us to build the file as platform-independent
code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: rtc-linux at googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/rtc-s3c.c                                                  | 3 +--
 arch/arm/plat-samsung/include/plat/regs-rtc.h => drivers/rtc/rtc-s3c.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-rtc.h => drivers/rtc/rtc-s3c.h (97%)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index fb994e9..7995f79 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -29,9 +29,8 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
-#include <plat/regs-rtc.h>
+#include "rtc-s3c.h"
 
 enum s3c_cpu_type {
 	TYPE_S3C2410,
diff --git a/arch/arm/plat-samsung/include/plat/regs-rtc.h b/drivers/rtc/rtc-s3c.h
similarity index 97%
rename from arch/arm/plat-samsung/include/plat/regs-rtc.h
rename to drivers/rtc/rtc-s3c.h
index 0f8263e..004b61a 100644
--- a/arch/arm/plat-samsung/include/plat/regs-rtc.h
+++ b/drivers/rtc/rtc-s3c.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-rtc.h
- *
+/*
  * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
  *		      http://www.simtec.co.uk/products/SWLINUX/
  *
-- 
1.8.1.2
