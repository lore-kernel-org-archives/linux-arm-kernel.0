From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:37 +0530
Subject: [PATCH V6 04/11] ST SPEAr3xx: Make local shirq structures static
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <1f184bb627677fbb2f4577d362fcbbb73fa7fed0.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Several structures in arch/arm/mach-spear3xx are not marked static
like they should be. Fix this.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    4 ++--
 arch/arm/mach-spear3xx/spear310.c |   16 ++++++++--------
 arch/arm/mach-spear3xx/spear320.c |   12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 2e856d8..a1280ba 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -523,7 +523,7 @@ struct pmx_driver pmx_driver = {
 };
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_IT_PERS_S,
 		.enb_mask = IT_PERS_S_IRQ_MASK,
@@ -563,7 +563,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 20182d2..3a2c4b2 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -192,7 +192,7 @@ struct pmx_dev pmx_tdm0 = {
 struct pmx_driver pmx_driver;
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_SMII0,
 		.status_mask = SMII0_IRQ_MASK,
@@ -220,7 +220,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -232,7 +232,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras2_config[] = {
+static struct shirq_dev_config shirq_ras2_config[] = {
 	{
 		.virq = VIRQ_UART1,
 		.status_mask = UART1_IRQ_MASK,
@@ -251,7 +251,7 @@ struct shirq_dev_config shirq_ras2_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras2 = {
+static struct spear_shirq shirq_ras2 = {
 	.irq = IRQ_GEN_RAS_2,
 	.dev_config = shirq_ras2_config,
 	.dev_count = ARRAY_SIZE(shirq_ras2_config),
@@ -263,14 +263,14 @@ struct spear_shirq shirq_ras2 = {
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
@@ -282,7 +282,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_TDM_HDLC,
 		.status_mask = TDM_HDLC_IRQ_MASK,
@@ -295,7 +295,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 249798b3..fee265b 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -587,7 +587,7 @@ struct pmx_driver pmx_driver = {
 };
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_EMI,
 		.status_mask = EMI_IRQ_MASK,
@@ -603,7 +603,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -616,7 +616,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras3_config[] = {
+static struct shirq_dev_config shirq_ras3_config[] = {
 	{
 		.virq = VIRQ_PLGPIO,
 		.enb_mask = GPIO_IRQ_MASK,
@@ -635,7 +635,7 @@ struct shirq_dev_config shirq_ras3_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras3 = {
+static struct spear_shirq shirq_ras3 = {
 	.irq = IRQ_GEN_RAS_3,
 	.dev_config = shirq_ras3_config,
 	.dev_count = ARRAY_SIZE(shirq_ras3_config),
@@ -649,7 +649,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_CANU,
 		.status_mask = CAN_U_IRQ_MASK,
@@ -697,7 +697,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
-- 
1.7.2.2
