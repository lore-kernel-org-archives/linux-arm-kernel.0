From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 19 Jun 2014 19:26:33 +0400
Subject: [PATCH RESEND 1/5] ARM: clps711x: Remove IO_ADDRESS() macro
Message-ID: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All uses of the IO_ADDRESS() macro has been removed.
This patch removes the definition of this macro.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/hardware.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 5d6afda..292cbcb 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -24,10 +24,7 @@
 
 #include <mach/clps711x.h>
 
-#define IO_ADDRESS(x)		(0xdc000000 + (((x) & 0x03ffffff) | \
-				(((x) >> 2) & 0x3c000000)))
-
-#define CLPS711X_VIRT_BASE	IOMEM(IO_ADDRESS(CLPS711X_PHYS_BASE))
+#define CLPS711X_VIRT_BASE	IOMEM(0xfe000000)
 
 #ifndef __ASSEMBLY__
 #define clps_readb(off)		readb(CLPS711X_VIRT_BASE + (off))
-- 
1.8.5.5
