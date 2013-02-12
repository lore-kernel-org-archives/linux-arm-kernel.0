From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 12 Feb 2013 11:02:11 +0530
Subject: [PATCH] ARM: EXYNOS: update secondary startup code to use 24 bits of
 MPIDR
Message-ID: <1360647131-18461-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a0ae0240507... "ARM: kernel: add device tree init map function" started
using 24 LSBs of MPIDR to calculate the cpu_logical_map. Hence update the same
in exynos_secondary_startup code.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
---
 arch/arm/mach-exynos/headsmp.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index 5364d4b..5c1c24a 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -22,7 +22,7 @@
  */
 ENTRY(exynos4_secondary_startup)
 	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
+	and	r0, r0, #0xffffff
 	adr	r4, 1f
 	ldmia	r4, {r5, r6}
 	sub	r4, r4, r5
-- 
1.7.9.5
