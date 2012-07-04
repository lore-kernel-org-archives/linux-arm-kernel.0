From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 4 Jul 2012 16:35:54 +0200 (CEST)
Subject: [PATCH 1 of 3] ARM: imx: remove unused pdata from device macros
In-Reply-To: <20120704065501.GF2698@pengutronix.de>
Message-ID: <541877457.702896.1341412554714.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many imx device macros have a meaningless pdata. This patch removes those.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/devices-imx21.h              |    4 ++--
 .../arch/arm/mach-imx/devices-imx25.h              |    4 ++--
 .../arch/arm/mach-imx/devices-imx27.h              |    6 +++---
 .../arch/arm/mach-imx/devices-imx31.h              |    6 +++---
 .../arch/arm/mach-imx/devices-imx35.h              |    4 ++--
 .../arch/arm/mach-imx/devices-imx51.h              |    2 +-
 .../arch/arm/mach-imx/devices-imx53.h              |    2 +-
 .../arch/arm/mach-imx/mach-cpuimx27.c              |    4 ++--
 .../arch/arm/mach-imx/mach-cpuimx35.c              |    2 +-
 .../arch/arm/mach-imx/mach-cpuimx51sd.c            |    2 +-
 .../arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    4 ++--
 .../arch/arm/mach-imx/mach-imx27ipcam.c            |    2 +-
 .../arch/arm/mach-imx/mach-mx25_3ds.c              |    4 ++--
 .../arch/arm/mach-imx/mach-mx27_3ds.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx27ads.c               |    2 +-
 .../arch/arm/mach-imx/mach-mx31_3ds.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx31moboard.c           |    2 +-
 .../arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx51_3ds.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx51_babbage.c          |    2 +-
 .../arch/arm/mach-imx/mach-mx53_ard.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx53_evk.c              |    2 +-
 .../arch/arm/mach-imx/mach-mx53_loco.c             |    2 +-
 .../arch/arm/mach-imx/mach-mx53_smd.c              |    2 +-
 .../arch/arm/mach-imx/mach-pca100.c                |    4 ++--
 .../arch/arm/mach-imx/mach-pcm037.c                |    4 ++--
 .../arch/arm/mach-imx/mach-pcm038.c                |    4 ++--
 .../arch/arm/mach-imx/mach-pcm043.c                |    2 +-
 .../arch/arm/mach-imx/mach-qong.c                  |    2 +-
 .../arch/arm/mach-imx/mach-vpr200.c                |    2 +-
 .../arch/arm/mach-imx/mx31lite-db.c                |    4 ++--
 31 files changed, 45 insertions(+), 45 deletions(-)

diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx21.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx21.h
index 2628e0c..93ece55 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx21.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx21.h
@@ -14,7 +14,7 @@ extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data;
 	imx_add_imx21_hcd(&imx21_imx21_hcd_data, pdata)
 
 extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data;
-#define imx21_add_imx2_wdt(pdata)	\
+#define imx21_add_imx2_wdt()	\
 	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
 
 extern const struct imx_imx_fb_data imx21_imx_fb_data;
@@ -50,7 +50,7 @@ extern const struct imx_mxc_nand_data imx21_mxc_nand_data;
 	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
 
 extern const struct imx_mxc_w1_data imx21_mxc_w1_data;
-#define imx21_add_mxc_w1(pdata)	\
+#define imx21_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx21_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx21_cspi_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx25.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx25.h
index efa0761..f8e03dd 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx25.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx25.h
@@ -24,11 +24,11 @@ extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data;
 	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
 
 extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data;
-#define imx25_add_imxdi_rtc(pdata)	\
+#define imx25_add_imxdi_rtc()	\
 	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
 
 extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data;
-#define imx25_add_imx2_wdt(pdata)	\
+#define imx25_add_imx2_wdt()	\
 	imx_add_imx2_wdt(&imx25_imx2_wdt_data)
 
 extern const struct imx_imx_fb_data imx25_imx_fb_data;
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx27.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx27.h
index 28537a5..436c572 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx27.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx27.h
@@ -18,7 +18,7 @@ extern const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data;
 	imx_add_fsl_usb2_udc(&imx27_fsl_usb2_udc_data, pdata)
 
 extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data;
-#define imx27_add_imx2_wdt(pdata)	\
+#define imx27_add_imx2_wdt()	\
 	imx_add_imx2_wdt(&imx27_imx2_wdt_data)
 
 extern const struct imx_imx_fb_data imx27_imx_fb_data;
@@ -50,7 +50,7 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[];
 extern const struct imx_mx2_camera_data imx27_mx2_camera_data;
 #define imx27_add_mx2_camera(pdata)	\
 	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
