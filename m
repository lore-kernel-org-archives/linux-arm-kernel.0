From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:36 +0200
Subject: [PATCH 5/7] ARM: SAMSUNG: Constify array of wake irqs passed to
 samsung_sync_wakemask
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung_sync_wakemask() iterates over passed array of wake irqs but
does not modify it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/plat-samsung/include/plat/wakeup-mask.h | 2 +-
 arch/arm/plat-samsung/wakeup-mask.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/wakeup-mask.h b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
index 43e4acd2e1c6..bbfa84b0505a 100644
--- a/arch/arm/plat-samsung/include/plat/wakeup-mask.h
+++ b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
@@ -38,7 +38,7 @@ struct samsung_wakeup_mask {
  * required to be correct before we enter sleep.
  */
 extern void samsung_sync_wakemask(void __iomem *reg,
-				  struct samsung_wakeup_mask *masks,
+				  const struct samsung_wakeup_mask *masks,
 				  int nr_masks);
 
 #endif /* __PLAT_WAKEUP_MASK_H */
diff --git a/arch/arm/plat-samsung/wakeup-mask.c b/arch/arm/plat-samsung/wakeup-mask.c
index 20c3d9117cc2..b9de6b543330 100644
--- a/arch/arm/plat-samsung/wakeup-mask.c
+++ b/arch/arm/plat-samsung/wakeup-mask.c
@@ -20,7 +20,7 @@
 #include <plat/pm.h>
 
 void samsung_sync_wakemask(void __iomem *reg,
-			   struct samsung_wakeup_mask *mask, int nr_mask)
+			   const struct samsung_wakeup_mask *mask, int nr_mask)
 {
 	struct irq_data *data;
 	u32 val;
-- 
2.7.4
