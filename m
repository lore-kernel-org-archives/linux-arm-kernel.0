From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Oct 2010 14:46:39 +0200
Subject: [PATCH 1/3] ARM: S5PC110: Fix wrong interrupt I2C2 and I2C3 number
In-Reply-To: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
References: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1286455601-25360-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

The name of the interrupt should be IIC2 and IIC3 instead of CAN0 and CAN1.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/irqs.h |    4 ++--
 arch/arm/plat-samsung/dev-i2c2.c          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index bb7f277..119b95f 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -55,8 +55,8 @@
 #define IRQ_SPI1		S5P_IRQ_VIC1(16)
 #define IRQ_SPI2		S5P_IRQ_VIC1(17)
 #define IRQ_IRDA		S5P_IRQ_VIC1(18)
-#define IRQ_CAN0		S5P_IRQ_VIC1(19)
-#define IRQ_CAN1		S5P_IRQ_VIC1(20)
+#define IRQ_IIC2		S5P_IRQ_VIC1(19)
+#define IRQ_IIC3		S5P_IRQ_VIC1(20)
 #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
 #define IRQ_HSITX		S5P_IRQ_VIC1(22)
 #define IRQ_UHOST		S5P_IRQ_VIC1(23)
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
index 07036de..ff4ba69 100644
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -32,8 +32,8 @@ static struct resource s3c_i2c_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = IRQ_CAN0,
-		.end   = IRQ_CAN0,
+		.start = IRQ_IIC2,
+		.end   = IRQ_IIC2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
-- 
1.7.1.569.g6f426
