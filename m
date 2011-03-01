From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:09 +0530
Subject: [PATCH V6 3/8] ST SPEAr3xx: Rename sdio to sdhci
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <7e722cc06ed3e2a25885d9f1f623adf9049274f2.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device name of SD/MMC/SDIO controller in linux is sdhci. To maintain
consistency across all spear code, rename sdio to sdhci.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h  |    8 ++++----
 arch/arm/mach-spear3xx/include/mach/irqs.h     |    4 ++--
 arch/arm/mach-spear3xx/include/mach/spear300.h |    4 ++--
 arch/arm/mach-spear3xx/include/mach/spear320.h |    6 +++---
 arch/arm/mach-spear3xx/spear300.c              |   20 ++++++++++----------
 arch/arm/mach-spear3xx/spear300_evb.c          |    2 +-
 arch/arm/mach-spear3xx/spear320.c              |   20 ++++++++++----------
 arch/arm/mach-spear3xx/spear320_evb.c          |    2 +-
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index aaaa046..8e30636 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -129,8 +129,8 @@ extern struct pmx_dev pmx_telecom_camera;
 extern struct pmx_dev pmx_telecom_dac;
 extern struct pmx_dev pmx_telecom_i2s;
 extern struct pmx_dev pmx_telecom_boot_pins;
-extern struct pmx_dev pmx_telecom_sdio_4bit;
-extern struct pmx_dev pmx_telecom_sdio_8bit;
+extern struct pmx_dev pmx_telecom_sdhci_4bit;
+extern struct pmx_dev pmx_telecom_sdhci_8bit;
 extern struct pmx_dev pmx_gpio1;
 
 /* Add spear300 machine function declarations here */
@@ -172,14 +172,14 @@ extern struct pmx_dev pmx_clcd;
 extern struct pmx_dev pmx_emi;
 extern struct pmx_dev pmx_fsmc;
 extern struct pmx_dev pmx_spp;
-extern struct pmx_dev pmx_sdio;
+extern struct pmx_dev pmx_sdhci;
 extern struct pmx_dev pmx_i2s;
 extern struct pmx_dev pmx_uart1;
 extern struct pmx_dev pmx_uart1_modem;
 extern struct pmx_dev pmx_uart2;
 extern struct pmx_dev pmx_touchscreen;
 extern struct pmx_dev pmx_can;
-extern struct pmx_dev pmx_sdio_led;
+extern struct pmx_dev pmx_sdhci_led;
 extern struct pmx_dev pmx_pwm0;
 extern struct pmx_dev pmx_pwm1;
 extern struct pmx_dev pmx_pwm2;
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 7f940b8..a1a7f48 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -69,7 +69,7 @@
 #define IRQ_CLCD				IRQ_GEN_RAS_3
 
 /* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define IRQ_SDIO				IRQ_INTRCOMM_RAS_ARM
+#define IRQ_SDHCI				IRQ_INTRCOMM_RAS_ARM
 
 /* GPIO pins virtual irqs */
 #define SPEAR_GPIO_INT_BASE			(VIRQ_START + 9)
@@ -115,7 +115,7 @@
 #define VIRQ_SPP				(VIRQ_START + 2)
 
 /* IRQs sharing IRQ_GEN_RAS_2 */
-#define IRQ_SDIO				IRQ_GEN_RAS_2
+#define IRQ_SDHCI				IRQ_GEN_RAS_2
 
 /* IRQs sharing IRQ_GEN_RAS_3 */
 #define VIRQ_PLGPIO				(VIRQ_START + 3)
diff --git a/arch/arm/mach-spear3xx/include/mach/spear300.h b/arch/arm/mach-spear3xx/include/mach/spear300.h
index ccaa765..1059d5a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear300.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear300.h
@@ -39,8 +39,8 @@
 #define SPEAR300_CLCD_BASE		0x60000000
 #define SPEAR300_CLCD_SIZE		0x10000000
 
