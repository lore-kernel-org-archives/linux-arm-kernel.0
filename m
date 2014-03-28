From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:16:29 +0000
Subject: [PATCH 25/75] ARM: l2c: clean up L2 cache initialisation messages
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYWD-0006ct-2i@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make one of them purely "English", and the other purely technical.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a544f19c448f..713cdcef25d1 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -545,9 +545,10 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 
 	outer_cache = fns;
 
-	pr_info("%s cache controller enabled\n", type);
-	pr_info("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d kB\n",
-		ways, cache_id, aux, l2x0_size >> 10);
+	pr_info("%s cache controller enabled, %d ways, %d kB\n",
+		type, ways, l2x0_size >> 10);
+	pr_info("%s: CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
+		type, cache_id, aux);
 }
 
 void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
-- 
1.8.3.1
