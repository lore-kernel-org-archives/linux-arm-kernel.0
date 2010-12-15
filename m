From: m.nazarewicz@samsung.com (Michal Nazarewicz)
Date: Wed, 15 Dec 2010 21:34:21 +0100
Subject: [PATCHv8 01/12] mm: migrate.c: fix compilation error
In-Reply-To: <cover.1292443200.git.m.nazarewicz@samsung.com>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
Message-ID: <80579787f9493c73f568f6fa609c1238de3f0353.1292443200.git.m.nazarewicz@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC complained about update_mmu_cache() not being defined
in migrate.c.  Including <asm/tlbflush.h> seems to solve the problem.

Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
---
 mm/migrate.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fe5a3c6..6ae8a66 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -35,6 +35,8 @@
 #include <linux/hugetlb.h>
 #include <linux/gfp.h>
 
+#include <asm/tlbflush.h>
+
 #include "internal.h"
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
-- 
1.7.2.3
