From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 6 Apr 2011 21:29:24 +0400
Subject: [PATCH 3/3] DA8xx: move base address #define's to their proper place
Message-ID: <201104062129.25085.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move DA8XX_MMCSD0_BASE, DA8XX_LCD_CNTRL_BASE,  and DA8XX_DDR2_CTL_BASE from
<mach/da8xx.h> to devices-da8xx.c as the latter file is the only place where
these macros are used.

While at it, restore sorting the base address macros by address value in
devices-da8xx.c...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree plus the fix that I've posted
earlier today.

 arch/arm/mach-davinci/devices-da8xx.c      |   15 +++++++++------
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 ---
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/devices-da8xx.c
+++ linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
@@ -24,22 +24,25 @@
 #include "clock.h"
 
 #define DA8XX_TPCC_BASE			0x01c00000
-#define DA850_MMCSD1_BASE		0x01e1b000
-#define DA850_TPCC1_BASE		0x01e30000
 #define DA8XX_TPTC0_BASE		0x01c08000
 #define DA8XX_TPTC1_BASE		0x01c08400
-#define DA850_TPTC2_BASE		0x01e38000
 #define DA8XX_WDOG_BASE			0x01c21000 /* DA8XX_TIMER64P1_BASE */
 #define DA8XX_I2C0_BASE			0x01c22000
-#define DA8XX_RTC_BASE			0x01C23000
+#define DA8XX_RTC_BASE			0x01c23000
+#define DA8XX_MMCSD0_BASE		0x01c40000
+#define DA8XX_SPI0_BASE			0x01c41000
+#define DA830_SPI1_BASE			0x01e12000
+#define DA8XX_LCD_CNTRL_BASE		0x01e13000
+#define DA850_MMCSD1_BASE		0x01e1b000
 #define DA8XX_EMAC_CPPI_PORT_BASE	0x01e20000
 #define DA8XX_EMAC_CPGMACSS_BASE	0x01e22000
 #define DA8XX_EMAC_CPGMAC_BASE		0x01e23000
 #define DA8XX_EMAC_MDIO_BASE		0x01e24000
 #define DA8XX_I2C1_BASE			0x01e28000
-#define DA8XX_SPI0_BASE			0x01c41000
-#define DA830_SPI1_BASE			0x01e12000
+#define DA850_TPCC1_BASE		0x01e30000
+#define DA850_TPTC2_BASE		0x01e38000
 #define DA850_SPI1_BASE			0x01f0e000
+#define DA8XX_DDR2_CTL_BASE		0xb0000000
 
 #define DA8XX_EMAC_CTRL_REG_OFFSET	0x3000
 #define DA8XX_EMAC_MOD_REG_OFFSET	0x2000
Index: linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/include/mach/da8xx.h
+++ linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -64,12 +64,9 @@ extern unsigned int da850_max_speed;
 #define DA8XX_TIMER64P1_BASE	0x01c21000
 #define DA8XX_GPIO_BASE		0x01e26000
 #define DA8XX_PSC1_BASE		0x01e27000
-#define DA8XX_LCD_CNTRL_BASE	0x01e13000
-#define DA8XX_MMCSD0_BASE	0x01c40000
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
-#define DA8XX_DDR2_CTL_BASE	0xb0000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void __init da830_init(void);
