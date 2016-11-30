From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 30 Nov 2016 14:30:31 +0800
Subject: [PATCH extra ] mm: hugetlb: add description for alloc_gigantic_page()
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1480487431-26181-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the description for function alloc_gigantic_page().

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3faec05..0d4bb8a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1089,6 +1089,12 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 	return zone_spans_pfn(zone, last_pfn);
 }
 
+/*
+ * Allocate a gigantic page from @nid node.
+ *
+ * Scan the zones of @nid node, and try to allocate a number of contiguous
+ * pages (1 << order).
+ */
 static struct page *alloc_gigantic_page(int nid, unsigned int order)
 {
 	unsigned long nr_pages = 1 << order;
-- 
2.5.5
