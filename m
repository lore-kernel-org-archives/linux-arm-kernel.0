From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Jul 2013 18:10:03 -0300
Subject: [PATCH v2] ARM: mm: cache-l2x0: Print the cache size in kB
Message-ID: <1374700203-29684-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have the following output from cache-l2x0:
 
l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x32070000, Cache size: 1048576 B

Using kB for the cache size can improve readability a bit:

l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x32070000, Cache size: 1024 kB

While at it use pr_info.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix rebase issue

 arch/arm/mm/cache-l2x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d70e0ab..ad4e882 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -417,9 +417,9 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		outer_cache.disable = l2x0_disable;
 	}
 
-	printk(KERN_INFO "%s cache controller enabled\n", type);
-	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
-			ways, cache_id, aux, l2x0_size);
+	pr_info("%s cache controller enabled\n", type);
+	pr_info("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d kB\n",
+		ways, cache_id, aux, l2x0_size >> 10);
 }
 
 #ifdef CONFIG_OF
-- 
1.8.1.2
