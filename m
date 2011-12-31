From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Dec 2011 09:50:51 +0800
Subject: [PATCH] ARM: imx6: remove __CPUINIT annotation from v7_invalidate_l1
Message-ID: <1325296251-11144-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent suspend testing on !SMP build discovers that the __CPUINIT
annotation for v7_invalidate_l1 should not be there, as the function
is called by resume path for not only SMP but also !SMP build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/head-v7.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index c844112..914f2a1 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -16,7 +16,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 	.section ".text.head", "ax"
-	__CPUINIT
 
 /*
  * The secondary kernel init calls v7_flush_dcache_all before it enables
-- 
1.7.4.1
