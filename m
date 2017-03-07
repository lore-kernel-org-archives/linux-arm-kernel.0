From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 07 Mar 2017 09:37:05 +0530
Subject: [PATCH] irqchip/gic-v3: Fix GICD_CTLR_ARE_NS bit field
References: <CGME20170307041023epcas5p1229831d4cc8541e6c35914508e6e01f0@epcas5p1.samsung.com>
Message-ID: <1488859625-7532-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@gmail.com>

As per GICv3 Architecture specification 8.9.4 field descriptions,
GICD_CTLR_ARE_NS is bit[5]. This patch correct the same.

Fixes: 021f6537 ("irqchip: gic-v3: Initial support for GICv3")
Cc: stable at vger.kernel.org
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index e808f8a..4aaf639 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -57,7 +57,7 @@
 
 #define GICD_CTLR_RWP			(1U << 31)
 #define GICD_CTLR_DS			(1U << 6)
-#define GICD_CTLR_ARE_NS		(1U << 4)
+#define GICD_CTLR_ARE_NS		(1U << 5)
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
 #define GICD_CTLR_ENABLE_G1		(1U << 0)
 
-- 
2.7.4
