From: richard.zhao@freescale.com (richard.zhao at freescale.com)
Date: Thu, 31 Mar 2011 18:16:23 +0800
Subject: [PATCH 1/1] ARM: imx: clean up the section marks of extern data
Message-ID: <1301566583-18947-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/devices-imx1.h  |    8 ++++----
 arch/arm/mach-imx/devices-imx21.h |   22 +++++++++++-----------
 arch/arm/mach-imx/devices-imx25.h |   35 +++++++++++++++++------------------
 arch/arm/mach-imx/devices-imx27.h |   30 +++++++++++++++---------------
 arch/arm/mach-mx3/devices-imx31.h |   24 ++++++++++++------------
 arch/arm/mach-mx3/devices-imx35.h |   29 ++++++++++++++---------------
 arch/arm/mach-mx5/devices-imx50.h |    6 +++---
 arch/arm/mach-mx5/devices-imx51.h |   23 +++++++++++------------
 arch/arm/mach-mx5/devices-imx53.h |   13 ++++++-------
 9 files changed, 93 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index da59365..3aad1e7 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -9,21 +9,21 @@
 #include <mach/mx1.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_imx_fb_data imx1_imx_fb_data __initconst;
+extern const struct imx_imx_fb_data imx1_imx_fb_data;
 #define imx1_add_imx_fb(pdata) \
     imx_add_imx_fb(&imx1_imx_fb_data, pdata)
 
-extern const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst;
+extern const struct imx_imx_i2c_data imx1_imx_i2c_data;
 #define imx1_add_imx_i2c(pdata)		\
 	imx_add_imx_i2c(&imx1_imx_i2c_data, pdata)
 
-extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[];
 #define imx1_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_3irq(&imx1_imx_uart_data[id], pdata)
 #define imx1_add_imx_uart0(pdata)	imx1_add_imx_uart(0, pdata)
 #define imx1_add_imx_uart1(pdata)	imx1_add_imx_uart(1, pdata)
 
-extern const struct imx_spi_imx_data imx1_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx1_cspi_data[];
 #define imx1_add_cspi(id, pdata)   \
 	imx_add_spi_imx(&imx1_cspi_data[id], pdata)
 
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 16744d2..2628e0c 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -9,31 +9,31 @@
 #include <mach/mx21.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data __initconst;
+extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data;
 #define imx21_add_imx21_hcd(pdata)	\
 	imx_add_imx21_hcd(&imx21_imx21_hcd_data, pdata)
 
-extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst;
+extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data;
 #define imx21_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
 
-extern const struct imx_imx_fb_data imx21_imx_fb_data __initconst;
+extern const struct imx_imx_fb_data imx21_imx_fb_data;
 #define imx21_add_imx_fb(pdata)	\
 	imx_add_imx_fb(&imx21_imx_fb_data, pdata)
 
-extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
+extern const struct imx_imx_i2c_data imx21_imx_i2c_data;
 #define imx21_add_imx_i2c(pdata)	\
 	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
 
-extern const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx21_imx_keypad_data;
 #define imx21_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx21_imx_keypad_data, pdata)
 
-extern const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx21_imx_ssi_data[];
 #define imx21_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx21_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[];
 #define imx21_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx21_imx_uart_data[id], pdata)
 #define imx21_add_imx_uart0(pdata)	imx21_add_imx_uart(0, pdata)
@@ -41,19 +41,19 @@ extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
 #define imx21_add_imx_uart2(pdata)	imx21_add_imx_uart(2, pdata)
 #define imx21_add_imx_uart3(pdata)	imx21_add_imx_uart(3, pdata)
 
-extern const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst;
+extern const struct imx_mxc_mmc_data imx21_mxc_mmc_data[];
 #define imx21_add_mxc_mmc(id, pdata)	\
 	imx_add_mxc_mmc(&imx21_mxc_mmc_data[id], pdata)
 
-extern const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx21_mxc_nand_data;
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
 
-extern const struct imx_mxc_w1_data imx21_mxc_w1_data __initconst;
+extern const struct imx_mxc_w1_data imx21_mxc_w1_data;
 #define imx21_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx21_mxc_w1_data)
 
