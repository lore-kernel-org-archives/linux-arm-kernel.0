From: kaloz@openwrt.org (Imre Kaloz)
Date: Sun,  4 Sep 2011 16:09:49 +0200
Subject: [PATCHv2] ARM: remove missing cns3xxx includes
Message-ID: <1315145389-3377-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c9d95fbe59e426eed7f16e7cac812e46ac4772d0 "ARM: convert PCI defines
to variables" deleted cns3xxx' hardware.h, but didn't remove references
for it, so do it now.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S |    1 -
 arch/arm/mach-cns3xxx/include/mach/system.h      |    1 -
 arch/arm/mach-cns3xxx/include/mach/uncompress.h  |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index 6bd83ed..d87bfc3 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/hardware.h>
 #include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
index 58bb03a..4f16c9b 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -13,7 +13,6 @@
 
 #include <linux/io.h>
 #include <asm/proc-fns.h>
-#include <mach/hardware.h>
 
 static inline void arch_idle(void)
 {
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index de8ead9..a91b605 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -8,7 +8,6 @@
  */
 
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
 #include <mach/cns3xxx.h>
 
 #define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
-- 
1.7.1
