From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:17 +0100
Subject: [PATCH 49/51] ARM: plat-mxc: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-50-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates plat-mxc to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-mxc/include/mach/system.h |    2 --
 arch/arm/plat-mxc/system.c              |    3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 51f02a9..0cce970 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -56,6 +56,4 @@ static inline void arch_idle(void)
 		cpu_do_idle();
 }
 
-void arch_reset(char mode, const char *cmd);
-
 #endif /* __ASM_ARCH_MXC_SYSTEM_H__ */
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 8024f2a..107e0a6 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -33,7 +33,7 @@ static void __iomem *wdog_base;
 /*
  * Reset the system. It is called by machine_restart().
  */
-void arch_reset(char mode, const char *cmd)
+static void mxc_arch_reset(char mode, const char *cmd)
 {
 	unsigned int wcr_enable;
 
@@ -73,4 +73,5 @@ void arch_reset(char mode, const char *cmd)
 void mxc_arch_reset_init(void __iomem *base)
 {
 	wdog_base = base;
+	arm_arch_reset = mxc_arch_reset;
 }
-- 
1.7.4.1
