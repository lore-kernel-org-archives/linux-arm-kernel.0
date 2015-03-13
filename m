From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Mar 2015 10:31:56 -0300
Subject: [PATCH v3 4/6] ARM: mx25: Remove "mx25.h" header file
In-Reply-To: <1426253518-3076-1-git-send-email-festevam@gmail.com>
References: <1426253518-3076-1-git-send-email-festevam@gmail.com>
Message-ID: <1426253518-3076-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As mx25 has been converted to a dt-only platform, we do not need the "mx25.h"
header file anymore.

Remove it and also clean up all the mx25 occurences from the platform helper
code.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- None

 arch/arm/mach-imx/devices/platform-fec.c          |   5 -
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   5 -
 arch/arm/mach-imx/devices/platform-imx-fb.c       |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c      |  10 --
 arch/arm/mach-imx/devices/platform-imx-keypad.c   |   5 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c      |   9 --
 arch/arm/mach-imx/devices/platform-imx-uart.c     |  12 ---
 arch/arm/mach-imx/devices/platform-imx2-wdt.c     |   5 -
 arch/arm/mach-imx/devices/platform-mx2-camera.c   |   5 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c     |   7 --
 arch/arm/mach-imx/devices/platform-mxc_nand.c     |   5 -
 arch/arm/mach-imx/devices/platform-spi_imx.c      |  11 --
 arch/arm/mach-imx/hardware.h                      |   1 -
 arch/arm/mach-imx/mx25.h                          | 117 ----------------------
 14 files changed, 202 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mx25.h

diff --git a/arch/arm/mach-imx/devices/platform-fec.c b/arch/arm/mach-imx/devices/platform-fec.c
index d86f925..b403a4f 100644
--- a/arch/arm/mach-imx/devices/platform-fec.c
+++ b/arch/arm/mach-imx/devices/platform-fec.c
@@ -19,11 +19,6 @@
 		.irq = soc ## _INT_FEC,					\
 	}
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_fec_data imx25_fec_data __initconst =
-	imx_fec_data_entry_single(MX25, "imx25-fec");
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fec_data imx27_fec_data __initconst =
 	imx_fec_data_entry_single(MX27, "imx27-fec");
diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
index 23b0061..25e1de6 100644
--- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
@@ -18,11 +18,6 @@
 		.irq = soc ## _INT_USB_OTG,				\
 	}
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
 	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index 25a47c6..7df6328 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -29,11 +29,6 @@ const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX21, "imx21-fb", SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx_fb_data imx25_imx_fb_data __initconst =
