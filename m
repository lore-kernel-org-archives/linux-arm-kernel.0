From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Tue, 29 Jan 2013 12:29:14 +0530
Subject: [PATCH v2 1/9] ARM: OMAP2+: AM33XX: CM: Get rid of unnecessary header
 inclusions
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1359442762-13697-2-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cm33xx.h unnecessarily includes a lot of header files.
Get rid of these and directly include "iomap.h" which
is needed to keep things compiling.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
v2: Reword the changelog

 arch/arm/mach-omap2/cm33xx.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 5fa0b62..8009e13 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,16 +17,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
 #include "common.h"
 
 #include "cm.h"
 #include "cm-regbits-33xx.h"
-#include "cm33xx.h"
+#include "iomap.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
-- 
1.8.1
