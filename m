From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:08:53 -0800
Subject: [PATCH 06/21] ARM: tegra: irqs: Update irq list
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-7-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes typo in INT_CPU1_PMU_INTR (original fix from Will Deacon)
Adds board irqs

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/include/mach/irqs.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
index 71bbf34..73265af 100644
--- a/arch/arm/mach-tegra/include/mach/irqs.h
+++ b/arch/arm/mach-tegra/include/mach/irqs.h
@@ -88,7 +88,7 @@
 #define INT_SYS_STATS_MON		(INT_SEC_BASE + 22)
 #define INT_GPIO5			(INT_SEC_BASE + 23)
 #define INT_CPU0_PMU_INTR		(INT_SEC_BASE + 24)
-#define INT_CPU2_PMU_INTR		(INT_SEC_BASE + 25)
+#define INT_CPU1_PMU_INTR		(INT_SEC_BASE + 25)
 #define INT_SEC_RES_26			(INT_SEC_BASE + 26)
 #define INT_S_LINK1			(INT_SEC_BASE + 27)
 #define INT_APB_DMA_COP			(INT_SEC_BASE + 28)
@@ -166,10 +166,18 @@
 #define INT_QUAD_RES_30			(INT_QUAD_BASE + 30)
 #define INT_QUAD_RES_31			(INT_QUAD_BASE + 31)
 
-#define INT_GPIO_BASE			(INT_QUAD_BASE + 32)
+#define INT_MAIN_NR			(INT_QUAD_BASE + 32 - INT_PRI_BASE)
+
+#define INT_GPIO_BASE			(INT_PRI_BASE + INT_MAIN_NR)
+
 #define INT_GPIO_NR			(28 * 8)
 
-#define NR_IRQS				(INT_GPIO_BASE + INT_GPIO_NR)
+#define TEGRA_NR_IRQS			(INT_GPIO_BASE + INT_GPIO_NR)
+
+#define INT_BOARD_BASE			TEGRA_NR_IRQS
+#define NR_BOARD_IRQS			32
+
+#define NR_IRQS				(INT_BOARD_BASE + NR_BOARD_IRQS)
 #endif
 
 #endif
-- 
1.7.3.1
