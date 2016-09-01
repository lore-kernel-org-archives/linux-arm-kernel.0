From: js07.lee@samsung.com (Jungseung Lee)
Date: Thu, 01 Sep 2016 18:45:25 +0900
Subject: [PATCH] arm: mm: export set_memory_x and set_meory_nx
Message-ID: <20160901094525.8296-1-js07.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exports set_memory_x and set_memory_nx functions.
It is still allowed for modules to use these functions in other
architectures. In a similar manner to arm, export these functions.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 arch/arm/mm/pageattr.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index d19b1ad..abf6695 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -88,6 +88,7 @@ int set_memory_nx(unsigned long addr, int numpages)
 					__pgprot(L_PTE_XN),
 					__pgprot(0));
 }
+EXPORT_SYMBOL_GPL(set_memory_nx);
 
 int set_memory_x(unsigned long addr, int numpages)
 {
@@ -95,3 +96,4 @@ int set_memory_x(unsigned long addr, int numpages)
 					__pgprot(0),
 					__pgprot(L_PTE_XN));
 }
+EXPORT_SYMBOL_GPL(set_memory_x);
-- 
1.7.9.5
