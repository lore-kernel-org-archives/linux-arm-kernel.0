From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:39 +0530
Subject: [PATCH V5 61/63] ST SPEAr: Adding devices & clocks
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <e9c523d5e11791867edd97013b1b38ddf14d4f26.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |   39 ++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h   |    6 ++
 arch/arm/mach-spear13xx/include/mach/irqs.h      |   10 +-
 arch/arm/mach-spear13xx/include/mach/spear1310.h |   33 ++++++++
 arch/arm/mach-spear13xx/spear1310.c              |   87 ++++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c          |    8 ++
 arch/arm/mach-spear3xx/spear310_evb.c            |    5 +
 arch/arm/mach-spear3xx/spear320_evb.c            |    6 ++
 8 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 766e766..8495e88 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -1025,6 +1025,40 @@ static struct clk gmac_phy4_clk = {
 	.recalc = &follow_parent,
 };
 
+/* uart1 clock */
+static struct clk uart1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart2 clock */
+static struct clk uart2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart3 clock */
+static struct clk uart3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart4 clock */
+static struct clk uart4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart5 clock */
+static struct clk uart5_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
 #endif
 
 static struct clk dummy_apb_pclk;
@@ -1138,6 +1172,11 @@ static struct clk_lookup spear1310_clk_lookups[] = {
 	{.dev_id = "stmmacphy.2",	.clk = &gmac_phy2_clk},
 	{.dev_id = "stmmacphy.3",	.clk = &gmac_phy3_clk},
 	{.dev_id = "stmmacphy.4",	.clk = &gmac_phy4_clk},
+	{.dev_id = "uart1",		.clk = &uart1_clk},
+	{.dev_id = "uart2",		.clk = &uart2_clk},
+	{.dev_id = "uart3",		.clk = &uart3_clk},
+	{.dev_id = "uart4",		.clk = &uart4_clk},
+	{.dev_id = "uart5",		.clk = &uart5_clk},
 };
 #endif
 
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 768759a..70a4d64 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -256,8 +256,14 @@ void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear1310 declarations */
 #ifdef CONFIG_MACH_SPEAR1310
 /* Add spear1310 machine device structure declarations here */
+extern struct amba_device spear1310_uart1_device;
+extern struct amba_device spear1310_uart2_device;
+extern struct amba_device spear1310_uart3_device;
+extern struct amba_device spear1310_uart4_device;
+extern struct amba_device spear1310_uart5_device;
 extern struct platform_device spear1310_can0_device;
 extern struct platform_device spear1310_can1_device;
+extern struct platform_device spear1310_i2c1_device;
 
 /* Add spear1310 machine function declarations here */
 void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 1ca70a6..59bf61a 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -97,11 +97,11 @@
 #define IRQ_CCAN1		(IRQ_SHPI_START + 83)
 #define IRQ_TDM0		(IRQ_SHPI_START + 84)
 #define IRQ_TDM1		(IRQ_SHPI_START + 85)
-#define IRQ_UART0		(IRQ_SHPI_START + 86)
-#define IRQ_UART1		(IRQ_SHPI_START + 87)
-#define IRQ_UART2		(IRQ_SHPI_START + 88)
-#define IRQ_UART3		(IRQ_SHPI_START + 89)
-#define IRQ_UART4		(IRQ_SHPI_START + 90)
+#define IRQ_UART1		(IRQ_SHPI_START + 86)
+#define IRQ_UART2		(IRQ_SHPI_START + 87)
+#define IRQ_UART3		(IRQ_SHPI_START + 88)
+#define IRQ_UART4		(IRQ_SHPI_START + 89)
+#define IRQ_UART5		(IRQ_SHPI_START + 90)
 #define IRQ_I2C_CNTR		(IRQ_SHPI_START + 91)
 #define IRQ_GMAC0_SBD		(IRQ_SHPI_START + 92)
 #define IRQ_GMAC0_PMT		(IRQ_SHPI_START + 93)
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
index e57c99a..34f0a27 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear1310.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -16,9 +16,32 @@
 #ifndef __MACH_SPEAR1310_H
 #define __MACH_SPEAR1310_H
 
+#define SPEAR1310_TDM_E1_0_BASE		UL(0x6C200000)
+#define SPEAR1310_TDM_E1_1_BASE		UL(0x6C300000)
+#define SPEAR1310_RS485_0_BASE		UL(0x6C400000)
+#define SPEAR1310_RS485_1_BASE		UL(0x6C500000)
+#define SPEAR1310_GETH1_BASE		UL(0x6D000000)
+#define SPEAR1310_GETH2_BASE		UL(0x6D100000)
+#define SPEAR1310_GETH3_BASE		UL(0x6D200000)
+#define SPEAR1310_GETH4_BASE		UL(0x6D300000)
+#define SPEAR1310_UART1_BASE		UL(0x6D400000)
+#define SPEAR1310_UART2_BASE		UL(0x6D500000)
+#define SPEAR1310_UART3_BASE		UL(0x6D600000)
+#define SPEAR1310_UART4_BASE		UL(0x6D700000)
+#define SPEAR1310_UART5_BASE		UL(0x6D800000)
+#define SPEAR1310_I2C1_BASE		UL(0x6D900000)
 #define SPEAR1310_CAN0_BASE		UL(0x6DA00000)
 #define SPEAR1310_CAN1_BASE		UL(0x6DB00000)
 #define SPEAR1310_RAS_BASE		UL(0x6C800000)
