From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Dec 2010 20:52:43 +0100
Subject: [PATCH 2/4 v2] ARM: S5PV310: Add resource definitions for MIPI CSIS
In-Reply-To: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
References: <1291405965-19482-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1291405965-19482-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IRQ and register base address definitions for MIPI CSI slave devices.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |    3 +++
 arch/arm/mach-s5pv310/include/mach/map.h  |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 3c05c58..34f2144 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -86,6 +86,9 @@
 #define IRQ_HSMMC2		COMBINER_IRQ(29, 2)
 #define IRQ_HSMMC3		COMBINER_IRQ(29, 3)
 
+#define IRQ_MIPI_CSIS0		COMBINER_IRQ(30, 0)
+#define IRQ_MIPI_CSIS1		COMBINER_IRQ(30, 1)
+
 #define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
 
 #define IRQ_EINT4		COMBINER_IRQ(37, 0)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 5399446..ab4b041 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -61,6 +61,9 @@
 #define S5PV310_PA_GPIO2		(0x11000000)
 #define S5PV310_PA_GPIO3		(0x03860000)
 
+#define S5PV310_PA_MIPI_CSIS0		0x11880000
+#define S5PV310_PA_MIPI_CSIS1		0x11890000
+
 #define S5PV310_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 
 #define S5PV310_PA_SROMC		(0x12570000)
@@ -116,5 +119,7 @@
 #define S3C_PA_IIC7			S5PV310_PA_IIC(7)
 #define S3C_PA_RTC			S5PV310_PA_RTC
 #define S3C_PA_WDT			S5PV310_PA_WATCHDOG
+#define S5P_PA_MIPI_CSIS0		S5PV310_PA_MIPI_CSIS0
+#define S5P_PA_MIPI_CSIS1		S5PV310_PA_MIPI_CSIS1
 
 #endif /* __ASM_ARCH_MAP_H */
-- 
1.7.3.2
