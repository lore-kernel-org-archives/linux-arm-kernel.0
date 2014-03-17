From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:07 +0000
Subject: [PATCH 19/44] ARM: l2c: clean up L2 cache initialisation messages
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCt-0002d8-V1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make one of them purely "English", and the other purely technical.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9d2b55b05f71..37dd74c9e61a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -532,9 +532,10 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 
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
