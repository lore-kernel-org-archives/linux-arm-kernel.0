From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:20:38 +0400
Subject: [PATCH 13/20] SA1100: h3100/h3600: drop old GPIO definitions
In-Reply-To: <1256415376-22778-1-git-send-email-mad_soft@inbox.ru>
References: <1256415376-22778-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415643-22853-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all existing code was converted to gpiolib, drop no more
used pre-gpiolib (bit-shifted) GPIO definintions.
Supply new gpiolib-friendly definitions for GPIOs which
don't have them yet.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/include/mach/h3600.h      |   24 ------------------
 arch/arm/mach-sa1100/include/mach/h3600_gpio.h |   31 +++++------------------
 2 files changed, 7 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/h3600.h b/arch/arm/mach-sa1100/include/mach/h3600.h
index f4911db..e420422 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600.h
@@ -33,28 +33,4 @@
 #define H3600_BANK_2_VIRT	0xf1000000
 #define H3600_BANK_4_VIRT	0xf3800000
 
-/*
-   Machine-independent GPIO definitions
-   --- these are common across all current iPAQ platforms
-*/
-
-#define GPIO_H3600_NPOWER_BUTTON	GPIO_GPIO (0)	/* Also known as the "off button"  */
-
-#define GPIO_H3600_PCMCIA_CD1		GPIO_GPIO (10)
-#define GPIO_H3600_PCMCIA_IRQ1		GPIO_GPIO (11)
-
-/* UDA1341 L3 Interface */
-#define GPIO_H3600_L3_DATA		GPIO_GPIO (14)
-#define GPIO_H3600_L3_MODE		GPIO_GPIO (15)
-#define GPIO_H3600_L3_CLOCK		GPIO_GPIO (16)
-
-#define GPIO_H3600_PCMCIA_CD0		GPIO_GPIO (17)
-#define GPIO_H3600_SYS_CLK		GPIO_GPIO (19)
-#define GPIO_H3600_PCMCIA_IRQ0		GPIO_GPIO (21)
-
-#define GPIO_H3600_COM_DCD		GPIO_GPIO (23)
-#define GPIO_H3600_OPT_IRQ		GPIO_GPIO (24)
-#define GPIO_H3600_COM_CTS		GPIO_GPIO (25)
-#define GPIO_H3600_COM_RTS		GPIO_GPIO (26)
-
 #endif /* _INCLUDE_H3600_H_ */
diff --git a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
index 0c0bfa5..2537f35 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
@@ -30,6 +30,7 @@
 #define H3XXX_GPIO_PCMCIA_CD1		10
 #define H3XXX_GPIO_PCMCIA_IRQ1		11
 #define H3XXX_GPIO_PCMCIA_CD0		17
+#define H3XXX_GPIO_ACTION_BUTTON	18
 #define H3XXX_GPIO_SYS_CLK		19
 #define H3XXX_GPIO_PCMCIA_IRQ0		21
 #define H3XXX_GPIO_COM_DCD		23
@@ -37,23 +38,8 @@
 #define H3XXX_GPIO_COM_CTS		25
 #define H3XXX_GPIO_COM_RTS		26
 
-/*
- * GPIO lines that are common across ALL iPAQ models are in "h3600.h"
- * This file contains machine-specific definitions
- */
+/* machine-specific gpios */
 
-#define GPIO_H3600_SUSPEND              GPIO_GPIO (0)
-/* GPIO[2:9] used by LCD on H3600/3800, used as GPIO on H3100 */
-#define GPIO_H3100_BT_ON		GPIO_GPIO (2)
-#define GPIO_H3100_GPIO3		GPIO_GPIO (3)
-#define GPIO_H3100_QMUTE		GPIO_GPIO (4)
-#define GPIO_H3100_LCD_3V_ON		GPIO_GPIO (5)
-#define GPIO_H3100_AUD_ON		GPIO_GPIO (6)
-#define GPIO_H3100_AUD_PWR_ON		GPIO_GPIO (7)
-#define GPIO_H3100_IR_ON		GPIO_GPIO (8)
-#define GPIO_H3100_IR_FSEL		GPIO_GPIO (9)
-
-/* gpiolib versions of the above */
 #define H3100_GPIO_BT_ON		2
 #define H3100_GPIO_QMUTE		4
 #define H3100_GPIO_LCD_3V_ON		5
@@ -62,14 +48,11 @@
 #define H3100_GPIO_IR_ON		8
 #define H3100_GPIO_IR_FSEL		9
 
-/* for H3600, audio sample rate clock generator */
-#define GPIO_H3600_CLK_SET0		GPIO_GPIO (12)
-#define GPIO_H3600_CLK_SET1		GPIO_GPIO (13)
-
-#define GPIO_H3600_ACTION_BUTTON	GPIO_GPIO (18)
-#define GPIO_H3600_SOFT_RESET           GPIO_GPIO (20)   /* Also known as BATT_FAULT */
-#define GPIO_H3600_OPT_LOCK		GPIO_GPIO (22)
-#define GPIO_H3600_OPT_DET		GPIO_GPIO (27)
+#define H3600_GPIO_CLK_SET0		12	/* audio sample rate clock generator */
+#define H3600_GPIO_CLK_SET1		13
+#define H3600_GPIO_SOFT_RESET		20	/* also known as BATT_FAULT */
+#define H3600_GPIO_OPT_LOCK		22
+#define H3600_GPIO_OPT_DET		27
 
 
 /* H3100 / 3600 EGPIO pins */
-- 
1.6.5.1.63.ga9d7.dirty