+#define SPEAR1310_GETH1_BASE		UL(0x6D000000)
+#define SPEAR1310_GETH2_BASE		UL(0x6D100000)
+#define SPEAR1310_GETH3_BASE		UL(0x6D200000)
+#define SPEAR1310_GETH4_BASE		UL(0x6D300000)
+#define SPEAR1310_FSMC1_CS0_BASE	UL(0x70000000)
+#define SPEAR1310_FSMC1_CS1_BASE	UL(0x74000000)
+#define SPEAR1310_FSMC1_CS2_BASE	UL(0x78000000)
+#define SPEAR1310_FSMC1_CS3_BASE	UL(0x7C000000)
+#define SPEAR1310_FSMC1_BASE		UL(0x6FF00000)
 
 /* RAS Area Control Register */
 #define SPEAR1310_RAS_CTRL_REG0		(SPEAR1310_RAS_BASE + 0x0)
@@ -26,6 +49,16 @@
 #define SPEAR1310_PHY_CLK_MASK		0xF
 #define SPEAR1310_PHY_CLK_SHIFT		0
 
+#define RAS_FSMC_MODE_MASK		0x3
+#define RAS_FSMC_MODE_NOR		0
+#define RAS_FSMC_MODE_NAND		1
+#define RAS_FSMC_MODE_SRAM		2
+#define RAS_FSMC_WIDTH_MASK		0x30
+#define RAS_FSMC_WIDTH_8		0x00
+#define RAS_FSMC_WIDTH_16		0x10
+#define RAS_FSMC_WIDTH_32		0x20
+#define RAS_FSMC_CS_SPLIT		0x40
+
 #endif /* __MACH_SPEAR1310_H */
 
 #endif /* CONFIG_MACH_SPEAR1310 */
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 4f8ba02..10f5879 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/ptrace.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
@@ -355,6 +356,70 @@ struct pmx_dev pmx_can = {
 };
 
 /* Add spear1310 specific devices here */
+/* uart1 device registeration */
+struct amba_device spear1310_uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR1310_UART1_BASE,
+		.end = SPEAR1310_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device spear1310_uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR1310_UART2_BASE,
+		.end = SPEAR1310_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART2, NO_IRQ},
+};
+
+/* uart3 device registeration */
+struct amba_device spear1310_uart3_device = {
+	.dev = {
+		.init_name = "uart3",
+	},
+	.res = {
+		.start = SPEAR1310_UART3_BASE,
+		.end = SPEAR1310_UART3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART3, NO_IRQ},
+};
+
+/* uart4 device registeration */
+struct amba_device spear1310_uart4_device = {
+	.dev = {
+		.init_name = "uart4",
+	},
+	.res = {
+		.start = SPEAR1310_UART4_BASE,
+		.end = SPEAR1310_UART4_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART4, NO_IRQ},
+};
+
+/* uart5 device registeration */
+struct amba_device spear1310_uart5_device = {
+	.dev = {
+		.init_name = "uart5",
+	},
+	.res = {
+		.start = SPEAR1310_UART5_BASE,
+		.end = SPEAR1310_UART5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART5, NO_IRQ},
+};
 
 /* CAN device registeration */
 static struct resource can0_resources[] = {
@@ -393,6 +458,28 @@ struct platform_device spear1310_can1_device = {
 	.resource = can1_resources,
 };
 
+/* i2c1 device registeration */
+static struct resource i2c1_resources[] = {
+	{
+		.start = SPEAR1310_I2C1_BASE,
+		.end = SPEAR1310_I2C1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C_CNTR,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_i2c1_device = {
+	.name = "i2c_designware",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c1_resources),
+	.resource = i2c1_resources,
+};
+
 /* Following will create 1310 specific static virtual/physical mappings */
 struct map_desc spear1310_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index ca200dd..08289fa 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -57,6 +57,13 @@ static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_gpio_device[1],
 	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
+
+	/* spear1310 specific devices */
+	&spear1310_uart1_device,
+	&spear1310_uart2_device,
+	&spear1310_uart3_device,
+	&spear1310_uart4_device,
+	&spear1310_uart5_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
@@ -74,6 +81,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear1310 specific devices */
 	&spear1310_can0_device,
 	&spear1310_can1_device,
+	&spear1310_i2c1_device,
 };
 
 /* keyboard specific platform data */
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 180d50a..7ee6ede 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -74,6 +74,11 @@ static struct amba_device *amba_devs[] __initdata = {
 	&spear3xx_wdt_device,
 
 	/* spear310 specific devices */
+	&spear310_uart1_device,
+	&spear310_uart2_device,
+	&spear310_uart3_device,
+	&spear310_uart4_device,
+	&spear310_uart5_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index ce53778..a22d6ca 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -67,11 +67,16 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
+	&spear3xx_ssp0_device,
 	&spear3xx_uart_device,
 	&spear3xx_wdt_device,
 
 	/* spear320 specific devices */
 	&spear320_clcd_device,
+	&spear320_ssp_device[0],
+	&spear320_ssp_device[1],
+	&spear320_uart1_device,
+	&spear320_uart2_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
@@ -85,6 +90,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear320 specific devices */
 	&spear320_can0_device,
 	&spear320_can1_device,
+	&spear320_emi_nor_device,
 	&spear320_i2c1_device,
 	&spear320_nand_device,
 	&spear320_plgpio_device,
-- 
1.7.3.4
