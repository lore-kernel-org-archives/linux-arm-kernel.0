From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:53:30 +0000
Subject: [PATCH 40/41] ARM: restart: remove comments about adding code to
 arch_reset()
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_reset() is deprecated; systems should hook into system restart via
the 'restart' method in the platforms machine description record.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-msm/include/mach/system.h       |    4 ----
 arch/arm/mach-picoxcell/include/mach/system.h |    1 -
 arch/arm/mach-ux500/include/mach/system.h     |    1 -
 arch/arm/mach-zynq/include/mach/system.h      |    1 -
 4 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index d2e83f4..e180e8b 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -12,14 +12,10 @@
  * GNU General Public License for more details.
  *
  */
-
-#include <mach/hardware.h>
-
 void arch_idle(void);
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	for (;;) ;  /* depends on IPC w/ other core */
 }
 
 /* low level hardware reset hook -- for example, hitting the
diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
index 67c589b..a12da63 100644
--- a/arch/arm/mach-picoxcell/include/mach/system.h
+++ b/arch/arm/mach-picoxcell/include/mach/system.h
@@ -25,7 +25,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(int mode, const char *cmd)
 {
-	/* Watchdog reset to go here. */
 }
 
 #endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-ux500/include/mach/system.h b/arch/arm/mach-ux500/include/mach/system.h
index c0cd800..ae1dff1 100644
--- a/arch/arm/mach-ux500/include/mach/system.h
+++ b/arch/arm/mach-ux500/include/mach/system.h
@@ -19,7 +19,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/* yet to be implemented - TODO */
 }
 
 #endif
diff --git a/arch/arm/mach-zynq/include/mach/system.h b/arch/arm/mach-zynq/include/mach/system.h
index 1b84d70..34be7ed 100644
--- a/arch/arm/mach-zynq/include/mach/system.h
+++ b/arch/arm/mach-zynq/include/mach/system.h
@@ -22,7 +22,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/* Add architecture specific reset processing here */
 }
 
 #endif
-- 
1.7.4.4
