From: ajeet.yadav.77@gmail.com (Ajeet Yadav)
Date: Fri, 17 Feb 2012 18:39:30 +0530
Subject: [PATCH 1/2] ARM: dma-mapping: its array of pointer
Message-ID: <1329484170-26329-1-git-send-email-ajeet.yadav.77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be consistant with declaration and usage of
consistent_pte it need to be an array of (pte *)

Signed-off-by: Ajeet Yadav <ajeet.yadav.77@gmail.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1aa664a..04bfa76 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -170,7 +170,7 @@ static int __init consistent_init(void)
 	unsigned long base = consistent_base;
 	unsigned long num_ptes = (CONSISTENT_END - base) >> PMD_SHIFT;
 
-	consistent_pte = kmalloc(num_ptes * sizeof(pte_t), GFP_KERNEL);
+	consistent_pte = kmalloc(num_ptes * sizeof(pte_t *), GFP_KERNEL);
 	if (!consistent_pte) {
 		pr_err("%s: no memory\n", __func__);
 		return -ENOMEM;
-- 
1.7.8.4
