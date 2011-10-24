From: christian.hitz@aizo.com (Christian Hitz)
Date: Mon, 24 Oct 2011 08:57:32 +0200
Subject: [PATCH Resend] arm: at91: fix NAND bus width decoding from system_rev
Message-ID: <4EA50C5C.2040701@aizo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it safe to assign the return value of this function
to u8/u16 variables.

Signed-off-by: Christian Hitz <christian.hitz@aizo.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
  arch/arm/mach-at91/include/mach/system_rev.h |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/system_rev.h 
b/arch/arm/mach-at91/include/mach/system_rev.h
index 8f48660..ec164a4 100644
--- a/arch/arm/mach-at91/include/mach/system_rev.h
+++ b/arch/arm/mach-at91/include/mach/system_rev.h
@@ -19,7 +19,7 @@
  #define BOARD_HAVE_NAND_16BIT	(1 << 31)
  static inline int board_have_nand_16bit(void)
  {
-	return system_rev & BOARD_HAVE_NAND_16BIT;
+	return (system_rev & BOARD_HAVE_NAND_16BIT) ? 1 : 0;
  }
   #endif /* __ARCH_SYSTEM_REV_H__ */
-- 
1.7.4.1
