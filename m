From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:50 +0530
Subject: [PATCH V4 23/62] ST SPEAr: Adding Watchdog support
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <2f005948d8e907e362c2469a5f961e128e4a23b3.1295333958.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear3xx.c             |   12 ++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
 arch/arm/mach-spear6xx/spear6xx.c             |   12 ++++++++++++
 8 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 21a4ac0..3400ecd 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,6 +33,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct amba_device wdt_device;
 extern struct platform_device ehci_device;
 extern struct platform_device i2c_device;
 extern struct platform_device ohci0_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 330b677..abbc802 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -37,6 +37,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear300 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 7b7a236..6c00695 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear310 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index eedcdd7..d371b31 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -41,6 +41,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear320 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 93be834..561949d 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,18 @@ struct amba_device uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR3XX_ICM3_WDT_BASE,
+		.end = SPEAR3XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index ed1dbfc..112cc9b 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index be4e5c9..7ec09b6 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -23,6 +23,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[2],
 	&uart_device[0],
 	&uart_device[1],
+	&wdt_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index c6c9dfb..4801fc7 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -118,6 +118,18 @@ struct amba_device gpio_device[] = {
 	}
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR6XX_ICM3_WDT_BASE,
+		.end = SPEAR6XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
-- 
1.7.2.2
