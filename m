From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 19 Aug 2016 17:29:07 +0100
Subject: [PATCH] ARM: document and update UNCACHEABLE_ADDR definitions
Message-ID: <E1bamfL-0002WN-7u@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the UNCACHEABLE_ADDR definitions for footbridge and SA1100
so that we know where they're located and/or what they're accessing.
Change RiscPC to calculate the UNCACHEABLE_ADDR value from FLUSH_BASE
as that's where we locate that.

UNCACHEABLE_ADDR is used to perform an uncached access (ARMv4
terminology) necessary to force a CPU clock-switch to the memory-
speed clock, as required for entering WFI.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-footbridge/include/mach/hardware.h | 2 +-
 arch/arm/mach-rpc/include/mach/hardware.h        | 2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 02f6d7a706b1..20d5ad781fe2 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -59,7 +59,7 @@
 #define XBUS_SWITCH_J17_11	((*XBUS_SWITCH) & (1 << 5))
 #define XBUS_SWITCH_J17_9	((*XBUS_SWITCH) & (1 << 6))
 
-#define UNCACHEABLE_ADDR	(ARMCSR_BASE + 0x108)
+#define UNCACHEABLE_ADDR	(ARMCSR_BASE + 0x108)	/* CSR_ROMBASEMASK */
 
 
 /* PIC irq control */
diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index 257166b21f3d..aa79fa47373a 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -40,7 +40,7 @@
 #define SCREEN_END		0xdfc00000
 #define SCREEN_BASE		0xdf800000
 
-#define UNCACHEABLE_ADDR	0xdf010000
+#define UNCACHEABLE_ADDR	(FLUSH_BASE + 0x10000)
 
 /*
  * IO Addresses
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index 55c85ce7010d..d944fd7e464f 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -13,7 +13,7 @@
 #define __ASM_ARCH_HARDWARE_H
 
 
-#define UNCACHEABLE_ADDR	0xfa050000
+#define UNCACHEABLE_ADDR	0xfa050000	/* ICIP */
 
 
 /*
-- 
2.1.0
