From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:26 +0900
Subject: [PATCH 34/43] ARM: shmobile: add gic_iid macro for ICCIAR / interrupt
 ID
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-35-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car H1 datasheet GIC number is indicating
GIC ICCIAR / interrupt ID number, not SPI number,
but current marzen board code is using gic_spi() with
un-understandable calculation.

This patch adds new gic_iid() macro which means
ICCIAR / interrupt ID, and used the number
currently written on datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[ horms+renesas at verge.net.au: Split board-marzen.c portion into a separate patch ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/irqs.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index 06a5da3..992ed21 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -5,6 +5,7 @@
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
+#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
 
 /* INTCS */
 #define INTCS_VECT_BASE		0x3400
-- 
1.7.10.4
