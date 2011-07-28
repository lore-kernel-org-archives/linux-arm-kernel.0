From: tommy.lin.1101@gmail.com (Tommy Lin)
Date: Fri, 29 Jul 2011 01:14:46 +0800
Subject: [PATCH 1/3] arch: arm: mach-cns3xxx: Fix compile error caused by
	hardware.h removed
Message-ID: <1311873286-26035-1-git-send-email-tommy.lin.1101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest version remove arch/arm/mach-cns3xxx/include/mach/hardware.h.
This patch removes lines that refer to hardware.h.

Signed-off-by: Tommy Lin <tommy.lin.1101@gmail.com>
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
1.7.6
