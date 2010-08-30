From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:24 +0530
Subject: [PATCH 61/74] SPEAr3xx: Make local structres static
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <9f8b1e704357e99d98654d480b2539a301a6cc3b.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Several structures in arch/arm/mach-spear3xx are not marked static
like they should be. Fix this.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    6 +++---
 arch/arm/mach-spear3xx/spear310.c |   16 ++++++++--------
 arch/arm/mach-spear3xx/spear320.c |   12 ++++++------
 arch/arm/mach-spear3xx/spear3xx.c |    2 --
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index fb11f7c..9750875 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -114,7 +114,6 @@ struct pmx_mode caml_lcd_mode = {
 	.value = 0x0F,
 };
 
-/* devices */
 /* Pad multiplexing for FSMC 2 NAND devices */
 static struct pmx_mux_reg pmx_fsmc_2_mux[] = {
 	{
@@ -700,7 +699,7 @@ struct platform_device sdhci_device = {
 };
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_IT_PERS_S,
 		.enb_mask = IT_PERS_S_IRQ_MASK,
@@ -740,7 +739,8 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 227af86..5c913f5 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -374,7 +374,7 @@ struct platform_device plgpio_device = {
 
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_SMII0,
 		.status_mask = SMII0_IRQ_MASK,
@@ -402,7 +402,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -414,7 +414,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras2_config[] = {
+static struct shirq_dev_config shirq_ras2_config[] = {
 	{
 		.virq = VIRQ_UART1,
 		.status_mask = UART1_IRQ_MASK,
@@ -433,7 +433,7 @@ struct shirq_dev_config shirq_ras2_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras2 = {
+static struct spear_shirq shirq_ras2 = {
 	.irq = IRQ_GEN_RAS_2,
 	.dev_config = shirq_ras2_config,
 	.dev_count = ARRAY_SIZE(shirq_ras2_config),
@@ -445,14 +445,14 @@ struct spear_shirq shirq_ras2 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras3_config[] = {
+static struct shirq_dev_config shirq_ras3_config[] = {
 	{
 		.virq = VIRQ_EMI,
 		.status_mask = EMI_IRQ_MASK,
 	},
 };
 
-struct spear_shirq shirq_ras3 = {
+static struct spear_shirq shirq_ras3 = {
 	.irq = IRQ_GEN_RAS_3,
 	.dev_config = shirq_ras3_config,
 	.dev_count = ARRAY_SIZE(shirq_ras3_config),
@@ -464,7 +464,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_TDM_HDLC,
 		.status_mask = TDM_HDLC_IRQ_MASK,
@@ -477,7 +477,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 5e0303f..d39fda3 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -846,7 +846,7 @@ struct platform_device sdhci_device = {
 };
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_EMI,
 		.status_mask = EMI_IRQ_MASK,
@@ -862,7 +862,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -875,7 +875,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras3_config[] = {
+static struct shirq_dev_config shirq_ras3_config[] = {
 	{
 		.virq = VIRQ_PLGPIO,
 		.enb_mask = GPIO_IRQ_MASK,
@@ -894,7 +894,7 @@ struct shirq_dev_config shirq_ras3_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras3 = {
+static struct spear_shirq shirq_ras3 = {
 	.irq = IRQ_GEN_RAS_3,
 	.dev_config = shirq_ras3_config,
 	.dev_count = ARRAY_SIZE(shirq_ras3_config),
@@ -908,7 +908,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_CANU,
 		.status_mask = CAN_U_IRQ_MASK,
@@ -956,7 +956,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index a1b2fa3..1e2371f 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -292,7 +292,6 @@ void __init spear3xx_map_io(void)
 }
 
 /* pad multiplexing support */
-/* devices */
 
 /* Pad multiplexing for firda device */
 static struct pmx_mux_reg pmx_firda_mux[] = {
@@ -625,7 +624,6 @@ struct pmx_dev pmx_timer_1_2 = {
 };
 
 #if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-/* plgpios devices */
 /* Pad multiplexing for plgpio_0_1 devices */
 static struct pmx_mux_reg pmx_plgpio_0_1_mux[] = {
 	{
-- 
1.7.2.2
