From: leochen@broadcom.com (Leo Chen)
Date: Fri, 9 Oct 2009 10:22:20 -0700
Subject: [PATCH] bcmring: add gpio support
Message-ID: <mailman.65.1255122797.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpio headers in include/mach

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/include/mach/gpio.h       |   22 ++++
 arch/arm/mach-bcmring/include/mach/gpio_defs.h  |  102 ++++++++++++++++++
 arch/arm/mach-bcmring/include/mach/gpio_irq.h   |   61 +++++++++++
 arch/arm/mach-bcmring/include/mach/gpio_types.h |   52 +++++++++
 arch/arm/mach-bcmring/include/mach/reg_gpio.h   |  131 +++++++++++++++++++++++
 5 files changed, 368 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-bcmring/include/mach/gpio.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/gpio_defs.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/gpio_irq.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/gpio_types.h
 create mode 100644 arch/arm/mach-bcmring/include/mach/reg_gpio.h

diff --git a/arch/arm/mach-bcmring/include/mach/gpio.h b/arch/arm/mach-bcmring/include/mach/gpio.h
new file mode 100644
index 0000000..e557b08
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/gpio.h
@@ -0,0 +1,22 @@
+/*****************************************************************************
+* Copyright 2003 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+#if !defined(ASM_ARCH_GPIO_H)
+#define ASM_ARCH_GPIO_H
+
+/* We put thre real stuff in reg_gpio.h for backwards compatability */
+
+#include <mach/reg_gpio.h>
+
+#endif /* ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-bcmring/include/mach/gpio_defs.h b/arch/arm/mach-bcmring/include/mach/gpio_defs.h
new file mode 100644
index 0000000..164cc46
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/gpio_defs.h
@@ -0,0 +1,102 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/*
+**   GPIO pin definitions
+**
+**   This file must contain only defines as it is shared between user and kernel space.
+**   As such, it is placed in the linux/broadcom/bcmring directory so it can be exposed
+**   using install-headers.  It can not be in the asm/arch directory.
+*/
+
+#ifndef GPIO_DEFS_H
+#define GPIO_DEFS_H
+
+/* ---- Include Files ----------------------------------------------------- */
+/* ---- Public Constants and Types ---------------------------------------- */
+
+/* BCMRING GPIO pins */
+typedef enum {
+	GPIO00_SCL_MTX_X0_EPHYLED_DATA = 0,
+	GPIO01_SDA_MTX_X1_EPHYLED_CLK,
+	GPIO02_UART0_DTR_B_MTX_X2_SDIO0D4_PCM1DO_I2S1DO_ETM18_VPMTDI,
+	GPIO03_UART0_DCD_B_MTX_X3_SDIO0D5_PCM1DI_I2S1DI_ETM19_VPMTDO,
+	GPIO04_UART0_RI_B_MTX_X4_SDIO0D6_PCM1CLK_I2S1BCLK_ETM20_VPMTMS,
+	GPIO05_UART0_DSR_B_MTX_X5_SDIO0D7_PCM1FS_I2S1LRCOUT_ETM21_VPMTCK,
+	GPIO06_MTX_X6_SDIO1D2_ETM22,
+	GPIO07_MTX_X7_SDIO1D3_ETM23,
+	GPIO08_MTX_X8_PCM0FS_I2S0LRCOUT,
+	GPIO09_MTX_X9_PCM0DI_I2S0DI,
+	GPIO10_MTX_X10_SDIO1CMD_ETM16,
+	GPIO11_MTX_X11_SDIO1CLK_ETM17,
+	GPIO12_UART1_CTS_B,
+	GPIO13_UART1_RTS_B,
+	GPIO14_UART1_TXD,
+	GPIO15_UART1_RXD,
+	GPIO16_MTX_Y0_MTX_SCAN_DA_ETM26,
+	GPIO17_MTX_Y1_MTX_SCAN_CLK_ETM27,
+	GPIO18_MTX_Y2_SDIO0D2_ETM28,
+	GPIO19_MTX_Y3_SDIO0D3_ETM29,
+	GPIO20_SPI_SS2_B_MTX_Y4_SDIO0SDCD_B_ETM24,
+	GPIO21_SPI_SS1_B_MTX_Y5_SDIO0WP_ETM25,
+	GPIO22_SPI_MISO,
+	GPIO23_SPI_CLK,
+	GPIO24_SPI_MOSI,
+	GPIO25_SPI_SS0_B,
+	GPIO26_I2S1MCLK,
+	GPIO27_SDIO1D0_ETM30,
+	GPIO28_SDIO1D1_ETM31,
+	GPIO29_SDIO0CMD,
+	GPIO30_SDIO0CLK,
+	GPIO31_SDIO0D0,
+	GPIO32_SDIO0D1,
+	GPIO33_PCM0CLK_I2S0BCLK,
+	GPIO34_PCM0D0_I2S0DO,
+	GPIO35_PWM_OUT,
+	GPIO36_USB0_PWRON,
+	GPIO37_USB0_PWRFLT,
+	GPIO38_SDA_V2_SPI_V2,
+	GPIO39_SCL_V2_SPI_CLK_V2,
+	GPIO40_PIF_HRDY_2_SPI_MOSI_V2,
+	GPIO41_SPI_SS2_B_V2,
+	GPIO42_PIF_HAT2,
+	GPIO43_KEY_IN0_UART0_CTS_B_I2S0LRCIN_ETMCTL,
+	GPIO44_KEY_IN1_UART0_RTS_B_I2S1LRCIN_ETMCLK_VPMRTCK,
+	GPIO45_KEY_IN2_ETM0_I2S0MCLK,
+	GPIO46_KEY_IN3_ETM1,
+	GPIO47_KEY_IN4_ETM2,
+	GPIO48_KEY_IN5_ETM3,
+	GPIO49_KEY_IN6_SSCL_ETM4,
+	GPIO50_KEY_IN7_SSDA_ETM5,
+	GPIO51_KEY_IN8_SPIS_MISO_ETM6,
+	GPIO52_KEY_OUT0_ETM7,
+	GPIO53_KEY_OUT1_ETM8,
+	GPIO54_KEY_OUT2_ETM9,
+	GPIO55_KEY_OUT3_SPIS_CLK_ETM10,
+	GPIO56_KEY_OUT4_SPIS_MOSI_ETM11,
+	GPIO57_KEY_OUT5_SPIS_SSN_ETM12_EXTPHY_MDC,
+	GPIO58_KEY_OUT6_ETM13_EXTPHY_MDIO,
+	GPIO59_KEY_OUT7_ETM14_USB1_PWRON,
+	GPIO60_KEY_OUT8_ETM15_USB1_PWRFLT,
+	gpio_defs_MAX_PINS
+} gpio_defs_e;
+
+/* Max in and out keys indexes */
+#define GPIO_MAX_INKEY_IDX  9
+#define GPIO_MAX_OUTKEY_IDX 9
+
+/* ---- Public Variables -------------------------------------------------- */
+/* ---- Public Function Prototypes ---------------------------------------- */
+
+#endif /* GPIO_DEFS_H */
diff --git a/arch/arm/mach-bcmring/include/mach/gpio_irq.h b/arch/arm/mach-bcmring/include/mach/gpio_irq.h
new file mode 100644
index 0000000..08a74f7
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/gpio_irq.h
@@ -0,0 +1,61 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/*
+*
+*****************************************************************************
+*
+*  gpio_irq.h
+*
+*  PURPOSE:
+*
+*     This file defines the architecture-independent kernel API for the GPIO
+*     IRQ driver. This allows clients to register ISR handlers that are
+*     triggered by external interrupts on GPIO lines.
+*
+*  NOTES:
+*
+*****************************************************************************/
+
+#if !defined(LINUX_GPIO_IRQ_H)
+#define LINUX_GPIO_IRQ_H
+
+#if defined(__KERNEL__)
+
+/* ---- Include Files ---------------------------------------------------- */
+
+#include <linux/interrupt.h>
+#include <mach/gpio_types.h>
+
+/* ---- Constants and Types ---------------------------------------------- */
+
+typedef void *GPIO_IRQ_DATA;
+typedef irqreturn_t(*GPIO_IRQ_HANDLER) (GPIO_IRQ_DATA);
+
+/*
+ * ---- Variable Externs -------------------------------------------------
+ * ---- Function Prototypes ----------------------------------------------
+ */
+
+int gpio_request_irq
+    (int pin,
+     GPIO_INTERRUPT_TYPE interruptType,
+     GPIO_IRQ_HANDLER irqHandler, void *devId);
+
+int gpio_free_irq(int pin);
+int gpio_enable_irq(int pin);
+int gpio_disable_irq(int pin);
+
+#endif /* __KERNEL__ */
+#endif /* LINUX_GPIO_IRQ_H */
diff --git a/arch/arm/mach-bcmring/include/mach/gpio_types.h b/arch/arm/mach-bcmring/include/mach/gpio_types.h
new file mode 100644
index 0000000..36ac064
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/gpio_types.h
@@ -0,0 +1,52 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/*
+*
+*****************************************************************************
+*
+*  gpio_types.h
+*
+*  PURPOSE:
+*
+*     This file defines generic types used by the GPIO and GPIO IRQ driver.
+*
+*  NOTES:
+*
+*****************************************************************************/
+
+#if !defined(LINUX_GPIO_TYPES_H)
+#define LINUX_GPIO_TYPES_H
+
+/*
+ * ---- Include Files ----------------------------------------------------
+ * ---- Constants and Types ----------------------------------------------
+ */
+
+typedef enum {
+	GPIO_NO_INTERRUPT = 0x00,
+	GPIO_RISING_EDGE_INTERRUPT_TRIGGER = 0x01,
+	GPIO_FALLING_EDGE_INTERRUPT_TRIGGER = 0x02,
+	GPIO_BOTH_EDGE_INTERRUPT_TRIGGER = 0x03,
+	GPIO_LOW_LEVEL_INTERRUPT_TRIGGER = 0x04,
+	GPIO_HIGH_LEVEL_INTERRUPT_TRIGGER = 0x05,
+	GPIO_MAX_INTERRUPT_TYPES
+} GPIO_INTERRUPT_TYPE;
+
+/*
+ * ---- Variable Externs -------------------------------------------------
+ * ---- Function Prototypes ----------------------------------------------
+ */
+
+#endif /* LINUX_GPIO_TYPES_H */
diff --git a/arch/arm/mach-bcmring/include/mach/reg_gpio.h b/arch/arm/mach-bcmring/include/mach/reg_gpio.h
new file mode 100644
index 0000000..05dbf4a
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/reg_gpio.h
@@ -0,0 +1,131 @@
+/*****************************************************************************
+* Copyright 2003 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/*
+*****************************************************************************
+*
+*  reg_gpio.h
+*
+*  PURPOSE:
+*
+*       This file contains an emulation layer which is used by code which
+*       can't use gpiolib (like boot-loaders and non-GPL code)
+*
+*  NOTES:
+*
+*****************************************************************************/
+
+#if !defined(ASM_ARCH_REG_GPIO_H)
+#define ASM_ARCH_REG_GPIO_H
+
+/* ---- Include Files ---------------------------------------------------- */
+
+#include <csp/gpioHw.h>
+
+#if defined(CONFIG_BCM_VC03B0) || defined(CONFIG_BCM_VCHIQ)
+#include <linux/broadcom/vc03/vc_gpio.h>
+#include <linux/broadcom/videocore_settings.h>
+
+#ifdef GPIOHW_TOTAL_NUM_PINS
+#undef GPIOHW_TOTAL_NUM_PINS
+#endif
+
+#if (defined(HW_VC03_RUN2_GPIO) && defined(HW_VC03_HAT2_GPIO))
+#define  GPIOHW_TOTAL_NUM_PINS         (VC03_1_GPIO_PIN_OFFSET + VC03_1_GPIO_NUM_PINS)
+#else
+#define  GPIOHW_TOTAL_NUM_PINS         (VC03_0_GPIO_PIN_OFFSET + VC03_0_GPIO_NUM_PINS)
+#endif
+#endif
+
+#if defined(CONFIG_ARCH_REQUIRE_GPIOLIB) && !defined(STANDALONE) && !defined(USE_BCM_GPIO)
+#define   ARCH_NR_GPIOS   GPIOHW_TOTAL_NUM_PINS
+#include <asm-generic/gpio.h>
+#define gpio_get_value(gpio)        __gpio_get_value(gpio)
+#define gpio_set_value(gpio, value)  __gpio_set_value(gpio, value)
+#define gpio_cansleep(gpio)         __gpio_cansleep(gpio)
+#else
+
+    /*
+     * The else side of this definition provides a gpiolib emulation for versions
+     * of the kernel which haven't got gpiolib ported to it yet.
+     */
+    /* These definitions occur in include/linux/broadcom/gpio.h */
+
+#endif
+
+/* ---- Constants and Types ---------------------------------------------- */
+
+/* ---- Variable Externs ------------------------------------------------- */
+
+/* ---- Function Prototypes ---------------------------------------------- */
+
+/****************************************************************************
+*
+*  Configure a GPIO pin as an input pin
+*
+*****************************************************************************/
+
+static inline int bcm_gpio_direction_input(unsigned gpio)
+{
+	GpioHw_SetDirInput(gpio);
+
+	return 0;
+
+}				/* bcm_gpio_direction_input */
+
+/****************************************************************************
+*
+*  Configure a GPIO pin as an output pin and sets its initial value.
+*
+*****************************************************************************/
+
+static inline int bcm_gpio_direction_output(unsigned gpio, int initial_value)
+{
+	GpioHw_SetValDirOutput(gpio, initial_value);
+
+	return 0;
+
+}				/* bcm_gpio_direction_output */
+
+/****************************************************************************
+*
+*  Retrieve the value of a GPIO pin. Note that this returns zero or the raw
+*   value.
+*
+*****************************************************************************/
+
+static inline int bcm_gpio_get(unsigned gpio)
+{
+	return GpioHw_GetVal(gpio);
+
+}				/* bcm_gpio_get */
+
+/****************************************************************************
+*
+*  Set the value of a GPIO pin
+*
+*****************************************************************************/
+
+static inline void bcm_gpio_set(unsigned gpio, int value)
+{
+	GpioHw_SetVal(gpio, value);
+
+}				/* bcm_gpio_set */
+
+#if defined(__KERNEL__)
+#include <linux/init.h>
+void __init brcm_init_gpio(void);
+#endif
+
+#endif /* ASM_ARCH_REG_GPIO_H */
-- 
1.6.0.6


Leo Chen
