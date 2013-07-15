From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 15 Jul 2013 15:15:06 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress debug
 is disabled
Message-ID: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if uncompress debug is disabled, some board will continue to print
information during uncompress step.
By using debug/uncompress.h include, all debug output will be disabled.

This is usefull in Xen environment for DOM0 because the UART is stolen by
Xen.

Signed-off-by: Julien Grall <julien.grall@linaro.org>
---
 arch/arm/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 21cc8a7..86c023d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -679,7 +679,7 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || !DEBUG_UNCOMPRESS
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
1.7.10.4
