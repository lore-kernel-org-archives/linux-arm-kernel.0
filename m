From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:34 +0530
Subject: [PATCH V6 06/17] ST SPEAr3xx: Adding RAS uart devices
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <824d91ccd4029a54df0d9764f055866789415f27.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    7 +++
 arch/arm/mach-spear3xx/spear310.c             |   65 +++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear310_evb.c         |    5 ++
 arch/arm/mach-spear3xx/spear320.c             |   26 ++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c         |    2 +
 5 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 6d4db44..8925b7b 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -146,6 +146,11 @@ void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear310 declarations */
 #ifdef CONFIG_MACH_SPEAR310
 /* Add spear310 machine device structure declarations here */
+extern struct amba_device spear310_uart1_device;
+extern struct amba_device spear310_uart2_device;
+extern struct amba_device spear310_uart3_device;
+extern struct amba_device spear310_uart4_device;
+extern struct amba_device spear310_uart5_device;
 extern struct platform_device spear310_plgpio_device;
 
 /* pad mux devices */
@@ -168,6 +173,8 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
+extern struct amba_device spear320_uart1_device;
+extern struct amba_device spear320_uart2_device;
 extern struct platform_device spear320_plgpio_device;
 extern struct platform_device spear320_pwm_device;
 
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index a4cd44c..ba21b75 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -309,6 +309,71 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* Add spear310 specific devices here */
+/* uart1 device registeration */
+struct amba_device spear310_uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR310_UART1_BASE,
+		.end = SPEAR310_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR310_VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device spear310_uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR310_UART2_BASE,
+		.end = SPEAR310_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR310_VIRQ_UART2, NO_IRQ},
+};
+
+/* uart3 device registeration */
+struct amba_device spear310_uart3_device = {
+	.dev = {
+		.init_name = "uart3",
+	},
+	.res = {
+		.start = SPEAR310_UART3_BASE,
+		.end = SPEAR310_UART3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR310_VIRQ_UART3, NO_IRQ},
+};
+
+/* uart4 device registeration */
+struct amba_device spear310_uart4_device = {
+	.dev = {
+		.init_name = "uart4",
+	},
+	.res = {
+		.start = SPEAR310_UART4_BASE,
+		.end = SPEAR310_UART4_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR310_VIRQ_UART4, NO_IRQ},
+};
+
+/* uart5 device registeration */
+struct amba_device spear310_uart5_device = {
+	.dev = {
+		.init_name = "uart5",
+	},
+	.res = {
+		.start = SPEAR310_UART5_BASE,
+		.end = SPEAR310_UART5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR310_VIRQ_UART5, NO_IRQ},
+};
+
 /* plgpio device registeration */
 /*
  * pin to offset and offset to pin converter functions
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 9c1b7ca..36fb611 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -47,6 +47,11 @@ static struct amba_device *amba_devs[] __initdata = {
 	&spear3xx_wdt_device,
 
 	/* spear310 specific devices */
+	&spear310_uart1_device,
+	&spear310_uart2_device,
+	&spear310_uart3_device,
+	&spear310_uart4_device,
+	&spear310_uart5_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index c1642c1..77089a7 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -712,6 +712,32 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* Add spear320 specific devices here */
+/* uart1 device registeration */
+struct amba_device spear320_uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR320_UART1_BASE,
+		.end = SPEAR320_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR320_VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device spear320_uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR320_UART2_BASE,
+		.end = SPEAR320_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {SPEAR320_VIRQ_UART2, NO_IRQ},
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 7b12f0c..ebc4bb9 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -44,6 +44,8 @@ static struct amba_device *amba_devs[] __initdata = {
 	&spear3xx_wdt_device,
 
 	/* spear320 specific devices */
+	&spear320_uart1_device,
+	&spear320_uart2_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
-- 
1.7.2.2
