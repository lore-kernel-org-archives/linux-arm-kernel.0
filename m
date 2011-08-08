From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Aug 2011 15:11:58 +0200
Subject: [PATCH] ARM: EXYNOS4: Fix the IRQ definitions for MIPI CSIS device
Message-ID: <1312809118-6181-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a regression fix after migration to the external GIC.
The breakage has been introduced in commit:
"ARM: EXYNOS4: modify interrupt mappings for external GIC"

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/irqs.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 934d2a4..f8952f8 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -80,9 +80,8 @@
 #define IRQ_HSMMC3		IRQ_SPI(76)
 #define IRQ_DWMCI		IRQ_SPI(77)
 
-#define IRQ_MIPICSI0		IRQ_SPI(78)
-
-#define IRQ_MIPICSI1		IRQ_SPI(80)
+#define IRQ_MIPI_CSIS0		IRQ_SPI(78)
+#define IRQ_MIPI_CSIS1		IRQ_SPI(80)
 
 #define IRQ_ONENAND_AUDI	IRQ_SPI(82)
 #define IRQ_ROTATOR		IRQ_SPI(83)
-- 
1.7.5.4