-	imx_imx_fb_data_entry_single(MX25, "imx21-fb", SZ_16K);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_fb_data imx27_imx_fb_data __initconst =
 	imx_imx_fb_data_entry_single(MX27, "imx21-fb", SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-imx-i2c.c b/arch/arm/mach-imx/devices/platform-imx-i2c.c
index 644ac26..ae97915 100644
--- a/arch/arm/mach-imx/devices/platform-imx-i2c.c
+++ b/arch/arm/mach-imx/devices/platform-imx-i2c.c
@@ -31,16 +31,6 @@ const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst =
 	imx_imx_i2c_data_entry_single(MX21, "imx21-i2c", 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst = {
-#define imx25_imx_i2c_data_entry(_id, _hwid)				\
-	imx_imx_i2c_data_entry(MX25, "imx21-i2c", _id, _hwid, SZ_16K)
-	imx25_imx_i2c_data_entry(0, 1),
-	imx25_imx_i2c_data_entry(1, 2),
-	imx25_imx_i2c_data_entry(2, 3),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst = {
 #define imx27_imx_i2c_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx-keypad.c b/arch/arm/mach-imx/devices/platform-imx-keypad.c
index f42200b..479e4d7 100644
--- a/arch/arm/mach-imx/devices/platform-imx-keypad.c
+++ b/arch/arm/mach-imx/devices/platform-imx-keypad.c
@@ -21,11 +21,6 @@ const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX21, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst =
-	imx_imx_keypad_data_entry_single(MX25, SZ_16K);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX27, SZ_16);
diff --git a/arch/arm/mach-imx/devices/platform-imx-ssi.c b/arch/arm/mach-imx/devices/platform-imx-ssi.c
index 1c7c721..6f0e94e 100644
--- a/arch/arm/mach-imx/devices/platform-imx-ssi.c
+++ b/arch/arm/mach-imx/devices/platform-imx-ssi.c
@@ -30,15 +30,6 @@ const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst = {
-#define imx25_imx_ssi_data_entry(_id, _hwid)				\
-	imx_imx_ssi_data_entry(MX25, _id, _hwid, SZ_4K)
-	imx25_imx_ssi_data_entry(0, 1),
-	imx25_imx_ssi_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst = {
 #define imx27_imx_ssi_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx-uart.c b/arch/arm/mach-imx/devices/platform-imx-uart.c
index 8c01836..6962cff 100644
--- a/arch/arm/mach-imx/devices/platform-imx-uart.c
+++ b/arch/arm/mach-imx/devices/platform-imx-uart.c
@@ -47,18 +47,6 @@ const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst = {
 };
 #endif
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst = {
-#define imx25_imx_uart_data_entry(_id, _hwid)				\
-	imx_imx_uart_1irq_data_entry(MX25, _id, _hwid, SZ_16K)
-	imx25_imx_uart_data_entry(0, 1),
-	imx25_imx_uart_data_entry(1, 2),
-	imx25_imx_uart_data_entry(2, 3),
-	imx25_imx_uart_data_entry(3, 4),
-	imx25_imx_uart_data_entry(4, 5),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst = {
 #define imx27_imx_uart_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 54f63bc..8c134c8 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -25,11 +25,6 @@ const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX21, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX25, 0, , SZ_16K);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX27, 0, , SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-mx2-camera.c b/arch/arm/mach-imx/devices/platform-mx2-camera.c
index b53e1f3..4c377c3 100644
--- a/arch/arm/mach-imx/devices/platform-mx2-camera.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-camera.c
@@ -27,11 +27,6 @@
 		.irqemmaprp = soc ## _INT_EMMAPRP,			\
 	}
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst =
-	imx_mx2_camera_data_entry_single(MX25, "imx25-camera");
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst =
 	imx_mx2_camera_data_entry_single_emma(MX27, "imx27-camera");
diff --git a/arch/arm/mach-imx/devices/platform-mxc-ehci.c b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
index 2963536..4537abd 100644
--- a/arch/arm/mach-imx/devices/platform-mxc-ehci.c
+++ b/arch/arm/mach-imx/devices/platform-mxc-ehci.c
@@ -18,13 +18,6 @@
 		.irq = soc ## _INT_USB_ ## hs,				\
 	}
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX25, 0, OTG);
-const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX25, 1, HS);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst =
 	imx_mxc_ehci_data_entry_single(MX27, 0, OTG);
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index fa618a3..676df49 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -34,11 +34,6 @@ const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX21, "imx21-nand", SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
-#ifdef CONFIG_SOC_IMX25
-const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX25, "imx25-nand", SZ_8K);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX27, "imx27-nand", SZ_4K);
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index aca825d..5e9707b 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -39,17 +39,6 @@ const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
 };
 #endif
 
