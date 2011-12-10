From: axel.lin@gmail.com (Axel Lin)
Date: Sat, 10 Dec 2011 10:08:08 +0800
Subject: [PATCH] ARM: pxa: Include linux/export.h in balloon3.c
Message-ID: <1323482888.11437.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/export.h to fix below build warning:

  CC      arch/arm/mach-pxa/balloon3.o
arch/arm/mach-pxa/balloon3.c:85: warning: data definition has no type or storage class
arch/arm/mach-pxa/balloon3.c:85: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/mach-pxa/balloon3.c:85: warning: parameter names (without types) in function declaration

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 5971c46..c35456f 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -13,6 +13,7 @@
  *  published by the Free Software Foundation.
  */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-- 
1.7.5.4
