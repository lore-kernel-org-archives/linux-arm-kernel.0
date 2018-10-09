From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:38:37 +0200
Subject: [PATCH] config: arm: ezx: remove PROVE_LOCKING from defconfig
References: <CGME20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2@eucas1p2.samsung.com>
Message-ID: <20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2~b_t016W_j0771107711eucas1p2k@eucas1p2.samsung.com>
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
 arch/arm/configs/ezx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 484e51f..ddfb44c 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -367,7 +367,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=m
-- 
2.7.4
