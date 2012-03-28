From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 28 Mar 2012 15:00:11 +0530
Subject: [PATCH V2 1/7] SPEAr: Use CLKDEV_INIT for defining clk_lookups
In-Reply-To: <cover.1332926608.git.viresh.kumar@st.com>
References: <cover.1332926608.git.viresh.kumar@st.com>
Message-ID: <082491f368250d0079067053efa3e9be54dedb4b.1332926608.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c |  111 ++++++++++++++++++++--------------------
 arch/arm/mach-spear6xx/clock.c |   80 ++++++++++++++---------------
 2 files changed, 96 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 6c4841f..6b2cd9b 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -652,85 +653,85 @@ static struct clk pwm_clk = {
 
 /* array of all spear 3xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
-	{ .con_id = "apb_pclk",		.clk = &dummy_apb_pclk},
+	CLKDEV_INIT(NULL, "apb_pclk", &dummy_apb_pclk),
 	/* root clks */
-	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
-	{ .con_id = "osc_24m_clk",	.clk = &osc_24m_clk},
+	CLKDEV_INIT(NULL, "osc_32k_clk", &osc_32k_clk),
+	CLKDEV_INIT(NULL, "osc_24m_clk", &osc_24m_clk),
 	/* clock derived from 32 KHz osc clk */
-	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
+	CLKDEV_INIT("rtc-spear", NULL, &rtc_clk),
 	/* clock derived from 24 MHz osc clk */
-	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
-	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
-	{ .dev_id = "wdt",		.clk = &wdt_clk},
+	CLKDEV_INIT(NULL, "pll1_clk", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll3_48m_clk", &pll3_48m_clk),
+	CLKDEV_INIT("wdt", NULL, &wdt_clk),
 	/* clock derived from pll1 clk */
-	{ .con_id = "cpu_clk",		.clk = &cpu_clk},
-	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
-	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
-	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
-	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
-	{ .con_id = "gpt1_synth_clk",	.clk = &gpt1_synth_clk},
-	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
-	{ .dev_id = "uart",		.clk = &uart_clk},
-	{ .dev_id = "firda",		.clk = &firda_clk},
-	{ .dev_id = "gpt0",		.clk = &gpt0_clk},
-	{ .dev_id = "gpt1",		.clk = &gpt1_clk},
-	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
+	CLKDEV_INIT(NULL, "cpu_clk", &cpu_clk),
+	CLKDEV_INIT(NULL, "ahb_clk", &ahb_clk),
+	CLKDEV_INIT(NULL, "uart_synth_clk", &uart_synth_clk),
+	CLKDEV_INIT(NULL, "firda_synth_clk", &firda_synth_clk),
+	CLKDEV_INIT(NULL, "gpt0_synth_clk", &gpt0_synth_clk),
+	CLKDEV_INIT(NULL, "gpt1_synth_clk", &gpt1_synth_clk),
+	CLKDEV_INIT(NULL, "gpt2_synth_clk", &gpt2_synth_clk),
+	CLKDEV_INIT("uart", NULL, &uart_clk),
+	CLKDEV_INIT("firda", NULL, &firda_clk),
+	CLKDEV_INIT("gpt0", NULL, &gpt0_clk),
+	CLKDEV_INIT("gpt1", NULL, &gpt1_clk),
+	CLKDEV_INIT("gpt2", NULL, &gpt2_clk),
 	/* clock derived from pll3 clk */
-	{ .dev_id = "designware_udc",   .clk = &usbd_clk},
-	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
+	CLKDEV_INIT("designware_udc", NULL, &usbd_clk),
+	CLKDEV_INIT(NULL, "usbh_clk", &usbh_clk),
 	/* clock derived from ahb clk */
-	{ .con_id = "apb_clk",		.clk = &apb_clk},
-	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
-	{ .dev_id = "dma",		.clk = &dma_clk},
-	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
-	{ .dev_id = "gmac",		.clk = &gmac_clk},
-	{ .dev_id = "smi",		.clk = &smi_clk},
-	{ .dev_id = "c3",		.clk = &c3_clk},
+	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
+	CLKDEV_INIT("i2c_designware.0", NULL, &i2c_clk),
+	CLKDEV_INIT("dma", NULL, &dma_clk),
+	CLKDEV_INIT("jpeg", NULL, &jpeg_clk),
+	CLKDEV_INIT("gmac", NULL, &gmac_clk),
+	CLKDEV_INIT("smi", NULL, &smi_clk),
+	CLKDEV_INIT("c3", NULL, &c3_clk),
 	/* clock derived from apb clk */
-	{ .dev_id = "adc",		.clk = &adc_clk},
-	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
-	{ .dev_id = "gpio",		.clk = &gpio_clk},
+	CLKDEV_INIT("adc", NULL, &adc_clk),
+	CLKDEV_INIT("ssp-pl022.0", NULL, &ssp0_clk),
+	CLKDEV_INIT("gpio", NULL, &gpio_clk),
 };
 
 /* array of all spear 300 clock lookups */
 #ifdef CONFIG_MACH_SPEAR300
 static struct clk_lookup spear300_clk_lookups[] = {
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
-	{ .con_id = "fsmc",		.clk = &fsmc_clk},
-	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
-	{ .dev_id = "keyboard",		.clk = &kbd_clk},
-	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
+	CLKDEV_INIT("clcd", NULL, &clcd_clk),
+	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
+	CLKDEV_INIT("gpio1", NULL, &gpio1_clk),
+	CLKDEV_INIT("keyboard", NULL, &kbd_clk),
+	CLKDEV_INIT("sdhci", NULL, &sdhci_clk),
 };
 #endif
 
 /* array of all spear 310 clock lookups */
 #ifdef CONFIG_MACH_SPEAR310
 static struct clk_lookup spear310_clk_lookups[] = {
-	{ .con_id = "fsmc",		.clk = &fsmc_clk},
-	{ .con_id = "emi",		.clk = &emi_clk},
-	{ .dev_id = "uart1",		.clk = &uart1_clk},
-	{ .dev_id = "uart2",		.clk = &uart2_clk},
-	{ .dev_id = "uart3",		.clk = &uart3_clk},
-	{ .dev_id = "uart4",		.clk = &uart4_clk},
-	{ .dev_id = "uart5",		.clk = &uart5_clk},
+	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("uart1", NULL, &uart1_clk),
+	CLKDEV_INIT("uart2", NULL, &uart2_clk),
+	CLKDEV_INIT("uart3", NULL, &uart3_clk),
+	CLKDEV_INIT("uart4", NULL, &uart4_clk),
+	CLKDEV_INIT("uart5", NULL, &uart5_clk),
 };
 #endif
 
 /* array of all spear 320 clock lookups */
 #ifdef CONFIG_MACH_SPEAR320
 static struct clk_lookup spear320_clk_lookups[] = {
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
-	{ .con_id = "fsmc",		.clk = &fsmc_clk},
-	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
-	{ .con_id = "emi",		.clk = &emi_clk},
-	{ .dev_id = "pwm",		.clk = &pwm_clk},
-	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
-	{ .dev_id = "c_can_platform.0",	.clk = &can0_clk},
-	{ .dev_id = "c_can_platform.1",	.clk = &can1_clk},
-	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
-	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
-	{ .dev_id = "uart1",		.clk = &uart1_clk},
-	{ .dev_id = "uart2",		.clk = &uart2_clk},
+	CLKDEV_INIT("clcd", NULL, &clcd_clk),
+	CLKDEV_INIT("fsmc", NULL, &fsmc_clk),
+	CLKDEV_INIT("i2c_designware.1", NULL, &i2c1_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("pwm", NULL, &pwm_clk),
+	CLKDEV_INIT("sdhci", NULL, &sdhci_clk),
+	CLKDEV_INIT("c_can_platform.0", NULL, &can0_clk),
+	CLKDEV_INIT("c_can_platform.1", NULL, &can1_clk),
+	CLKDEV_INIT("ssp-pl022.1", NULL, &ssp1_clk),
+	CLKDEV_INIT("ssp-pl022.2", NULL, &ssp2_clk),
+	CLKDEV_INIT("uart1", NULL, &uart1_clk),
+	CLKDEV_INIT("uart2", NULL, &uart2_clk),
 };
 #endif
 
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index f051804..5a46980 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -623,53 +623,53 @@ static struct clk dummy_apb_pclk;
 
 /* array of all spear 6xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
-	{ .con_id = "apb_pclk",		.clk = &dummy_apb_pclk},
+	CLKDEV_INIT(NULL, "apb_pclk", &dummy_apb_pclk),
 	/* root clks */
-	{ .con_id = "osc_32k_clk",	.clk = &osc_32k_clk},
-	{ .con_id = "osc_30m_clk",	.clk = &osc_30m_clk},
+	CLKDEV_INIT(NULL, "osc_32k_clk", &osc_32k_clk),
+	CLKDEV_INIT(NULL, "osc_30m_clk", &osc_30m_clk),
 	/* clock derived from 32 KHz os		 clk */
-	{ .dev_id = "rtc-spear",	.clk = &rtc_clk},
+	CLKDEV_INIT("rtc-spear", NULL, &rtc_clk),
 	/* clock derived from 30 MHz os		 clk */
-	{ .con_id = "pll1_clk",		.clk = &pll1_clk},
-	{ .con_id = "pll3_48m_clk",	.clk = &pll3_48m_clk},
-	{ .dev_id = "wdt",		.clk = &wdt_clk},
+	CLKDEV_INIT(NULL, "pll1_clk", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll3_48m_clk", &pll3_48m_clk),
+	CLKDEV_INIT("wdt", NULL, &wdt_clk),
 	/* clock derived from pll1 clk */
-	{ .con_id = "cpu_clk",		.clk = &cpu_clk},
-	{ .con_id = "ahb_clk",		.clk = &ahb_clk},
-	{ .con_id = "uart_synth_clk",	.clk = &uart_synth_clk},
-	{ .con_id = "firda_synth_clk",	.clk = &firda_synth_clk},
-	{ .con_id = "clcd_synth_clk",	.clk = &clcd_synth_clk},
-	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
-	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
-	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
-	{ .dev_id = "d0000000.serial",	.clk = &uart0_clk},
-	{ .dev_id = "d0080000.serial",	.clk = &uart1_clk},
-	{ .dev_id = "firda",		.clk = &firda_clk},
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
-	{ .dev_id = "gpt0",		.clk = &gpt0_clk},
-	{ .dev_id = "gpt1",		.clk = &gpt1_clk},
-	{ .dev_id = "gpt2",		.clk = &gpt2_clk},
-	{ .dev_id = "gpt3",		.clk = &gpt3_clk},
+	CLKDEV_INIT(NULL, "cpu_clk", &cpu_clk),
+	CLKDEV_INIT(NULL, "ahb_clk", &ahb_clk),
+	CLKDEV_INIT(NULL, "uart_synth_clk", &uart_synth_clk),
+	CLKDEV_INIT(NULL, "firda_synth_clk", &firda_synth_clk),
+	CLKDEV_INIT(NULL, "clcd_synth_clk", &clcd_synth_clk),
+	CLKDEV_INIT(NULL, "gpt0_synth_clk", &gpt0_synth_clk),
+	CLKDEV_INIT(NULL, "gpt2_synth_clk", &gpt2_synth_clk),
+	CLKDEV_INIT(NULL, "gpt3_synth_clk", &gpt3_synth_clk),
+	CLKDEV_INIT("d0000000.serial", NULL, &uart0_clk),
+	CLKDEV_INIT("d0080000.serial", NULL, &uart1_clk),
+	CLKDEV_INIT("firda", NULL, &firda_clk),
+	CLKDEV_INIT("clcd", NULL, &clcd_clk),
+	CLKDEV_INIT("gpt0", NULL, &gpt0_clk),
+	CLKDEV_INIT("gpt1", NULL, &gpt1_clk),
+	CLKDEV_INIT("gpt2", NULL, &gpt2_clk),
+	CLKDEV_INIT("gpt3", NULL, &gpt3_clk),
 	/* clock derived from pll3 clk */
-	{ .dev_id = "designware_udc",	.clk = &usbd_clk},
-	{ .con_id = "usbh.0_clk",	.clk = &usbh0_clk},
-	{ .con_id = "usbh.1_clk",	.clk = &usbh1_clk},
+	CLKDEV_INIT("designware_udc", NULL, &usbd_clk),
+	CLKDEV_INIT(NULL, "usbh.0_clk", &usbh0_clk),
+	CLKDEV_INIT(NULL, "usbh.1_clk", &usbh1_clk),
 	/* clock derived from ahb clk */
-	{ .con_id = "apb_clk",		.clk = &apb_clk},
-	{ .dev_id = "d0200000.i2c",	.clk = &i2c_clk},
-	{ .dev_id = "dma",		.clk = &dma_clk},
-	{ .dev_id = "jpeg",		.clk = &jpeg_clk},
-	{ .dev_id = "gmac",		.clk = &gmac_clk},
-	{ .dev_id = "fc000000.flash",	.clk = &smi_clk},
-	{ .dev_id = "d1800000.flash",	.clk = &fsmc_clk},
+	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
+	CLKDEV_INIT("d0200000.i2c", NULL, &i2c_clk),
+	CLKDEV_INIT("dma", NULL, &dma_clk),
+	CLKDEV_INIT("jpeg", NULL, &jpeg_clk),
+	CLKDEV_INIT("gmac", NULL, &gmac_clk),
+	CLKDEV_INIT("fc000000.flash", NULL, &smi_clk),
+	CLKDEV_INIT("d1800000.flash", NULL, &fsmc_clk),
 	/* clock derived from apb clk */
-	{ .dev_id = "adc",		.clk = &adc_clk},
-	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
-	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
-	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
-	{ .dev_id = "f0100000.gpio",	.clk = &gpio0_clk},
-	{ .dev_id = "fc980000.gpio",	.clk = &gpio1_clk},
-	{ .dev_id = "d8100000.gpio",	.clk = &gpio2_clk},
+	CLKDEV_INIT("adc", NULL, &adc_clk),
+	CLKDEV_INIT("ssp-pl022.0", NULL, &ssp0_clk),
+	CLKDEV_INIT("ssp-pl022.1", NULL, &ssp1_clk),
+	CLKDEV_INIT("ssp-pl022.2", NULL, &ssp2_clk),
+	CLKDEV_INIT("f0100000.gpio", NULL, &gpio0_clk),
+	CLKDEV_INIT("fc980000.gpio", NULL, &gpio1_clk),
+	CLKDEV_INIT("d8100000.gpio", NULL, &gpio2_clk),
 };
 
 void __init spear6xx_clk_init(void)
-- 
1.7.10.rc2.10.gb47606
