From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:43 +0530
Subject: [PATCH V3 23/63] ST SPEAr: Adding Watchdog support
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <cfde23b37a779944a4deab5d0cec0a952e153890.1292833228.git.viresh.kumar@st.com>
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
index 447de7e..3a64846 100644
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
index b4dca98..a4a854e 100644
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
index d523040..f9f467f 100644
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
index 943eddc..6ce37af 100644
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
index 61d607b..6271c32 100644
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
index 3b15289..c185b6c 100644
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
index b4dfd25..f77aea8 100644
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
index e78c2e5..f594fa4 100644
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
