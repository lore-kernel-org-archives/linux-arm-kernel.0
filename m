From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:37:31 +0200
Subject: [PATCH] config: arm: mxs: remove PROVE_LOCKING from defconfig
References: <CGME20181009153739eucas1p2002c9e68cd25088e13135c69c611f386@eucas1p2.samsung.com>
Message-ID: <20181009153739eucas1p2002c9e68cd25088e13135c69c611f386~b_s3LCHJk2226522265eucas1p27@eucas1p2.samsung.com>
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
 arch/arm/configs/mxs_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7b82128..22c9a8d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -170,7 +170,6 @@ CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-- 
2.7.4
