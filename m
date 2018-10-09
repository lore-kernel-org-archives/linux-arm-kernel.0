From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:36:58 +0200
Subject: [PATCH] config: arm: moxart: remove PROVE_LOCKING from defconfig
References: <CGME20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083@eucas1p2.samsung.com>
Message-ID: <20181009153711eucas1p29688c4724f8b9d81a3096dd97a363083~b_scuHGMD0310103101eucas1p2i@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench which will speed up
by x3 times (11sec -> 3.4sec).
When you check transaction on cache or buses, the results are way higher
than normal for the same hackbench test:
L1d cache invalidations: 26mln vs 4mln
L2u cache invalidations: 42mln vs 12mln
bus cyc/access: 30cyc/access vs. 20cyc/access
context switch is x3 times cheaper

Enable this option only when you have some locking issue to investigate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/moxart_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 2da0d9e..5740d47 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -136,7 +136,6 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_PROVE_LOCKING=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_KGDB=y
 CONFIG_DEBUG_LL=y
-- 
2.7.4
