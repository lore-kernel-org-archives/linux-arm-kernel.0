From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:08 +0530
Subject: [PATCH V5 30/63] ST SPEAr: Replacing SIZE macro's with actual
	required size
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <38be663ab3e653d889d64005a86ed4dcf8661ae1.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

In arch specific files SIZE macro's were defined which were used for
creating memory/io mappings for sepecific devices. These macro's are
coming straight from h/w user manual and are much greated than required
sizes. Replacing these macros by actual required size.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    9 +++------
 arch/arm/mach-spear3xx/spear310.c |    2 +-
 arch/arm/mach-spear3xx/spear320.c |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c |    8 ++++----
 arch/arm/mach-spear6xx/spear6xx.c |   10 +++++-----
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 6989407..30e893f 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -604,8 +604,7 @@ struct spear_shirq shirq_ras1 = {
 void sdhci_i2s_mem_enable(u8 mask)
 {
 	u32 val;
-	void __iomem *base = ioremap(SPEAR300_SOC_CONFIG_BASE,
-			SPEAR300_SOC_CONFIG_SIZE);
+	void __iomem *base = ioremap(SPEAR300_SOC_CONFIG_BASE, SZ_4K);
 	if (!base) {
 		pr_debug("sdhci_i2s_enb: ioremap fail\n");
 		return;
@@ -628,8 +627,7 @@ void __init spear300_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	shirq_ras1.regs.base =
-		ioremap(SPEAR300_TELECOM_BASE, SPEAR300_TELECOM_REG_SIZE);
+	shirq_ras1.regs.base = ioremap(SPEAR300_TELECOM_BASE, SZ_4K);
 	if (shirq_ras1.regs.base) {
 		ret = spear_shirq_register(&shirq_ras1);
 		if (ret)
@@ -637,8 +635,7 @@ void __init spear300_init(void)
 	}
 
 	/* pmx initialization */
-	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE,
-			SPEAR300_SOC_CONFIG_SIZE);
+	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE, SZ_4K);
 	if (pmx_driver.base) {
 		ret = pmx_register(&pmx_driver);
 		if (ret)
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index bb9ff7c..ffc1f63 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -362,7 +362,7 @@ void __init spear310_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SPEAR310_SOC_CONFIG_SIZE);
+	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SZ_4K);
 	if (base) {
 		/* shirq 1 */
 		shirq_ras1.regs.base = base;
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index ab4ad8e..ac4f80b 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -694,7 +694,7 @@ void __init spear320_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SPEAR320_SOC_CONFIG_SIZE);
+	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SZ_4K);
 	if (base) {
 		/* shirq 1 */
 		shirq_ras1.regs.base = base;
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 6be49b3..0088b7c 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -235,22 +235,22 @@ struct map_desc spear3xx_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
-		.length		= SPEAR3XX_ICM1_UART_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
-		.length		= SPEAR3XX_ML1_VIC_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
-		.length		= SPEAR3XX_ICM3_SYS_CTRL_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
-		.length		= SPEAR3XX_ICM3_MISC_REG_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	},
 };
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index a948dd4..f8be93a 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -389,27 +389,27 @@ static struct map_desc spear6xx_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR6XX_ICM1_UART0_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_UART0_BASE),
-		.length		= SPEAR6XX_ICM1_UART0_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_CPU_VIC_PRI_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_PRI_BASE),
-		.length		= SPEAR6XX_CPU_VIC_PRI_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_CPU_VIC_SEC_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_SEC_BASE),
-		.length		= SPEAR6XX_CPU_VIC_SEC_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_ICM3_SYS_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SYS_CTRL_BASE),
-		.length		= SPEAR6XX_ICM3_MISC_REG_BASE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_ICM3_MISC_REG_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_MISC_REG_BASE),
-		.length		= SPEAR6XX_ICM3_MISC_REG_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	},
 };
-- 
1.7.3.4
