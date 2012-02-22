From: ajeet.yadav.77@gmail.com (Ajeet Yadav)
Date: Wed, 22 Feb 2012 09:06:55 +0530
Subject: [PATCH] ARM: dma-mapping: Fix the type used for consistent_pte size
 calculation
Message-ID: <1329881815-11306-1-git-send-email-ajeet.yadav.77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be consistent with declaration and usage of consistent_pte, it needs
to be an array of (pte *)

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