-#define imx27_add_mx2_emmaprp(pdata)	\
+#define imx27_add_mx2_emmaprp()	\
 	imx_add_mx2_emmaprp(&imx27_mx2_camera_data)
 
 extern const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data;
@@ -69,7 +69,7 @@ extern const struct imx_mxc_nand_data imx27_mxc_nand_data;
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
 
 extern const struct imx_mxc_w1_data imx27_mxc_w1_data;
-#define imx27_add_mxc_w1(pdata)	\
+#define imx27_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx27_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx27_cspi_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx31.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx31.h
index 911c2da..8b2ceb4 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx31.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx31.h
@@ -14,7 +14,7 @@ extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data;
 	imx_add_fsl_usb2_udc(&imx31_fsl_usb2_udc_data, pdata)
 
 extern const struct imx_imx2_wdt_data imx31_imx2_wdt_data;
-#define imx31_add_imx2_wdt(pdata)       \
+#define imx31_add_imx2_wdt()       \
 	imx_add_imx2_wdt(&imx31_imx2_wdt_data)
 
 extern const struct imx_imx_i2c_data imx31_imx_i2c_data[];
@@ -65,11 +65,11 @@ extern const struct imx_mxc_nand_data imx31_mxc_nand_data;
 	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
 
 extern const struct imx_mxc_rtc_data imx31_mxc_rtc_data;
-#define imx31_add_mxc_rtc(pdata)	\
+#define imx31_add_mxc_rtc()	\
 	imx_add_mxc_rtc(&imx31_mxc_rtc_data)
 
 extern const struct imx_mxc_w1_data imx31_mxc_w1_data;
-#define imx31_add_mxc_w1(pdata)	\
+#define imx31_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx31_mxc_w1_data)
 
 extern const struct imx_spi_imx_data imx31_cspi_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx35.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx35.h
index 6fb9072..e745bc8 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx35.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx35.h
@@ -24,7 +24,7 @@ extern const struct imx_flexcan_data imx35_flexcan_data[];
 #define imx35_add_flexcan1(pdata)	imx35_add_flexcan(1, pdata)
 
 extern const struct imx_imx2_wdt_data imx35_imx2_wdt_data;
-#define imx35_add_imx2_wdt(pdata)       \
+#define imx35_add_imx2_wdt()       \
 	imx_add_imx2_wdt(&imx35_imx2_wdt_data)
 
 extern const struct imx_imx_i2c_data imx35_imx_i2c_data[];
@@ -69,7 +69,7 @@ extern const struct imx_mxc_nand_data imx35_mxc_nand_data;
 	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
 
 extern const struct imx_mxc_w1_data imx35_mxc_w1_data;
-#define imx35_add_mxc_w1(pdata)	\
+#define imx35_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx35_mxc_w1_data)
 
 extern const struct imx_sdhci_esdhc_imx_data imx35_sdhci_esdhc_imx_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx51.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx51.h
index af488bc..9f17187 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx51.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx51.h
@@ -55,7 +55,7 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[];
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
 
 extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data[];
-#define imx51_add_imx2_wdt(id, pdata)	\
+#define imx51_add_imx2_wdt(id)	\
 	imx_add_imx2_wdt(&imx51_imx2_wdt_data[id])
 
 extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx53.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx53.h
index 6e1e5d1..77e0db9 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx53.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx53.h
@@ -30,7 +30,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[];
 	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
 
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[];
-#define imx53_add_imx2_wdt(id, pdata)	\
+#define imx53_add_imx2_wdt(id)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
 
 extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx27.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx27.c
index fe74c84..0f21588 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx27.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx27.c
@@ -266,8 +266,8 @@ static void __init eukrea_cpuimx27_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	imx27_add_imx2_wdt(NULL);
-	imx27_add_mxc_w1(NULL);
+	imx27_add_imx2_wdt();
+	imx27_add_mxc_w1();
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
 	/* SDHC2 can be used for Wifi */
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx35.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx35.c
index 3cd4523..4a82bfe 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx35.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx35.c
@@ -167,7 +167,7 @@ static void __init eukrea_cpuimx35_init(void)
 			ARRAY_SIZE(eukrea_cpuimx35_pads));
 
 	imx35_add_fec(NULL);
-	imx35_add_imx2_wdt(NULL);
+	imx35_add_imx2_wdt();
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&eukrea_cpuimx35_nand_board_info);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx51sd.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx51sd.c
index 1447ccc..2624bdd 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -292,7 +292,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
-	imx51_add_imx2_wdt(0, NULL);
+	imx51_add_imx2_wdt(0);
 
 	gpio_request(ETH_RST, "eth_rst");
 	gpio_set_value(ETH_RST, 1);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-eukrea_cpuimx25.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index d1e04e6..ef99a00 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -134,9 +134,9 @@ static void __init eukrea_cpuimx25_init(void)
 
 	imx25_add_imx_uart0(&uart_pdata);
 	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