-extern const struct imx_spi_imx_data imx21_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx21_cspi_data[];
 #define imx21_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx21_cspi_data[id], pdata)
 #define imx21_add_spi_imx0(pdata)	imx21_add_cspi(0, pdata)
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index b591d72..efa0761 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -9,48 +9,48 @@
 #include <mach/mx25.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fec_data imx25_fec_data __initconst;
+extern const struct imx_fec_data imx25_fec_data;
 #define imx25_add_fec(pdata)	\
 	imx_add_fec(&imx25_fec_data, pdata)
 
-extern const struct imx_flexcan_data imx25_flexcan_data[] __initconst;
+extern const struct imx_flexcan_data imx25_flexcan_data[];
 #define imx25_add_flexcan(id, pdata)	\
 	imx_add_flexcan(&imx25_flexcan_data[id], pdata)
 #define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
 #define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
 
-extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst;
+extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data;
 #define imx25_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
 
-extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
+extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data;
 #define imx25_add_imxdi_rtc(pdata)	\
 	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
 
-extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst;
+extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data;
 #define imx25_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx25_imx2_wdt_data)
 
-extern const struct imx_imx_fb_data imx25_imx_fb_data __initconst;
+extern const struct imx_imx_fb_data imx25_imx_fb_data;
 #define imx25_add_imx_fb(pdata)	\
 	imx_add_imx_fb(&imx25_imx_fb_data, pdata)
 
-extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx25_imx_i2c_data[];
 #define imx25_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
 #define imx25_add_imx_i2c0(pdata)	imx25_add_imx_i2c(0, pdata)
 #define imx25_add_imx_i2c1(pdata)	imx25_add_imx_i2c(1, pdata)
 #define imx25_add_imx_i2c2(pdata)	imx25_add_imx_i2c(2, pdata)
 
-extern const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx25_imx_keypad_data;
 #define imx25_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx25_imx_keypad_data, pdata)
 
-extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx25_imx_ssi_data[];
 #define imx25_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx25_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[];
 #define imx25_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx25_imx_uart_data[id], pdata)
 #define imx25_add_imx_uart0(pdata)	imx25_add_imx_uart(0, pdata)
@@ -59,33 +59,32 @@ extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
 #define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
 #define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
 
-extern const struct imx_mx2_camera_data imx25_mx2_camera_data __initconst;
+extern const struct imx_mx2_camera_data imx25_mx2_camera_data;
 #define imx25_add_mx2_camera(pdata)	\
 	imx_add_mx2_camera(&imx25_mx2_camera_data, pdata)
 
-extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst;
+extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data;
 #define imx25_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx25_mxc_ehci_otg_data, pdata)
-extern const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst;
+extern const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data;
 #define imx25_add_mxc_ehci_hs(pdata)	\
 	imx_add_mxc_ehci(&imx25_mxc_ehci_hs_data, pdata)
 
-extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx25_mxc_nand_data;
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
 
-extern const struct imx_sdhci_esdhc_imx_data
-imx25_sdhci_esdhc_imx_data[] __initconst;
+extern const struct imx_sdhci_esdhc_imx_data imx25_sdhci_esdhc_imx_data[];
 #define imx25_add_sdhci_esdhc_imx(id, pdata)	\
 	imx_add_sdhci_esdhc_imx(&imx25_sdhci_esdhc_imx_data[id], pdata)
 
-extern const struct imx_spi_imx_data imx25_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx25_cspi_data[];
 #define imx25_add_spi_imx(id, pdata)	\
 	imx_add_spi_imx(&imx25_cspi_data[id], pdata)
 #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
 
-extern struct imx_mxc_pwm_data imx25_mxc_pwm_data[] __initconst;
+extern struct imx_mxc_pwm_data imx25_mxc_pwm_data[];
 #define imx25_add_mxc_pwm(id)	\
 	imx_add_mxc_pwm(&imx25_mxc_pwm_data[id])
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index f1272d4..7f97a3c 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -9,35 +9,35 @@
 #include <mach/mx27.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fec_data imx27_fec_data __initconst;
+extern const struct imx_fec_data imx27_fec_data;
 #define imx27_add_fec(pdata)	\
 	imx_add_fec(&imx27_fec_data, pdata)
 
