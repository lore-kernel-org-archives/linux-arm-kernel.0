From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:54:37 +0100
Subject: [PATCH 10/10] ARM: io: remove IO_SPACE_LIMIT from SA11x0
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1QtaxR-0007NH-5p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA11x0 only uses IO_SPACE_LIMIT for SOC_COMMON, so we can use the
default value in asm/io.h.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/io.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/io.h b/arch/arm/mach-sa1100/include/mach/io.h
index d8b43f3..dfc27ff 100644
--- a/arch/arm/mach-sa1100/include/mach/io.h
+++ b/arch/arm/mach-sa1100/include/mach/io.h
@@ -10,11 +10,9 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
- * We don't actually have real ISA nor PCI buses, but there is so many 
- * drivers out there that might just work if we fake them...
+ * __io() is required to be an equivalent mapping to __mem_pci() for
+ * SOC_COMMON to work.
  */
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
-- 
1.7.4.4
