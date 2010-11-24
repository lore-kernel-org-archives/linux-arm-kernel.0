From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Nov 2010 09:57:45 +0100
Subject: [PATCH 1/6] ARM: add some KERN_CONT markers to continuation lines
In-Reply-To: <20101124085645.GW4693@pengutronix.de>
References: <20101124085645.GW4693@pengutronix.de>
Message-ID: <1290589070-854-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/fault-armv.c |    4 ++--
 arch/arm/mm/init.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 83e59f8..c8fb352 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -258,9 +258,9 @@ void __init check_writebuffer_bugs(void)
 	}
 
 	if (v) {
-		printk("failed, %s\n", reason);
+		printk(KERN_CONT "failed, %s\n", reason);
 		shared_pte_mask = L_PTE_MT_UNCACHED;
 	} else {
-		printk("ok\n");
+		printk(KERN_CONT "ok\n");
 	}
 }
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5164069..947663a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -549,9 +549,9 @@ void __init mem_init(void)
 		unsigned long pages = memblock_region_memory_end_pfn(reg) -
 			memblock_region_memory_base_pfn(reg);
 		num_physpages += pages;
-		printk(" %ldMB", pages >> (20 - PAGE_SHIFT));
+		printk(KERN_CONT " %ldMB", pages >> (20 - PAGE_SHIFT));
 	}
-	printk(" = %luMB total\n", num_physpages >> (20 - PAGE_SHIFT));
+	printk(KERN_CONT " = %luMB total\n", num_physpages >> (20 - PAGE_SHIFT));
 
 	printk(KERN_NOTICE "Memory: %luk/%luk available, %luk reserved, %luK highmem\n",
 		nr_free_pages() << (PAGE_SHIFT-10),
-- 
1.7.2.3