-extern const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst;
+extern const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data;
 #define imx27_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx27_fsl_usb2_udc_data, pdata)
 
-extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst;
+extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data;
 #define imx27_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx27_imx2_wdt_data)
 
-extern const struct imx_imx_fb_data imx27_imx_fb_data __initconst;
+extern const struct imx_imx_fb_data imx27_imx_fb_data;
 #define imx27_add_imx_fb(pdata)	\
 	imx_add_imx_fb(&imx27_imx_fb_data, pdata)
 
-extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx27_imx_i2c_data[];
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
 
-extern const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx27_imx_keypad_data;
 #define imx27_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx27_imx_keypad_data, pdata)
 
-extern const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx27_imx_ssi_data[];
 #define imx27_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx27_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[];
 #define imx27_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx27_imx_uart_data[id], pdata)
 #define imx27_add_imx_uart0(pdata)	imx27_add_imx_uart(0, pdata)
@@ -47,30 +47,30 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
 #define imx27_add_imx_uart4(pdata)	imx27_add_imx_uart(4, pdata)
 #define imx27_add_imx_uart5(pdata)	imx27_add_imx_uart(5, pdata)
 
-extern const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst;
+extern const struct imx_mx2_camera_data imx27_mx2_camera_data;
 #define imx27_add_mx2_camera(pdata)	\
 	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
 
-extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst;
+extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data;
 #define imx27_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx27_mxc_ehci_otg_data, pdata)
-extern const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[] __initconst;
+extern const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[];
 #define imx27_add_mxc_ehci_hs(id, pdata)	\
 	imx_add_mxc_ehci(&imx27_mxc_ehci_hs_data[id - 1], pdata)
 
-extern const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst;
+extern const struct imx_mxc_mmc_data imx27_mxc_mmc_data[];
 #define imx27_add_mxc_mmc(id, pdata)	\
 	imx_add_mxc_mmc(&imx27_mxc_mmc_data[id], pdata)
 
-extern const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx27_mxc_nand_data;
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
 
-extern const struct imx_mxc_w1_data imx27_mxc_w1_data __initconst;
+extern const struct imx_mxc_w1_data imx27_mxc_w1_data;
 #define imx27_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx27_mxc_w1_data)
 
-extern const struct imx_spi_imx_data imx27_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx27_cspi_data[];
 #define imx27_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx27_cspi_data[id], pdata)
 #define imx27_add_spi_imx0(pdata)	imx27_add_cspi(0, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 40f4e84..cf621d2 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -9,30 +9,30 @@
 #include <mach/mx31.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst;
+extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data;
 #define imx31_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx31_fsl_usb2_udc_data, pdata)
 
-extern const struct imx_imx2_wdt_data imx31_imx2_wdt_data __initconst;
+extern const struct imx_imx2_wdt_data imx31_imx2_wdt_data;
 #define imx31_add_imx2_wdt(pdata)       \
 	imx_add_imx2_wdt(&imx31_imx2_wdt_data)
 
-extern const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx31_imx_i2c_data[];
 #define imx31_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx31_imx_i2c_data[id], pdata)
 #define imx31_add_imx_i2c0(pdata)	imx31_add_imx_i2c(0, pdata)
 #define imx31_add_imx_i2c1(pdata)	imx31_add_imx_i2c(1, pdata)
 #define imx31_add_imx_i2c2(pdata)	imx31_add_imx_i2c(2, pdata)
 
-extern const struct imx_imx_keypad_data imx31_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx31_imx_keypad_data;
 #define imx31_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx31_imx_keypad_data, pdata)
 
-extern const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx31_imx_ssi_data[];
 #define imx31_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx31_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[];
 #define imx31_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx31_imx_uart_data[id], pdata)
 #define imx31_add_imx_uart0(pdata)	imx31_add_imx_uart(0, pdata)
@@ -41,26 +41,26 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
-extern const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data __initconst;
+extern const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data;
 #define imx31_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx31_mxc_ehci_otg_data, pdata)
-extern const struct imx_mxc_ehci_data imx31_mxc_ehci_hs_data[] __initconst;
+extern const struct imx_mxc_ehci_data imx31_mxc_ehci_hs_data[];
 #define imx31_add_mxc_ehci_hs(id, pdata)	\
 	imx_add_mxc_ehci(&imx31_mxc_ehci_hs_data[id - 1], pdata)
 
