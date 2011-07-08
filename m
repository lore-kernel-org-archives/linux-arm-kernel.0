From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri,  8 Jul 2011 09:22:14 +0200
Subject: [BUGFIX][PATCH] iomux-mx53: add missing 'IOMUX_CONFIG_SION' for some
	I2C pad definitions
Message-ID: <1310109734-4329-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C controller requires the SION bit to be set on SDA and SCL pins.
This is missing on some pad definitions for the I2C function.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 50b88a4..525368d 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -465,19 +465,19 @@
 #define _MX53_PAD_EIM_D16__IPU_DI0_PIN5		IOMUX_PAD(0x460, 0x118, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D16__IPU_DISPB1_SER_CLK	IOMUX_PAD(0x460, 0x118, 3, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D16__ECSPI1_SCLK		IOMUX_PAD(0x460, 0x118, 4, 0x79C, 3, 0)
-#define _MX53_PAD_EIM_D16__I2C2_SDA			IOMUX_PAD(0x460, 0x118, 5, 0x820, 1, 0)
+#define _MX53_PAD_EIM_D16__I2C2_SDA			IOMUX_PAD(0x460, 0x118, 5 | IOMUX_CONFIG_SION, 0x820, 1, 0)
 #define _MX53_PAD_EIM_D17__EMI_WEIM_D_17		IOMUX_PAD(0x464, 0x11C, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D17__GPIO3_17			IOMUX_PAD(0x464, 0x11C, 1, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D17__IPU_DI0_PIN6		IOMUX_PAD(0x464, 0x11C, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D17__IPU_DISPB1_SER_DIN	IOMUX_PAD(0x464, 0x11C, 3, 0x830, 0, 0)
 #define _MX53_PAD_EIM_D17__ECSPI1_MISO		IOMUX_PAD(0x464, 0x11C, 4, 0x7A0, 3, 0)
-#define _MX53_PAD_EIM_D17__I2C3_SCL			IOMUX_PAD(0x464, 0x11C, 5, 0x824, 0, 0)
+#define _MX53_PAD_EIM_D17__I2C3_SCL			IOMUX_PAD(0x464, 0x11C, 5 | IOMUX_CONFIG_SION, 0x824, 0, 0)
 #define _MX53_PAD_EIM_D18__EMI_WEIM_D_18		IOMUX_PAD(0x468, 0x120, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D18__GPIO3_18			IOMUX_PAD(0x468, 0x120, 1, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D18__IPU_DI0_PIN7		IOMUX_PAD(0x468, 0x120, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D18__IPU_DISPB1_SER_DIO	IOMUX_PAD(0x468, 0x120, 3, 0x830, 1, 0)
 #define _MX53_PAD_EIM_D18__ECSPI1_MOSI		IOMUX_PAD(0x468, 0x120, 4, 0x7A4, 3, 0)
-#define _MX53_PAD_EIM_D18__I2C3_SDA			IOMUX_PAD(0x468, 0x120, 5, 0x828, 0, 0)
+#define _MX53_PAD_EIM_D18__I2C3_SDA			IOMUX_PAD(0x468, 0x120, 5 | IOMUX_CONFIG_SION, 0x828, 0, 0)
 #define _MX53_PAD_EIM_D18__IPU_DI1_D0_CS		IOMUX_PAD(0x468, 0x120, 6, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D19__EMI_WEIM_D_19		IOMUX_PAD(0x46C, 0x124, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D19__GPIO3_19			IOMUX_PAD(0x46C, 0x124, 1, 0x0, 0, 0)
@@ -500,7 +500,7 @@
 #define _MX53_PAD_EIM_D21__IPU_DI0_PIN17		IOMUX_PAD(0x474, 0x12C, 2, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D21__IPU_DISPB0_SER_CLK	IOMUX_PAD(0x474, 0x12C, 3, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D21__CSPI_SCLK			IOMUX_PAD(0x474, 0x12C, 4, 0x780, 1, 0)
-#define _MX53_PAD_EIM_D21__I2C1_SCL			IOMUX_PAD(0x474, 0x12C, 5, 0x814, 1, 0)
+#define _MX53_PAD_EIM_D21__I2C1_SCL			IOMUX_PAD(0x474, 0x12C, 5 | IOMUX_CONFIG_SION, 0x814, 1, 0)
 #define _MX53_PAD_EIM_D21__USBOH3_USBOTG_OC	IOMUX_PAD(0x474, 0x12C, 6, 0x89C, 1, 0)
 #define _MX53_PAD_EIM_D22__EMI_WEIM_D_22		IOMUX_PAD(0x478, 0x130, 0, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D22__GPIO3_22			IOMUX_PAD(0x478, 0x130, 1, 0x0, 0, 0)
@@ -560,7 +560,7 @@
 #define _MX53_PAD_EIM_D28__UART2_CTS			IOMUX_PAD(0x494, 0x14C, 2, 0x87C, 0, 0)
 #define _MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO	IOMUX_PAD(0x494, 0x14C, 3, 0x82C, 1, 0)
 #define _MX53_PAD_EIM_D28__CSPI_MOSI			IOMUX_PAD(0x494, 0x14C, 4, 0x788, 1, 0)
-#define _MX53_PAD_EIM_D28__I2C1_SDA			IOMUX_PAD(0x494, 0x14C, 5, 0x818, 1, 0)
+#define _MX53_PAD_EIM_D28__I2C1_SDA			IOMUX_PAD(0x494, 0x14C, 5 | IOMUX_CONFIG_SION, 0x818, 1, 0)
 #define _MX53_PAD_EIM_D28__IPU_EXT_TRIG		IOMUX_PAD(0x494, 0x14C, 6, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D28__IPU_DI0_PIN13		IOMUX_PAD(0x494, 0x14C, 7, 0x0, 0, 0)
 #define _MX53_PAD_EIM_D29__EMI_WEIM_D_29		IOMUX_PAD(0x498, 0x150, 0, 0x0, 0, 0)
@@ -1161,7 +1161,7 @@
 #define _MX53_PAD_GPIO_5__CCM_CLKO		IOMUX_PAD(0x6C0, 0x330, 3, 0x0, 0, 0)
 #define _MX53_PAD_GPIO_5__CSU_CSU_ALARM_AUT_2	IOMUX_PAD(0x6C0, 0x330, 4, 0x0, 0, 0)
 #define _MX53_PAD_GPIO_5__OBSERVE_MUX_OBSRV_INT_OUT4	IOMUX_PAD(0x6C0, 0x330, 5, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_5__I2C3_SCL		IOMUX_PAD(0x6C0, 0x330, 6, 0x824, 2, 0)
+#define _MX53_PAD_GPIO_5__I2C3_SCL		IOMUX_PAD(0x6C0, 0x330, 6 | IOMUX_CONFIG_SION, 0x824, 2, 0)
 #define _MX53_PAD_GPIO_5__CCM_PLL1_BYP	IOMUX_PAD(0x6C0, 0x330, 7, 0x770, 1, 0)
 #define _MX53_PAD_GPIO_7__ESAI1_TX4_RX1	IOMUX_PAD(0x6C4, 0x334, 0, 0x7F4, 1, 0)
 #define _MX53_PAD_GPIO_7__GPIO1_7		IOMUX_PAD(0x6C4, 0x334, 1, 0x0, 0, 0)
-- 
1.5.6.5
