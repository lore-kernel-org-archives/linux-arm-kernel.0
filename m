From: saeed@marvell.com (Saeed Bishara)
Date: Thu, 12 May 2011 21:33:03 +0300
Subject: [PATCH 2/2] ARM: fix the note about dcache lazy flushing for SMP
	systems
In-Reply-To: <1305225183-15521-1-git-send-email-saeed@marvell.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
Message-ID: <1305225183-15521-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mm/flush.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index f1b7998..e632363 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -275,7 +275,8 @@ void __sync_icache_dcache(pte_t pteval)
  *  kernel cache lines for later.  Otherwise, we assume we have
  *  aliasing mappings.
  *
- * Note that we disable the lazy flush for SMP.
+ * Note that we disable the lazy flush for SMP configurations where
+ * the cache maintenance operations are not automatically broadcasted
  */
 void flush_dcache_page(struct page *page)
 {
-- 
1.7.1
