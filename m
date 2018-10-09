From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:37:55 +0200
Subject: [PATCH] config: arm: imote2: remove PROVE_LOCKING from defconfig
References: <CGME20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111@eucas1p2.samsung.com>
Message-ID: <20181009153803eucas1p27051cdb030dd5cdbd1a935afe55ad111~b_tNPuZi40944609446eucas1p2f@eucas1p2.samsung.com>
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
 arch/arm/configs/imote2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index f204017..d190f74 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -341,7 +341,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=m
-- 
2.7.4
