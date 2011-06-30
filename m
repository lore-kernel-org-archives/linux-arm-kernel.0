From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:15:24 +0900
Subject: [PATCH v3 1/6] ARM: EXYNOS4: Increase NR_IRQS for devices with more
	IRQs
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309421729-11172-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX8997/17042, which are used by Exynos4-NURI, use additional IRQ
numbers after GPIO's IRQs. The patch creates some room for those
devices.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 31f6bed..51b5db5 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -154,6 +154,6 @@
 #define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
 
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_GPIO_END)
+#define NR_IRQS			(IRQ_GPIO_END + 64)
 
 #endif /* __ASM_ARCH_IRQS_H */
-- 
1.7.4.1
