From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:37 +0900
Subject: [PATCH 21/21] ARM: shmobile: Remove legacy clock support leftovers
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <04418c23a9411b85b8789eab5f4397bcbd62b7b4.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The shmobile_clk_init() function has been removed and the linux/sh_clk.h
header doesn't need to be included anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h  | 2 --
 arch/arm/mach-shmobile/r8a7779.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 0833a6ed02e4..9cb11215ceba 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -15,8 +15,6 @@ extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
-struct clk;
-extern int shmobile_clk_init(void);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
index db303f76704e..aad833a8f0b8 100644
--- a/arch/arm/mach-shmobile/r8a7779.h
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
-#include <linux/sh_clk.h>
-
 extern void r8a7779_pm_init(void);
 
 #ifdef CONFIG_PM
-- 
2.1.4
