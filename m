From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 17 Oct 2016 16:00:46 +0100
Subject: [PATCH] irqchip: gic-v3-its: fix entry size mask for GITS_BASER
Message-ID: <1476716446-28646-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Entry Size in GITS_BASER<n> occupies 5 bits [52:48], but we mask out 8
bits.

Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 include/linux/irqchip/arm-gic-v3.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 7dec96f..5118d3a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -290,7 +290,7 @@
 #define GITS_BASER_TYPE_SHIFT			(56)
 #define GITS_BASER_TYPE(r)		(((r) >> GITS_BASER_TYPE_SHIFT) & 7)
 #define GITS_BASER_ENTRY_SIZE_SHIFT		(48)
-#define GITS_BASER_ENTRY_SIZE(r)	((((r) >> GITS_BASER_ENTRY_SIZE_SHIFT) & 0xff) + 1)
+#define GITS_BASER_ENTRY_SIZE(r)	((((r) >> GITS_BASER_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
 #define GITS_BASER_SHAREABILITY_SHIFT	(10)
 #define GITS_BASER_InnerShareable					\
 	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
-- 
1.7.9.5