-	imx25_add_imxdi_rtc(NULL);
+	imx25_add_imxdi_rtc();
 	imx25_add_fec(&mx25_fec_pdata);
-	imx25_add_imx2_wdt(NULL);
+	imx25_add_imx2_wdt();
 
 	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-imx27ipcam.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-imx27ipcam.c
index c9d350c..7381387 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-imx27ipcam.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -57,7 +57,7 @@ static void __init mx27ipcam_init(void)
 
 	imx27_add_imx_uart0(NULL);
 	imx27_add_fec(NULL);
-	imx27_add_imx2_wdt(NULL);
+	imx27_add_imx2_wdt();
 }
 
 static void __init mx27ipcam_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx25_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx25_3ds.c
index f267342..ce247fd 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx25_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -237,9 +237,9 @@ static void __init mx25pdk_init(void)
 	imx25_add_fsl_usb2_udc(&otg_device_pdata);
 	imx25_add_mxc_ehci_hs(&usbh2_pdata);
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
-	imx25_add_imxdi_rtc(NULL);
+	imx25_add_imxdi_rtc();
 	imx25_add_imx_fb(&mx25pdk_fb_pdata);
-	imx25_add_imx2_wdt(NULL);
+	imx25_add_imx2_wdt();
 
 	mx25pdk_fec_reset();
 	imx25_add_fec(&mx25_fec_pdata);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx27_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx27_3ds.c
index 71f7c58..64278a4 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx27_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -478,7 +478,7 @@ static void __init mx27pdk_init(void)
 	imx27_add_fec(NULL);
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
-	imx27_add_imx2_wdt(NULL);
+	imx27_add_imx2_wdt();
 	otg_phy_init();
 
 	if (otg_mode_host) {
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx27ads.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx27ads.c
index 78b6bb5..7dc59ba 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx27ads.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx27ads.c
@@ -310,7 +310,7 @@ static void __init mx27ads_board_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	imx27_add_mxc_w1(NULL);
+	imx27_add_mxc_w1();
 }
 
 static void __init mx27ads_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx31_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx31_3ds.c
index f37d9b5..1c4eef9 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx31_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -733,7 +733,7 @@ static void __init mx31_3ds_init(void)
 	if (mxc_expio_init(MX31_CS5_BASE_ADDR, IOMUX_TO_GPIO(MX31_PIN_GPIO1_1)))
 		printk(KERN_WARNING "Init of the debug board failed, all "
 				    "devices on the debug board are unusable.\n");
-	imx31_add_imx2_wdt(NULL);
+	imx31_add_imx2_wdt();
 	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx31moboard.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx31moboard.c
index 54d9e5d..d46290b 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx31moboard.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx31moboard.c
@@ -540,7 +540,7 @@ static void __init mx31moboard_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gpio_led_register_device(-1, &mx31moboard_led_pdata);
 
-	imx31_add_imx2_wdt(NULL);
+	imx31_add_imx2_wdt();
 
 	imx31_add_imx_uart0(&uart0_pdata);
 	imx31_add_imx_uart4(&uart4_pdata);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx35_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx35_3ds.c
index e785254..11afe00 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx35_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -561,7 +561,7 @@ static void __init mx35_3ds_init(void)
 	mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads, ARRAY_SIZE(mx35pdk_pads));
 
 	imx35_add_fec(NULL);
-	imx35_add_imx2_wdt(NULL);
+	imx35_add_imx2_wdt();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx51_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx51_3ds.c
index ebb9188..9ee84a4 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx51_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -153,7 +153,7 @@ static void __init mx51_3ds_init(void)
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
 	imx51_add_imx_keypad(&mx51_3ds_map_data);
-	imx51_add_imx2_wdt(0, NULL);
+	imx51_add_imx2_wdt(0);
 }
 
 static void __init mx51_3ds_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx51_babbage.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx51_babbage.c
index dde3970..da40dba 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx51_babbage.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -411,7 +411,7 @@ static void __init mx51_babbage_init(void)
 	spi_register_board_info(mx51_babbage_spi_board_info,
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
 	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
-	imx51_add_imx2_wdt(0, NULL);
+	imx51_add_imx2_wdt(0);
 }
 
 static void __init mx51_babbage_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_ard.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_ard.c
