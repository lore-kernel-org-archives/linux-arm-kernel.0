From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:11 +0530
Subject: [PATCH V6 5/8] ST SPEAr3xx: Declare device structures after shirq code
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <ace528081cf61ad4b0c539fbecad3a19db76ac84.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Order of declarations should be: pmx_devs, shirq support, amba_devices,
plat_devices, routines. This patch moves gpio_device below shirq support.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |   40 ++++++++++++++++++------------------
 arch/arm/mach-spear3xx/spear310.c |    4 +-
 arch/arm/mach-spear3xx/spear320.c |    4 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 42dc29b..23d2a14 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -370,26 +370,6 @@ struct pmx_driver pmx_driver = {
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
 
-/* Add spear300 specific devices here */
-/* arm gpio1 device registration */
-static struct pl061_platform_data gpio1_plat_data = {
-	.gpio_base	= 8,
-	.irq_base	= SPEAR_GPIO1_INT_BASE,
-};
-
-struct amba_device gpio1_device = {
-	.dev = {
-		.init_name = "gpio1",
-		.platform_data = &gpio1_plat_data,
-	},
-	.res = {
-		.start = SPEAR300_GPIO_BASE,
-		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {VIRQ_GPIO1, NO_IRQ},
-};
-
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
@@ -443,6 +423,26 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
+/* Add spear300 specific devices here */
+/* arm gpio1 device registration */
+static struct pl061_platform_data gpio1_plat_data = {
+	.gpio_base	= 8,
+	.irq_base	= SPEAR_GPIO1_INT_BASE,
+};
+
+struct amba_device gpio1_device = {
+	.dev = {
+		.init_name = "gpio1",
+		.platform_data = &gpio1_plat_data,
+	},
+	.res = {
+		.start = SPEAR300_GPIO_BASE,
+		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_GPIO1, NO_IRQ},
+};
+
 /* spear300 routines */
 void __init spear300_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 5bfab14..3a3d548 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -139,8 +139,6 @@ struct pmx_driver pmx_driver = {
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
 
-/* Add spear310 specific devices here */
-
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
@@ -257,6 +255,8 @@ struct spear_shirq shirq_intrcomm_ras = {
 	},
 };
 
+/* Add spear310 specific devices here */
+
 /* spear310 routines */
 void __init spear310_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 6dba628..8ba3ff2 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -384,8 +384,6 @@ struct pmx_driver pmx_driver = {
 	.mux_reg = {.offset = PAD_MUX_CONFIG_REG, .mask = 0x00007fff},
 };
 
-/* Add spear320 specific devices here */
-
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
@@ -510,6 +508,8 @@ struct spear_shirq shirq_intrcomm_ras = {
 	},
 };
 
+/* Add spear320 specific devices here */
+
 /* spear320 routines */
 void __init spear320_init(void)
 {
-- 
1.7.2.2
