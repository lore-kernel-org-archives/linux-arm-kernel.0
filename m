From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 14 Jun 2010 17:39:12 +0900
Subject: [PATCH 3/6] S5PV210 added register mappings
In-Reply-To: <1276504755-24741-3-git-send-email-MyungJoo.Ham@samsung.com>
References: <1276504755-24741-1-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-2-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-3-git-send-email-MyungJoo.Ham@samsung.com>
Message-ID: <1276504755-24741-4-git-send-email-MyungJoo.Ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: MyungJoo Ham <MyungJoo.Ham@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/map.h |   45 ++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 34eb168..e1a6ff8 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -54,6 +54,9 @@
 
 #define S5PV210_PA_SROMC	(0xE8000000)
 
+/* DMA */
+#define S5PV210_PA_DMA          (0xFA200000)
+#define S5PV210_PA_PDMA         (0xE0900000)
 #define S5PV210_PA_MDMA		0xFA200000
 #define S5PV210_PA_PDMA0	0xE0900000
 #define S5PV210_PA_PDMA1	0xE0A00000
@@ -77,6 +80,25 @@
 #define S5PV210_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5PV210_PA_SDRAM
 
+#define S5PV210_PA_RTC          (0xE2800000)
+
+#define S5PV210_PA_PWR          (0xE010C000)
+#define S5P_PA_PWR              S5PV210_PA_PWR
+#define S5P_PA_INFORM0          (S5P_PA_PWR + 0x3000)
+
+/* USB HS OTG */
+#define S5PV210_PA_USB_HSOTG    (0xEC000000)
+#define S5PV210_PA_USB_HSPHY    (0xEC100000)
+
+/* FIMC */
+#define S5PV210_PA_FIMC0        (0xFB200000)
+#define S5PV210_PA_FIMC1        (0xFB300000)
+#define S5PV210_PA_FIMC2        (0xFB400000)
+
+/* MFC */
+#define S5PV210_PA_MFC          (0xF1700000)
+#define S5PV210_SZ_MFC          (0x0000FFFF)
+
 /* I2S */
 #define S5PV210_PA_IIS0		0xEEE30000
 #define S5PV210_PA_IIS1		0xE2100000
@@ -87,6 +109,17 @@
 #define S5PV210_PA_PCM1		0xE1200000
 #define S5PV210_PA_PCM2		0xE2B00000
 
+/* Audio SubSystem */
+#define S5PV210_PA_AUDSS        (0xEEE10000)
+
+/* TZPC */
+#define S5PV210_PA_TZPC0        (0xF1500000)
+#define S5PV210_PA_TZPC1        (0xFAD00000)
+#define S5PV210_PA_TZPC2        (0xE0600000)
+#define S5PV210_PA_TZPC3        (0xE1C00000)
+
+#define S5PV210_VA_TZPC(x)      (S3C_ADDR(0x01700000) + ((x) * 0x10000))
+
 /* AC97 */
 #define S5PV210_PA_AC97		0xE2200000
 
@@ -101,6 +134,18 @@
 #define S3C_PA_IIC1		S5PV210_PA_IIC1
 #define S3C_PA_IIC2		S5PV210_PA_IIC2
 #define S3C_PA_FB		S5PV210_PA_FB
+#define S3C_PA_USB_HSOTG        S5PV210_PA_USB_HSOTG
+#define S3C_PA_USB_HSPHY        S5PV210_PA_USB_HSPHY
+#define S3C_PA_RTC              S5PV210_PA_RTC
+#define S5P_PA_FIMC0            S5PV210_PA_FIMC0
+#define S5P_PA_FIMC1            S5PV210_PA_FIMC1
+#define S5P_PA_FIMC2            S5PV210_PA_FIMC2
+#define S3C_PA_DMA              S5PV210_PA_DMA
+#define S3C_PA_PDMA             S5PV210_PA_PDMA
+#define S3C_PA_IIS_V50          S5PV210_PA_IIS0
+#define S3C_PA_ADC              S5PV210_PA_ADC(0)
+#define S3C_PA_ADC0             S5PV210_PA_ADC(0)
+#define S3C_PA_ADC1             S5PV210_PA_ADC(1)
 #define S3C_PA_WDT		S5PV210_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
-- 
1.6.3.3
