From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 Jul 2014 11:36:07 +0200
Subject: [PATCH] CMA: generalize CMA reserved area management functionality
 (fixup)
In-Reply-To: <53C78ED7.7030002@samsung.com>
References: <53C78ED7.7030002@samsung.com>
Message-ID: <1405589767-17513-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX_CMA_AREAS is used by other subsystems (i.e. arch/arm/mm/dma-mapping.c),
so we need to provide correct definition even if CMA is disabled.
This patch fixes this issue.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/cma.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9a18a2b1934c..c077635cad76 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -5,7 +5,11 @@
  * There is always at least global CMA area and a few optional
  * areas configured in kernel .config.
  */
+#ifdef CONFIG_CMA
 #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
+#else
+#define MAX_CMA_AREAS	(0)
+#endif
 
 struct cma;
 
-- 
1.9.2
