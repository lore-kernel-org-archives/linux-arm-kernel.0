From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:55:28 +0000
Subject: [PATCH 1/5] XXX: tcc8k
In-Reply-To: <20111106175457.GK12913@n2100.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6wK-0001aN-Md@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-tcc/include/mach/system.h |    4 ++--
 arch/arm/plat-tcc/system.c              |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
index 909e603..9adf36f 100644
--- a/arch/arm/plat-tcc/include/mach/system.h
+++ b/arch/arm/plat-tcc/include/mach/system.h
@@ -16,7 +16,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-extern void plat_tcc_reboot(void);
+extern void plat_tcc_restart(char mode, const char *cmd);
 
 static inline void arch_idle(void)
 {
@@ -25,7 +25,7 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	plat_tcc_reboot();
+	plat_tcc_restart(mode, cmd);
 }
 
 #endif
diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
index cc208fa..88c041d 100644
--- a/arch/arm/plat-tcc/system.c
+++ b/arch/arm/plat-tcc/system.c
@@ -12,7 +12,7 @@
 #include <mach/tcc8k-regs.h>
 
 /* System reboot */
-void plat_tcc_reboot(void)
+void plat_tcc_restart(char mode, const char *cmd)
 {
 	/* Make sure clocks are on */
 	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
-- 
1.7.4.4
