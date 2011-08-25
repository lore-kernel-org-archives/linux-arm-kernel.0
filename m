From: hector.oron@gmail.com (hector.oron at gmail.com)
Date: Thu, 25 Aug 2011 13:55:49 +0100
Subject: [PATCH] ARM: mx5: fix remaining unconsistent names for irqs
In-Reply-To: <CAODfWeFeaw2+xe01c5fiSr1tYsdM8J8ahZz8t-B7uuD+-P0GCQ@mail.gmail.com>
References: <CAODfWeFeaw2+xe01c5fiSr1tYsdM8J8ahZz8t-B7uuD+-P0GCQ@mail.gmail.com>
Message-ID: <1314276949-23062-1-git-send-email-hector.oron@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
[hector: rebase on current Sascha's 'imx-features' branch]
Signed-off-by: Hector Oron <hector.oron@gmail.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c   |    2 +-
 arch/arm/mach-mx5/devices.c           |   10 +-
 arch/arm/mach-mx5/mm.c                |    8 +-
 arch/arm/plat-mxc/include/mach/mx51.h |  162 ++++++++++++++++----------------
 4 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index afecd78ce..2b9bd1f 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1573,7 +1573,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
-		MX51_MXC_INT_GPT);
+		MX51_INT_GPT);
 	return 0;
 }
 
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 371ca8c..5fd8f0c 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -23,8 +23,8 @@ static struct resource mxc_hsi2c_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = MX51_MXC_INT_HS_I2C,
-		.end = MX51_MXC_INT_HS_I2C,
+		.start = MX51_INT_HS_I2C,
+		.end = MX51_INT_HS_I2C,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -45,7 +45,7 @@ static struct resource usbotg_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = MX51_MXC_INT_USB_OTG,
+		.start = MX51_INT_USB_OTG,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -80,7 +80,7 @@ static struct resource usbh1_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = MX51_MXC_INT_USB_H1,
+		.start = MX51_INT_USB_H1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -103,7 +103,7 @@ static struct resource usbh2_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start = MX51_MXC_INT_USB_H2,
+		.start = MX51_INT_USB_H2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index baea6e5..fcc5c4c 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -141,10 +141,10 @@ static struct sdma_platform_data imx53_sdma_pdata __initdata = {
 void __init imx51_soc_init(void)
 {
 	/* i.mx51 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
+	mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_INT_GPIO1_LOW, MX51_INT_GPIO1_HIGH);
+	mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_INT_GPIO2_LOW, MX51_INT_GPIO2_HIGH);
+	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_INT_GPIO3_LOW, MX51_INT_GPIO3_HIGH);
+	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_INT_GPIO4_LOW, MX51_INT_GPIO4_HIGH);
 
 	/* i.mx51 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index dede19a..d240b6f 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -240,110 +240,110 @@
 /*
  * Interrupt numbers
  */
-#define MX51_MXC_INT_BASE		0
-#define MX51_MXC_INT_RESV0		0
+#define MX51_INT_BASE			0
+#define MX51_INT_RESV0			0
 #define MX51_INT_ESDHC1			1
 #define MX51_INT_ESDHC2			2
 #define MX51_INT_ESDHC3			3
 #define MX51_INT_ESDHC4			4
-#define MX51_MXC_INT_RESV5		5
+#define MX51_INT_RESV5			5
 #define MX51_INT_SDMA			6
-#define MX51_MXC_INT_IOMUX		7
+#define MX51_INT_IOMUX			7
 #define MX51_INT_NFC			8
-#define MX51_MXC_INT_VPU		9
+#define MX51_INT_VPU			9
 #define MX51_INT_IPU_ERR		10
 #define MX51_INT_IPU_SYN		11
-#define MX51_MXC_INT_GPU		12
-#define MX51_MXC_INT_RESV13		13
-#define MX51_MXC_INT_USB_H1		14
-#define MX51_MXC_INT_EMI		15
-#define MX51_MXC_INT_USB_H2		16
-#define MX51_MXC_INT_USB_H3		17
-#define MX51_MXC_INT_USB_OTG		18
-#define MX51_MXC_INT_SAHARA_H0		19
-#define MX51_MXC_INT_SAHARA_H1		20
-#define MX51_MXC_INT_SCC_SMN		21
-#define MX51_MXC_INT_SCC_STZ		22
-#define MX51_MXC_INT_SCC_SCM		23
-#define MX51_MXC_INT_SRTC_NTZ		24
-#define MX51_MXC_INT_SRTC_TZ		25
-#define MX51_MXC_INT_RTIC		26
-#define MX51_MXC_INT_CSU		27
-#define MX51_MXC_INT_SLIM_B		28
+#define MX51_INT_GPU			12
+#define MX51_INT_RESV13			13
+#define MX51_INT_USB_H1			14
+#define MX51_INT_EMI			15
+#define MX51_INT_USB_H2			16
+#define MX51_INT_USB_H3			17
+#define MX51_INT_USB_OTG		18
+#define MX51_INT_SAHARA_H0		19
+#define MX51_INT_SAHARA_H1		20
+#define MX51_INT_SCC_SMN		21
+#define MX51_INT_SCC_STZ		22
+#define MX51_INT_SCC_SCM		23
+#define MX51_INT_SRTC_NTZ		24
+#define MX51_INT_SRTC_TZ		25
+#define MX51_INT_RTIC			26
+#define MX51_INT_CSU			27
+#define MX51_INT_SLIM_B			28
 #define MX51_INT_SSI1			29
 #define MX51_INT_SSI2			30
 #define MX51_INT_UART1			31
 #define MX51_INT_UART2			32
 #define MX51_INT_UART3			33
-#define MX51_MXC_INT_RESV34		34
-#define MX51_MXC_INT_RESV35		35
+#define MX51_INT_RESV34			34
+#define MX51_INT_RESV35			35
 #define MX51_INT_ECSPI1			36
 #define MX51_INT_ECSPI2			37
 #define MX51_INT_CSPI			38
-#define MX51_MXC_INT_GPT		39
-#define MX51_MXC_INT_EPIT1		40
-#define MX51_MXC_INT_EPIT2		41
-#define MX51_MXC_INT_GPIO1_INT7		42
-#define MX51_MXC_INT_GPIO1_INT6		43
-#define MX51_MXC_INT_GPIO1_INT5		44
-#define MX51_MXC_INT_GPIO1_INT4		45
-#define MX51_MXC_INT_GPIO1_INT3		46
-#define MX51_MXC_INT_GPIO1_INT2		47
-#define MX51_MXC_INT_GPIO1_INT1		48
-#define MX51_MXC_INT_GPIO1_INT0		49
-#define MX51_MXC_INT_GPIO1_LOW		50
-#define MX51_MXC_INT_GPIO1_HIGH		51
-#define MX51_MXC_INT_GPIO2_LOW		52
-#define MX51_MXC_INT_GPIO2_HIGH		53
-#define MX51_MXC_INT_GPIO3_LOW		54
-#define MX51_MXC_INT_GPIO3_HIGH		55
-#define MX51_MXC_INT_GPIO4_LOW		56
-#define MX51_MXC_INT_GPIO4_HIGH		57
-#define MX51_MXC_INT_WDOG1		58
-#define MX51_MXC_INT_WDOG2		59
+#define MX51_INT_GPT			39
+#define MX51_INT_EPIT1			40
+#define MX51_INT_EPIT2			41
+#define MX51_INT_GPIO1_INT7		42
+#define MX51_INT_GPIO1_INT6		43
+#define MX51_INT_GPIO1_INT5		44
+#define MX51_INT_GPIO1_INT4		45
+#define MX51_INT_GPIO1_INT3		46
+#define MX51_INT_GPIO1_INT2		47
+#define MX51_INT_GPIO1_INT1		48
+#define MX51_INT_GPIO1_INT0		49
+#define MX51_INT_GPIO1_LOW		50
+#define MX51_INT_GPIO1_HIGH		51
+#define MX51_INT_GPIO2_LOW		52
+#define MX51_INT_GPIO2_HIGH		53
+#define MX51_INT_GPIO3_LOW		54
+#define MX51_INT_GPIO3_HIGH		55
+#define MX51_INT_GPIO4_LOW		56
+#define MX51_INT_GPIO4_HIGH		57
+#define MX51_INT_WDOG1			58
+#define MX51_INT_WDOG2			59
 #define MX51_INT_KPP			60
 #define MX51_INT_PWM1			61
 #define MX51_INT_I2C1			62
 #define MX51_INT_I2C2			63
-#define MX51_MXC_INT_HS_I2C		64
-#define MX51_MXC_INT_RESV65		65
-#define MX51_MXC_INT_RESV66		66
-#define MX51_MXC_INT_SIM_IPB		67
-#define MX51_MXC_INT_SIM_DAT		68
-#define MX51_MXC_INT_IIM		69
-#define MX51_MXC_INT_ATA		70
-#define MX51_MXC_INT_CCM1		71
-#define MX51_MXC_INT_CCM2		72
-#define MX51_MXC_INT_GPC1		73
-#define MX51_MXC_INT_GPC2		74
-#define MX51_MXC_INT_SRC		75
-#define MX51_MXC_INT_NM			76
-#define MX51_MXC_INT_PMU		77
-#define MX51_MXC_INT_CTI_IRQ		78
-#define MX51_MXC_INT_CTI1_TG0		79
-#define MX51_MXC_INT_CTI1_TG1		80
-#define MX51_MXC_INT_MCG_ERR		81
-#define MX51_MXC_INT_MCG_TMR		82
-#define MX51_MXC_INT_MCG_FUNC		83
-#define MX51_MXC_INT_GPU2_IRQ		84
-#define MX51_MXC_INT_GPU2_BUSY		85
-#define MX51_MXC_INT_RESV86		86
+#define MX51_INT_HS_I2C			64
+#define MX51_INT_RESV65			65
+#define MX51_INT_RESV66			66
+#define MX51_INT_SIM_IPB		67
+#define MX51_INT_SIM_DAT		68
+#define MX51_INT_IIM			69
+#define MX51_INT_ATA			70
+#define MX51_INT_CCM1			71
+#define MX51_INT_CCM2			72
+#define MX51_INT_GPC1				73
+#define MX51_INT_GPC2			74
+#define MX51_INT_SRC			75
+#define MX51_INT_NM			76
+#define MX51_INT_PMU			77
+#define MX51_INT_CTI_IRQ		78
+#define MX51_INT_CTI1_TG0		79
+#define MX51_INT_CTI1_TG1		80
+#define MX51_INT_MCG_ERR		81
+#define MX51_INT_MCG_TMR		82
+#define MX51_INT_MCG_FUNC		83
+#define MX51_INT_GPU2_IRQ		84
+#define MX51_INT_GPU2_BUSY		85
+#define MX51_INT_RESV86			86
 #define MX51_INT_FEC			87
-#define MX51_MXC_INT_OWIRE		88
-#define MX51_MXC_INT_CTI1_TG2		89
-#define MX51_MXC_INT_SJC		90
-#define MX51_MXC_INT_SPDIF		91
-#define MX51_MXC_INT_TVE		92
-#define MX51_MXC_INT_FIRI		93
+#define MX51_INT_OWIRE			88
+#define MX51_INT_CTI1_TG2		89
+#define MX51_INT_SJC			90
+#define MX51_INT_SPDIF			91
+#define MX51_INT_TVE			92
+#define MX51_INT_FIRI			93
 #define MX51_INT_PWM2			94
-#define MX51_MXC_INT_SLIM_EXP		95
+#define MX51_INT_SLIM_EXP		95
 #define MX51_INT_SSI3			96
-#define MX51_MXC_INT_EMI_BOOT		97
-#define MX51_MXC_INT_CTI1_TG3		98
-#define MX51_MXC_INT_SMC_RX		99
-#define MX51_MXC_INT_VPU_IDLE		100
-#define MX51_MXC_INT_EMI_NFC		101
-#define MX51_MXC_INT_GPU_IDLE		102
+#define MX51_INT_EMI_BOOT		97
+#define MX51_INT_CTI1_TG3		98
+#define MX51_INT_SMC_RX			99
+#define MX51_INT_VPU_IDLE		100
+#define MX51_INT_EMI_NFC		101
+#define MX51_INT_GPU_IDLE		102
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 extern int mx51_revision(void);
-- 
1.7.5.4