index 27193e7..6c28e65 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_ard.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_ard.c
@@ -244,7 +244,7 @@ static void __init mx53_ard_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
-	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx2_wdt(0);
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_evk.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_evk.c
index 8387496..09fe219 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_evk.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_evk.c
@@ -154,7 +154,7 @@ static void __init mx53_evk_board_init(void)
 	spi_register_board_info(mx53_evk_spi_board_info,
 		ARRAY_SIZE(mx53_evk_spi_board_info));
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
-	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx2_wdt(0);
 	gpio_led_register_device(-1, &mx53evk_leds_data);
 }
 
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_loco.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_loco.c
index e266f3f..8abe23c 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_loco.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_loco.c
@@ -283,7 +283,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
-	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx2_wdt(0);
 
 	ret = gpio_request_one(LOCO_ACCEL_EN, GPIOF_OUT_INIT_HIGH, "accel_en");
 	if (ret)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_smd.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_smd.c
index 4f4c1b9..b15d6a6 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx53_smd.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx53_smd.c
@@ -138,7 +138,7 @@ static void __init mx53_smd_board_init(void)
 	mx53_smd_init_uart();
 	mx53_smd_fec_reset();
 	imx53_add_fec(&mx53_smd_fec_data);
-	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx2_wdt(0);
 	imx53_add_imx_i2c(0, &mx53_smd_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pca100.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pca100.c
index d620a95..5c2352d 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pca100.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pca100.c
@@ -407,8 +407,8 @@ static void __init pca100_init(void)
 	imx27_add_imx_fb(&pca100_fb_data);
 
 	imx27_add_fec(NULL);
-	imx27_add_imx2_wdt(NULL);
-	imx27_add_mxc_w1(NULL);
+	imx27_add_imx2_wdt();
+	imx27_add_mxc_w1();
 }
 
 static void __init pca100_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm037.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm037.c
index ded4ed9..e4a4630 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm037.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm037.c
@@ -613,13 +613,13 @@ static void __init pcm037_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	imx31_add_imx2_wdt(NULL);
+	imx31_add_imx2_wdt();
 	imx31_add_imx_uart0(&uart_pdata);
 	/* XXX: should't this have .flags = 0 (i.e. no RTSCTS) on PCM037_EET? */
 	imx31_add_imx_uart1(&uart_pdata);
 	imx31_add_imx_uart2(&uart_pdata);
 
-	imx31_add_mxc_w1(NULL);
+	imx31_add_mxc_w1();
 
 	/* LAN9217 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm038.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm038.c
index cfb3903..95f49d9 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm038.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm038.c
@@ -334,8 +334,8 @@ static void __init pcm038_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	imx27_add_imx2_wdt(NULL);
-	imx27_add_mxc_w1(NULL);
+	imx27_add_imx2_wdt();
+	imx27_add_mxc_w1();
 
 #ifdef CONFIG_MACH_PCM970_BASEBOARD
 	pcm970_baseboard_init();
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm043.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm043.c
index 133908f..5c52be7 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-pcm043.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-pcm043.c
@@ -359,7 +359,7 @@ static void __init pcm043_init(void)
 
 	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-	imx35_add_imx2_wdt(NULL);
+	imx35_add_imx2_wdt();
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-qong.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-qong.c
index 39ceb8c..fb25fbd 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-qong.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-qong.c
@@ -252,7 +252,7 @@ static void __init qong_init(void)
 	mxc_init_imx_uart();
 	qong_init_nor_mtd();
 	qong_init_fpga();
-	imx31_add_imx2_wdt(NULL);
+	imx31_add_imx2_wdt();
 }
 
 static void __init qong_timer_init(void)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-vpr200.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-vpr200.c
index 09864bb..39eb796 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-vpr200.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-vpr200.c
@@ -267,7 +267,7 @@ static void __init vpr200_board_init(void)
 	mxc_iomux_v3_setup_multiple_pads(vpr200_pads, ARRAY_SIZE(vpr200_pads));
 
 	imx35_add_fec(NULL);
-	imx35_add_imx2_wdt(NULL);
+	imx35_add_imx2_wdt();
 	imx_add_gpio_keys(&vpr200_gpio_keys_data);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mx31lite-db.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mx31lite-db.c
index d639391..83d17d9 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mx31lite-db.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mx31lite-db.c
@@ -192,6 +192,6 @@ void __init mx31lite_db_init(void)
 	imx31_add_mxc_mmc(0, &mmc_pdata);
 	imx31_add_spi_imx0(&spi0_pdata);
 	gpio_led_register_device(-1, &litekit_led_platform_data);
-	imx31_add_imx2_wdt(NULL);
-	imx31_add_mxc_rtc(NULL);
+	imx31_add_imx2_wdt();
+	imx31_add_mxc_rtc();
 }
