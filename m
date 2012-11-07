From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 07 Nov 2012 15:03:36 +0900
Subject: [PATCH] ARM: cache-l2x0: move 'l2_wt_override' variable to proper
 place
Message-ID: <003f01cdbcad$a024c1e0$e06e45a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed build warning as below:

arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used [-Wunused-variable]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mm/cache-l2x0.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 92ee4a0..920a704 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -34,7 +34,6 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
-static int l2_wt_override;
 
 /* Aurora don't have the cache ID register available, so we have to
  * pass it though the device tree */
@@ -429,6 +428,8 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
  * noninclusive, while the hardware cache range operations use
  * inclusive start and end addresses.
  */
+static int l2_wt_override;
+
 static unsigned long calc_range_end(unsigned long start, unsigned long end)
 {
 	/*
-- 
1.7.1