-extern const struct imx_mxc_mmc_data imx31_mxc_mmc_data[] __initconst;
+extern const struct imx_mxc_mmc_data imx31_mxc_mmc_data[];
 #define imx31_add_mxc_mmc(id, pdata)	\
 	imx_add_mxc_mmc(&imx31_mxc_mmc_data[id], pdata)
 
-extern const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx31_mxc_nand_data;
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
 
-extern const struct imx_mxc_w1_data imx31_mxc_w1_data __initconst;
+extern const struct imx_mxc_w1_data imx31_mxc_w1_data;
 #define imx31_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx31_mxc_w1_data)
 
-extern const struct imx_spi_imx_data imx31_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx31_cspi_data[];
 #define imx31_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx31_cspi_data[id], pdata)
 #define imx31_add_spi_imx0(pdata)	imx31_add_cspi(0, pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index d545d86..3582665 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -9,67 +9,66 @@
 #include <mach/mx35.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fec_data imx35_fec_data __initconst;
+extern const struct imx_fec_data imx35_fec_data;
 #define imx35_add_fec(pdata)	\
 	imx_add_fec(&imx35_fec_data, pdata)
 
-extern const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst;
+extern const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data;
 #define imx35_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx35_fsl_usb2_udc_data, pdata)
 
-extern const struct imx_flexcan_data imx35_flexcan_data[] __initconst;
+extern const struct imx_flexcan_data imx35_flexcan_data[];
 #define imx35_add_flexcan(id, pdata)	\
 	imx_add_flexcan(&imx35_flexcan_data[id], pdata)
 #define imx35_add_flexcan0(pdata)	imx35_add_flexcan(0, pdata)
 #define imx35_add_flexcan1(pdata)	imx35_add_flexcan(1, pdata)
 
-extern const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst;
+extern const struct imx_imx2_wdt_data imx35_imx2_wdt_data;
 #define imx35_add_imx2_wdt(pdata)       \
 	imx_add_imx2_wdt(&imx35_imx2_wdt_data)
 
-extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx35_imx_i2c_data[];
 #define imx35_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx35_imx_i2c_data[id], pdata)
 #define imx35_add_imx_i2c0(pdata)	imx35_add_imx_i2c(0, pdata)
 #define imx35_add_imx_i2c1(pdata)	imx35_add_imx_i2c(1, pdata)
 #define imx35_add_imx_i2c2(pdata)	imx35_add_imx_i2c(2, pdata)
 
-extern const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx35_imx_keypad_data;
 #define imx35_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx35_imx_keypad_data, pdata)
 
-extern const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx35_imx_ssi_data[];
 #define imx35_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx35_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[];
 #define imx35_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx35_imx_uart_data[id], pdata)
 #define imx35_add_imx_uart0(pdata)	imx35_add_imx_uart(0, pdata)
 #define imx35_add_imx_uart1(pdata)	imx35_add_imx_uart(1, pdata)
 #define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
 
-extern const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data __initconst;
+extern const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data;
 #define imx35_add_mxc_ehci_otg(pdata)	\
 	imx_add_mxc_ehci(&imx35_mxc_ehci_otg_data, pdata)
-extern const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data __initconst;
+extern const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data;
 #define imx35_add_mxc_ehci_hs(pdata)	\
 	imx_add_mxc_ehci(&imx35_mxc_ehci_hs_data, pdata)
 
-extern const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx35_mxc_nand_data;
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
 
-extern const struct imx_mxc_w1_data imx35_mxc_w1_data __initconst;
+extern const struct imx_mxc_w1_data imx35_mxc_w1_data;
 #define imx35_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx35_mxc_w1_data)
 
-extern const struct imx_sdhci_esdhc_imx_data
-imx35_sdhci_esdhc_imx_data[] __initconst;
+extern const struct imx_sdhci_esdhc_imx_data imx35_sdhci_esdhc_imx_data[];
 #define imx35_add_sdhci_esdhc_imx(id, pdata)	\
 	imx_add_sdhci_esdhc_imx(&imx35_sdhci_esdhc_imx_data[id], pdata)
 
-extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx35_cspi_data[];
 #define imx35_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx50.h b/arch/arm/mach-mx5/devices-imx50.h
index c9e4282..7216667 100644
--- a/arch/arm/mach-mx5/devices-imx50.h
+++ b/arch/arm/mach-mx5/devices-imx50.h
@@ -21,14 +21,14 @@
 #include <mach/mx50.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[];
 #define imx50_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx50_imx_uart_data[id], pdata)
 
-extern const struct imx_fec_data imx50_fec_data __initconst;
+extern const struct imx_fec_data imx50_fec_data;
 #define imx50_add_fec(pdata)	\
 	imx_add_fec(&imx50_fec_data, pdata)
 
-extern const struct imx_imx_i2c_data imx50_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx50_imx_i2c_data[];
 #define imx50_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx50_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 7fff485..e3253c5 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -9,49 +9,48 @@
 #include <mach/mx51.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fec_data imx51_fec_data __initconst;
+extern const struct imx_fec_data imx51_fec_data;
 #define imx51_add_fec(pdata)	\
 	imx_add_fec(&imx51_fec_data, pdata)
 
 #define imx51_add_gpio_keys(pdata) imx_add_gpio_keys(pdata)
 
-extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx51_imx_i2c_data[];
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
 
-extern const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst;
+extern const struct imx_imx_ssi_data imx51_imx_ssi_data[];
 #define imx51_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx51_imx_ssi_data[id], pdata)
 
-extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx51_imx_uart_data[];
 #define imx51_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx51_imx_uart_data[id], pdata)
 
-extern const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst;
+extern const struct imx_mxc_nand_data imx51_mxc_nand_data;
 #define imx51_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx51_mxc_nand_data, pdata)
 
-extern const struct imx_sdhci_esdhc_imx_data
-imx51_sdhci_esdhc_imx_data[] __initconst;
+extern const struct imx_sdhci_esdhc_imx_data imx51_sdhci_esdhc_imx_data[];
 #define imx51_add_sdhci_esdhc_imx(id, pdata)	\
 	imx_add_sdhci_esdhc_imx(&imx51_sdhci_esdhc_imx_data[id], pdata)
 
-extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
+extern const struct imx_spi_imx_data imx51_cspi_data;
 #define imx51_add_cspi(pdata)	\
 	imx_add_spi_imx(&imx51_cspi_data, pdata)
 
-extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx51_ecspi_data[];
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
 
-extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data[] __initconst;
+extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data[];
 #define imx51_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx51_imx2_wdt_data[id])
 
-extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst;
+extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[];
 #define imx51_add_mxc_pwm(id)	\
 	imx_add_mxc_pwm(&imx51_mxc_pwm_data[id])
 
-extern const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst;
+extern const struct imx_imx_keypad_data imx51_imx_keypad_data;
 #define imx51_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 9251008..48f4c8c 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -8,28 +8,27 @@
 #include <mach/mx53.h>
 #include <mach/devices-common.h>
 
-extern const struct imx_fec_data imx53_fec_data __initconst;
+extern const struct imx_fec_data imx53_fec_data;
 #define imx53_add_fec(pdata)   \
 	imx_add_fec(&imx53_fec_data, pdata)
 
-extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst;
+extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[];
 #define imx53_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx53_imx_uart_data[id], pdata)
 
 
-extern const struct imx_imx_i2c_data imx53_imx_i2c_data[] __initconst;
+extern const struct imx_imx_i2c_data imx53_imx_i2c_data[];
 #define imx53_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx53_imx_i2c_data[id], pdata)
 
-extern const struct imx_sdhci_esdhc_imx_data
-imx53_sdhci_esdhc_imx_data[] __initconst;
+extern const struct imx_sdhci_esdhc_imx_data imx53_sdhci_esdhc_imx_data[];
 #define imx53_add_sdhci_esdhc_imx(id, pdata)	\
 	imx_add_sdhci_esdhc_imx(&imx53_sdhci_esdhc_imx_data[id], pdata)
 
-extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
+extern const struct imx_spi_imx_data imx53_ecspi_data[];
 #define imx53_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
 
-extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
+extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[];
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
-- 
1.7.1
