From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 13:48:37 +0900
Subject: [PATCH 4/7] ARM: S5PC210: I2C1/2 support
Message-ID: <20100930044837.GA16909@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Define the I2C1/2 physcial address & interrupts.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |    2 ++
 arch/arm/mach-s5pv310/include/mach/map.h  |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index e81332f..aa17ec7 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -70,6 +70,8 @@
 #define IRQ_UART4		COMBINER_IRQ(26, 4)
 
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
+#define IRQ_IIC1		COMBINER_IRQ(27, 1)
+#define IRQ_IIC2		COMBINER_IRQ(27, 2)
 
 #define IRQ_HSMMC0		COMBINER_IRQ(29, 0)
 #define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index eab0ff7..118ad48 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -69,7 +69,7 @@
 
 #define S5P_SZ_UART			SZ_256
 
-#define S5PV310_PA_IIC0			(0x13860000)
+#define S5PV310_PA_I2C(x)		(0x13860000 + ((x) * 0x10000))
 
 #define S5PV310_PA_TIMER		(0x139D0000)
 #define S5P_PA_TIMER			S5PV310_PA_TIMER
@@ -83,7 +83,9 @@
 #define S3C_PA_HSMMC1			S5PV310_PA_HSMMC(1)
 #define S3C_PA_HSMMC2			S5PV310_PA_HSMMC(2)
 #define S3C_PA_HSMMC3			S5PV310_PA_HSMMC(3)
-#define S3C_PA_IIC			S5PV310_PA_IIC0
+#define S3C_PA_IIC			S5PV310_PA_I2C(0)
+#define S3C_PA_IIC1			S5PV310_PA_I2C(1)
+#define S3C_PA_IIC2			S5PV310_PA_I2C(2)
 #define S3C_PA_RTC			S5PV310_PA_RTC
 #define S3C_PA_WDT			S5PV310_PA_WATCHDOG
 
-- 
1.5.3.3
