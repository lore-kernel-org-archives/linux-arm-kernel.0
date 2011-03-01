From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:40 +0530
Subject: [PATCH V6 07/11] ST SPEAr3xx: Appending spear3** with global device
	structures
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <29487655ad1e85f901f624053a445c14dfd6fa9e.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    6 +++---
 arch/arm/mach-spear3xx/spear300.c             |    2 +-
 arch/arm/mach-spear3xx/spear300_evb.c         |    6 +++---
 arch/arm/mach-spear3xx/spear310_evb.c         |    4 ++--
 arch/arm/mach-spear3xx/spear320_evb.c         |    4 ++--
 arch/arm/mach-spear3xx/spear3xx.c             |    4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 9186e5a..5320ab6 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -31,8 +31,8 @@
 #define SPEAR_GPT0_CHAN1_IRQ	SPEAR3XX_IRQ_CPU_GPT1_2
 
 /* Add spear3xx family device structure declarations here */
-extern struct amba_device gpio_device;
-extern struct amba_device uart_device;
+extern struct amba_device spear3xx_gpio_device;
+extern struct amba_device spear3xx_uart_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
@@ -99,7 +99,7 @@ extern struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50;
 /* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
 /* Add spear300 machine device structure declarations here */
-extern struct amba_device gpio1_device;
+extern struct amba_device spear300_gpio1_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear300_nand_mode;
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 2618181..89999bf 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -582,7 +582,7 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= SPEAR300_GPIO1_INT_BASE,
 };
 
-struct amba_device gpio1_device = {
+struct amba_device spear300_gpio1_device = {
 	.dev = {
 		.init_name = "gpio1",
 		.platform_data = &gpio1_plat_data,
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 405ae09..69006f6 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -34,11 +34,11 @@ static struct pmx_dev *pmx_devs[] = {
 
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
-	&gpio_device,
-	&uart_device,
+	&spear3xx_gpio_device,
+	&spear3xx_uart_device,
 
 	/* spear300 specific devices */
-	&gpio1_device,
+	&spear300_gpio1_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 9d4aadb..c8684ce 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -42,8 +42,8 @@ static struct pmx_dev *pmx_devs[] = {
 
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
-	&gpio_device,
-	&uart_device,
+	&spear3xx_gpio_device,
+	&spear3xx_uart_device,
 
 	/* spear310 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 7e5f17f..a12b353 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -39,8 +39,8 @@ static struct pmx_dev *pmx_devs[] = {
 
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
-	&gpio_device,
-	&uart_device,
+	&spear3xx_gpio_device,
+	&spear3xx_uart_device,
 
 	/* spear320 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 64dac69..c32a186 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -28,7 +28,7 @@ static struct pl061_platform_data gpio_plat_data = {
 	.irq_base	= SPEAR3XX_GPIO_INT_BASE,
 };
 
-struct amba_device gpio_device = {
+struct amba_device spear3xx_gpio_device = {
 	.dev = {
 		.init_name = "gpio",
 		.platform_data = &gpio_plat_data,
@@ -42,7 +42,7 @@ struct amba_device gpio_device = {
 };
 
 /* uart device registration */
-struct amba_device uart_device = {
+struct amba_device spear3xx_uart_device = {
 	.dev = {
 		.init_name = "uart",
 	},
-- 
1.7.2.2
