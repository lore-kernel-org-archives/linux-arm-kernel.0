From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 14 Mar 2011 08:06:45 +0100
Subject: [PATCH v2] ARM: EXYNOS4: add a placeholder for board specific
	interrupts
Message-ID: <1300086405-9895-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a placeholder for board specific interrupts on S5PC210
platform.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/irqs.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 5d03730..cc2186d 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -154,7 +154,11 @@
 #define IRQ_GPIO2_NR_GROUPS	9
 #define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
 
+/* optional board specific irqs */
+#define IRQ_BOARD_START		IRQ_GPIO_END
+#define IRQ_NR_BOARD		16
+
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_GPIO_END)
+#define NR_IRQS			(IRQ_GPIO_END + IRQ_NR_BOARD)
 
 #endif /* __ASM_ARCH_IRQS_H */
-- 
1.7.1.569.g6f426