-#define SPEAR300_SDIO_BASE		0x70000000
-#define SPEAR300_SDIO_SIZE		0x10000000
+#define SPEAR300_SDHCI_BASE		0x70000000
+#define SPEAR300_SDHCI_SIZE		0x10000000
 
 #define SPEAR300_NAND_0_BASE		0x80000000
 #define SPEAR300_NAND_0_SIZE		0x04000000
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index 53677e4..1c9d310 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -25,8 +25,8 @@
 #define SPEAR320_I2S_BASE		0x60000000
 #define SPEAR320_I2S_SIZE		0x10000000
 
-#define SPEAR320_SDIO_BASE		0x70000000
-#define SPEAR320_SDIO_SIZE		0x10000000
+#define SPEAR320_SDHCI_BASE		0x70000000
+#define SPEAR320_SDHCI_SIZE		0x10000000
 
 #define SPEAR320_CLCD_BASE		0x90000000
 #define SPEAR320_CLCD_SIZE		0x10000000
@@ -74,7 +74,7 @@
 #define EMI_IRQ_MASK			(1 << 7)
 #define CLCD_IRQ_MASK			(1 << 8)
 #define SPP_IRQ_MASK			(1 << 9)
-#define SDIO_IRQ_MASK			(1 << 10)
+#define SDHCI_IRQ_MASK			(1 << 10)
 #define CAN_U_IRQ_MASK			(1 << 11)
 #define CAN_L_IRQ_MASK			(1 << 12)
 #define UART1_IRQ_MASK			(1 << 13)
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index e15c684..42dc29b 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -310,7 +310,7 @@ struct pmx_dev pmx_telecom_boot_pins = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_4bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -323,14 +323,14 @@ struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_4bit = {
-	.name = "telecom_sdio_4bit",
-	.modes = pmx_telecom_sdio_4bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_4bit_modes),
+struct pmx_dev pmx_telecom_sdhci_4bit = {
+	.name = "telecom_sdhci_4bit",
+	.modes = pmx_telecom_sdhci_4bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_4bit_modes),
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_8bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -342,10 +342,10 @@ struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_8bit = {
-	.name = "telecom_sdio_8bit",
-	.modes = pmx_telecom_sdio_8bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_8bit_modes),
+struct pmx_dev pmx_telecom_sdhci_8bit = {
+	.name = "telecom_sdhci_8bit",
+	.modes = pmx_telecom_sdhci_8bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_8bit_modes),
 	.enb_on_reset = 1,
 };
 
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 77c9b83..42d2253 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -28,7 +28,7 @@ static struct pmx_dev *pmx_devs[] = {
 	/* spear300 specific devices */
 	&pmx_fsmc_2_chips,
 	&pmx_clcd,
-	&pmx_telecom_sdio_4bit,
+	&pmx_telecom_sdhci_4bit,
 	&pmx_gpio1,
 };
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index c25f909..6dba628 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -110,7 +110,7 @@ struct pmx_dev pmx_spp = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_modes[] = {
+struct pmx_dev_mode pmx_sdhci_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE |
 			SMALL_PRINTERS_MODE,
@@ -118,10 +118,10 @@ struct pmx_dev_mode pmx_sdio_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdio = {
-	.name = "sdio",
-	.modes = pmx_sdio_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_modes),
+struct pmx_dev pmx_sdhci = {
+	.name = "sdhci",
+	.modes = pmx_sdhci_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_modes),
 	.enb_on_reset = 1,
 };
 
@@ -215,17 +215,17 @@ struct pmx_dev pmx_can = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_led_modes[] = {
+struct pmx_dev_mode pmx_sdhci_led_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_SSP_CS_MASK,
 	},
 };
 
-struct pmx_dev pmx_sdio_led = {
-	.name = "sdio_led",
-	.modes = pmx_sdio_led_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_led_modes),
+struct pmx_dev pmx_sdhci_led = {
+	.name = "sdhci_led",
+	.modes = pmx_sdhci_led_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_led_modes),
 	.enb_on_reset = 1,
 };
 
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 0b80a15..8213e4b 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -26,7 +26,7 @@ static struct pmx_dev *pmx_devs[] = {
 
 	/* spear320 specific devices */
 	&pmx_fsmc,
-	&pmx_sdio,
+	&pmx_sdhci,
 	&pmx_i2s,
 	&pmx_uart1,
 	&pmx_uart2,
-- 
1.7.2.2