-#ifdef CONFIG_SOC_IMX25
-/* i.mx25 has the i.mx35 type cspi */
-const struct imx_spi_imx_data imx25_cspi_data[] __initconst = {
-#define imx25_cspi_data_entry(_id, _hwid)				\
-	imx_spi_imx_data_entry(MX25, CSPI, "imx35-cspi", _id, _hwid, SZ_16K)
-	imx25_cspi_data_entry(0, 1),
-	imx25_cspi_data_entry(1, 2),
-	imx25_cspi_data_entry(2, 3),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
 #ifdef CONFIG_SOC_IMX27
 const struct imx_spi_imx_data imx27_cspi_data[] __initconst = {
 #define imx27_cspi_data_entry(_id, _hwid)				\
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 66b2b56..76af2c0 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -112,7 +112,6 @@
 #include "mx21.h"
 #include "mx27.h"
 #include "mx1.h"
-#include "mx25.h"
 
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
diff --git a/arch/arm/mach-imx/mx25.h b/arch/arm/mach-imx/mx25.h
deleted file mode 100644
index ec46640..0000000
--- a/arch/arm/mach-imx/mx25.h
+++ /dev/null
@@ -1,117 +0,0 @@
-#ifndef __MACH_MX25_H__
-#define __MACH_MX25_H__
-
-#define MX25_AIPS1_BASE_ADDR		0x43f00000
-#define MX25_AIPS1_SIZE			SZ_1M
-#define MX25_AIPS2_BASE_ADDR		0x53f00000
-#define MX25_AIPS2_SIZE			SZ_1M
-#define MX25_AVIC_BASE_ADDR		0x68000000
-#define MX25_AVIC_SIZE			SZ_1M
-
-#define MX25_I2C1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x80000)
-#define MX25_I2C3_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x84000)
-#define MX25_CAN1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x88000)
-#define MX25_CAN2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x8c000)
-#define MX25_I2C2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x98000)
-#define MX25_CSPI1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xa4000)
-#define MX25_IOMUXC_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xac000)
-
-#define MX25_CRM_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x80000)
-#define MX25_GPT1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x90000)
-#define MX25_GPIO4_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x9c000)
-#define MX25_PWM2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa0000)
-#define MX25_GPIO3_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa4000)
-#define MX25_PWM3_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa8000)
-#define MX25_PWM4_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xc8000)
-#define MX25_GPIO1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xcc000)
-#define MX25_GPIO2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xd0000)
-#define MX25_WDOG_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xdc000)
-#define MX25_PWM1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xe0000)
-
-#define MX25_UART1_BASE_ADDR		0x43f90000
-#define MX25_UART2_BASE_ADDR		0x43f94000
-#define MX25_AUDMUX_BASE_ADDR		0x43fb0000
-#define MX25_UART3_BASE_ADDR		0x5000c000
-#define MX25_UART4_BASE_ADDR		0x50008000
-#define MX25_UART5_BASE_ADDR		0x5002c000
-
-#define MX25_CSPI3_BASE_ADDR		0x50004000
-#define MX25_CSPI2_BASE_ADDR		0x50010000
-#define MX25_FEC_BASE_ADDR		0x50038000
-#define MX25_SSI2_BASE_ADDR		0x50014000
-#define MX25_SSI1_BASE_ADDR		0x50034000
-#define MX25_NFC_BASE_ADDR		0xbb000000
-#define MX25_IIM_BASE_ADDR		0x53ff0000
-#define MX25_DRYICE_BASE_ADDR		0x53ffc000
-#define MX25_ESDHC1_BASE_ADDR		0x53fb4000
-#define MX25_ESDHC2_BASE_ADDR		0x53fb8000
-#define MX25_LCDC_BASE_ADDR		0x53fbc000
-#define MX25_KPP_BASE_ADDR		0x43fa8000
-#define MX25_SDMA_BASE_ADDR		0x53fd4000
-#define MX25_USB_BASE_ADDR		0x53ff4000
-#define MX25_USB_OTG_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0000)
-/*
- * The reference manual (IMX25RM, Rev. 1, 06/2009) specifies an offset of 0x200
- * for the host controller.  Early documentation drafts specified 0x400 and
- * Freescale internal sources confirm only the latter value to work.
- */
-#define MX25_USB_HS_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0400)
-#define MX25_CSI_BASE_ADDR		0x53ff8000
-
-#define MX25_IO_P2V(x)			IMX_IO_P2V(x)
-#define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))
-
-/*
- * Interrupt numbers
- */
-#include <asm/irq.h>
-#define MX25_INT_CSPI3		(NR_IRQS_LEGACY + 0)
-#define MX25_INT_I2C1		(NR_IRQS_LEGACY + 3)
-#define MX25_INT_I2C2		(NR_IRQS_LEGACY + 4)
-#define MX25_INT_UART4		(NR_IRQS_LEGACY + 5)
-#define MX25_INT_ESDHC2		(NR_IRQS_LEGACY + 8)
-#define MX25_INT_ESDHC1		(NR_IRQS_LEGACY + 9)
-#define MX25_INT_I2C3		(NR_IRQS_LEGACY + 10)
-#define MX25_INT_SSI2		(NR_IRQS_LEGACY + 11)
-#define MX25_INT_SSI1		(NR_IRQS_LEGACY + 12)
-#define MX25_INT_CSPI2		(NR_IRQS_LEGACY + 13)
-#define MX25_INT_CSPI1		(NR_IRQS_LEGACY + 14)
-#define MX25_INT_GPIO3		(NR_IRQS_LEGACY + 16)
-#define MX25_INT_CSI		(NR_IRQS_LEGACY + 17)
-#define MX25_INT_UART3		(NR_IRQS_LEGACY + 18)
-#define MX25_INT_GPIO4		(NR_IRQS_LEGACY + 23)
-#define MX25_INT_KPP		(NR_IRQS_LEGACY + 24)
-#define MX25_INT_DRYICE		(NR_IRQS_LEGACY + 25)
-#define MX25_INT_PWM1		(NR_IRQS_LEGACY + 26)
-#define MX25_INT_UART2		(NR_IRQS_LEGACY + 32)
-#define MX25_INT_NFC		(NR_IRQS_LEGACY + 33)
-#define MX25_INT_SDMA		(NR_IRQS_LEGACY + 34)
-#define MX25_INT_USB_HS		(NR_IRQS_LEGACY + 35)
-#define MX25_INT_PWM2		(NR_IRQS_LEGACY + 36)
-#define MX25_INT_USB_OTG	(NR_IRQS_LEGACY + 37)
-#define MX25_INT_LCDC		(NR_IRQS_LEGACY + 39)
-#define MX25_INT_UART5		(NR_IRQS_LEGACY + 40)
-#define MX25_INT_PWM3		(NR_IRQS_LEGACY + 41)
-#define MX25_INT_PWM4		(NR_IRQS_LEGACY + 42)
-#define MX25_INT_CAN1		(NR_IRQS_LEGACY + 43)
-#define MX25_INT_CAN2		(NR_IRQS_LEGACY + 44)
-#define MX25_INT_UART1		(NR_IRQS_LEGACY + 45)
-#define MX25_INT_GPIO2		(NR_IRQS_LEGACY + 51)
-#define MX25_INT_GPIO1		(NR_IRQS_LEGACY + 52)
-#define MX25_INT_GPT1		(NR_IRQS_LEGACY + 54)
-#define MX25_INT_FEC		(NR_IRQS_LEGACY + 57)
-
-#define MX25_DMA_REQ_SSI2_RX1	22
-#define MX25_DMA_REQ_SSI2_TX1	23
-#define MX25_DMA_REQ_SSI2_RX0	24
-#define MX25_DMA_REQ_SSI2_TX0	25
-#define MX25_DMA_REQ_SSI1_RX1	26
-#define MX25_DMA_REQ_SSI1_TX1	27
-#define MX25_DMA_REQ_SSI1_RX0	28
-#define MX25_DMA_REQ_SSI1_TX0	29
-
-#ifndef __ASSEMBLY__
-extern int mx25_revision(void);
-#endif
-
-#endif /* ifndef __MACH_MX25_H__ */
-- 
1.9.1
