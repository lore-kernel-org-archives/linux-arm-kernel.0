From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 28 Jun 2012 22:28:08 +0200
Subject: [PATCH] ARM: Orion: Fix WDT compile for Dove and MV78xx0
Message-ID: <1340915288-22437-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0fa1f0609a0c1fe8b2be3c0089a2cb48f7fda521 (ARM: Orion: Fix
Virtual/Physical mixup with watchdog) broke the Dove & MV78xx0
build. Although these two SoC don't use the watchdog, the shared
platform code still needs to build. Add the necessary defines.

Reported-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/include/mach/bridge-regs.h    |    1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h |    1 +
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h     |    2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 226949d..f953bb5 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -50,5 +50,6 @@
 #define POWER_MANAGEMENT	(BRIDGE_VIRT_BASE | 0x011c)
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
+#define TIMER_PHYS_BASE         (BRIDGE_PHYS_BASE | 0x0300)
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index c64dbb9..eb187e0 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -31,5 +31,6 @@
 #define IRQ_MASK_HIGH_OFF	0x0014
 
 #define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
+#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE | 0x0300)
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index 3674497..e807c4c 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -42,6 +42,7 @@
 #define MV78XX0_CORE0_REGS_PHYS_BASE	0xf1020000
 #define MV78XX0_CORE1_REGS_PHYS_BASE	0xf1024000
 #define MV78XX0_CORE_REGS_VIRT_BASE	0xfe400000
+#define MV78XX0_CORE_REGS_PHYS_BASE	0xfe400000
 #define MV78XX0_CORE_REGS_SIZE		SZ_16K
 
 #define MV78XX0_PCIE_IO_PHYS_BASE(i)	(0xf0800000 + ((i) << 20))
@@ -59,6 +60,7 @@
  * Core-specific peripheral registers.
  */
 #define BRIDGE_VIRT_BASE	(MV78XX0_CORE_REGS_VIRT_BASE)
+#define BRIDGE_PHYS_BASE	(MV78XX0_CORE_REGS_PHYS_BASE)
 
 /*
  * Register Map
-- 
1.7.10
