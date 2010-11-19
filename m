From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 19 Nov 2010 22:02:02 +0100
Subject: [PATCH 52/51] ARM: imx: fix name for functions adding sdhci-esdhc-imx
	devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290200522-20191-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and restore alphabetic ordering.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                          |    4 +-
 arch/arm/mach-imx/devices-imx25.h                  |    9 ++-
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +-
 arch/arm/mach-mx3/Kconfig                          |   12 ++--
 arch/arm/mach-mx3/devices-imx35.h                  |    9 ++-
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |    2 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c                  |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |    2 +-
 arch/arm/mach-mx5/Kconfig                          |    6 +-
 arch/arm/mach-mx5/board-mx51_babbage.c             |    4 +-
 arch/arm/mach-mx5/devices-imx51.h                  |    9 ++-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |    4 +-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |    2 +-
 arch/arm/plat-mxc/devices/Kconfig                  |    6 +-
 arch/arm/plat-mxc/devices/Makefile                 |    2 +-
 arch/arm/plat-mxc/devices/platform-esdhc.c         |   71 -------------------
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   74 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h    |   20 +++---
 19 files changed, 124 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/devices/platform-esdhc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ed713e5..41b6450 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -93,7 +93,6 @@ comment "MX25 platforms:"
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select SOC_IMX25
-	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -101,11 +100,11 @@ config MACH_MX25_3DS
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 
 config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
 	select SOC_IMX25
-	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
@@ -114,6 +113,7 @@ config MACH_EUKREA_CPUIMX25
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
 
 choice
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index 953e1ce..760e66c 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -74,13 +74,14 @@ extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
 
+extern const struct imx_sdhci_esdhc_imx_data
+imx25_sdhci_esdhc_imx_data[] __initconst;
+#define imx25_add_sdhci_esdhc_imx(id, pdata)	\
+	imx_add_sdhci_esdhc_imx(&imx25_sdhci_esdhc_imx_data[id], pdata)
+
 extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
 #define imx25_add_spi_imx(id, pdata)	\
 	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
 #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
-
-extern const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst;
-#define imx25_add_esdhc(id, pdata)	\
-	imx_add_esdhc(&imx25_esdhc_data[id], pdata)
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 75a5db5..7cab720 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -275,7 +275,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx25_add_flexcan1(NULL);
-	imx25_add_esdhc(0, NULL);
+	imx25_add_sdhci_esdhc_imx(0, NULL);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index f07d3d7..52b4d9b 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -200,7 +200,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_fec(&mx25_fec_pdata);
 	imx25_add_imx_keypad(&mx25pdk_keymap_data);
 
-	imx25_add_esdhc(0, NULL);
+	imx25_add_sdhci_esdhc_imx(0, NULL);
 }
 
 static void __init mx25pdk_timer_init(void)
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 8df139f..a682c03 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -145,6 +145,7 @@ config MACH_QONG
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -152,8 +153,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm043 platform. This includes
@@ -176,12 +176,12 @@ config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select SOC_IMX35
 	select MXC_DEBUG_BOARD
-	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -197,14 +197,14 @@ config MACH_KZM_ARM11_01
 config MACH_EUKREA_CPUIMX35
 	bool "Support Eukrea CPUIMX35 Platform"
 	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX35 platform. This includes
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index c9fdded..677b18a 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -64,12 +64,13 @@ extern const struct imx_mxc_w1_data imx35_mxc_w1_data __initconst;
 #define imx35_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx35_mxc_w1_data)
 
+extern const struct imx_sdhci_esdhc_imx_data
+imx35_sdhci_esdhc_imx_data[] __initconst;
+#define imx35_add_sdhci_esdhc_imx(id, pdata)	\
+	imx_add_sdhci_esdhc_imx(&imx35_sdhci_esdhc_imx_data[id], pdata)
+
 extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 #define imx35_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
 #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
-
-extern const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst;
-#define imx35_add_esdhc(id, pdata)	\
-	imx_add_esdhc(&imx35_esdhc_data[id], pdata)
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 1abc10d..950dbb1 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -289,7 +289,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx35_add_flexcan1(NULL);
-	imx35_add_esdhc(0, NULL);
+	imx35_add_sdhci_esdhc_imx(0, NULL);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index d5ca7ea..7e73153 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -150,7 +150,7 @@ static void __init mxc_board_init(void)
 	imx35_add_mxc_ehci_hs(&usb_host_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
-	imx35_add_esdhc(0, NULL);
+	imx35_add_sdhci_esdhc_imx(0, NULL);
 
 	if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		pr_warn("Init of the debugboard failed, all "
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index f2f2fd0..826c6dc 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -393,7 +393,7 @@ static void __init mxc_board_init(void)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
 	imx35_add_flexcan1(NULL);
-	imx35_add_esdhc(0, NULL);
+	imx35_add_sdhci_esdhc_imx(0, NULL);
 }
 
 static void __init pcm043_timer_init(void)
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 3ec910a..95cb0a8 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -14,7 +14,7 @@ config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
@@ -47,7 +47,7 @@ choice
 config MACH_EUKREA_MBIMX51_BASEBOARD
 	prompt "Eukrea MBIMX51 development board"
 	bool
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMX51 evaluation board.
@@ -72,7 +72,7 @@ choice
 config MACH_EUKREA_MBIMXSD51_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index acbe30d..542f2b1 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -349,8 +349,8 @@ static void __init mxc_board_init(void)
 	mxc_iomux_v3_setup_pad(&usbh1stp);
 	babbage_usbhub_reset();
 
-	imx51_add_esdhc(0, NULL);
-	imx51_add_esdhc(1, NULL);
+	imx51_add_sdhci_esdhc_imx(0, NULL);
+	imx51_add_sdhci_esdhc_imx(1, NULL);
 }
 
 static void __init mx51_babbage_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 8c50cb5..01b71ef 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -31,6 +31,11 @@ extern const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst;
 #define imx51_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx51_mxc_nand_data, pdata)
 
+extern const struct imx_sdhci_esdhc_imx_data
+imx51_sdhci_esdhc_imx_data[] __initconst;
+#define imx51_add_sdhci_esdhc_imx(id, pdata)	\
+	imx_add_sdhci_esdhc_imx(&imx51_sdhci_esdhc_imx_data[id], pdata)
+
 extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 #define imx51_add_cspi(pdata)	\
 	imx_add_spi_imx(&imx51_cspi_data, pdata)
@@ -38,7 +43,3 @@ extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
-
-extern const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst;
-#define imx51_add_esdhc(id, pdata)	\
-	imx_add_esdhc(&imx51_esdhc_data[id], pdata)
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index a2e6e8c..4e74b99 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -217,6 +217,6 @@ void __init eukrea_mbimx51_baseboard_init(void)
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
 
-	imx51_add_esdhc(0, NULL);
-	imx51_add_esdhc(1, NULL);
+	imx51_add_sdhci_esdhc_imx(0, NULL);
+	imx51_add_sdhci_esdhc_imx(1, NULL);
 }
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 2b48f51..038d8c9 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -149,7 +149,7 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 	imx51_add_imx_uart(1, NULL);
 	imx51_add_imx_uart(2, &uart_pdata);
 
-	imx51_add_esdhc(0, NULL);
+	imx51_add_sdhci_esdhc_imx(0, NULL);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index f34c139..b391f4d 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,6 +1,3 @@
-config IMX_HAVE_PLATFORM_ESDHC
-	bool
-
 config IMX_HAVE_PLATFORM_FEC
 	bool
 	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || ARCH_MX51
@@ -69,5 +66,8 @@ config IMX_HAVE_PLATFORM_MXC_RNGA
 config IMX_HAVE_PLATFORM_MXC_W1
 	bool
 
+config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	bool
+
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 91fdd6c..75cd2ec 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,4 +1,3 @@
-obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
@@ -21,4 +20,5 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
deleted file mode 100644
index 013e92f..0000000
--- a/arch/arm/plat-mxc/devices/platform-esdhc.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix, Wolfram Sang <w.sang@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-
-#include <mach/hardware.h>
-#include <mach/devices-common.h>
-#include <mach/esdhc.h>
-
-#define imx_esdhc_imx_data_entry_single(soc, _id, hwid) \
-	{								\
-		.id = _id,						\
-		.iobase = soc ## _ESDHC ## hwid ## _BASE_ADDR,	\
-		.irq = soc ## _INT_ESDHC ## hwid,			\
-	}
-
-#define imx_esdhc_imx_data_entry(soc, id, hwid)	\
-	[id] = imx_esdhc_imx_data_entry_single(soc, id, hwid)
-
-#ifdef CONFIG_SOC_IMX25
-const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst = {
-#define imx25_esdhc_data_entry(_id, _hwid)				\
-	imx_esdhc_imx_data_entry(MX25, _id, _hwid)
-	imx25_esdhc_data_entry(0, 1),
-	imx25_esdhc_data_entry(1, 2),
-};
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
-#ifdef CONFIG_SOC_IMX35
-const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
-#define imx35_esdhc_data_entry(_id, _hwid)                           \
-	imx_esdhc_imx_data_entry(MX35, _id, _hwid)
-	imx35_esdhc_data_entry(0, 1),
-	imx35_esdhc_data_entry(1, 2),
-	imx35_esdhc_data_entry(2, 3),
-};
-#endif /* ifdef CONFIG_SOC_IMX35 */
-
-#ifdef CONFIG_ARCH_MX51
-const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
-#define imx51_esdhc_data_entry(_id, _hwid)				\
-	imx_esdhc_imx_data_entry(MX51, _id, _hwid)
-	imx51_esdhc_data_entry(0, 1),
-	imx51_esdhc_data_entry(1, 2),
-	imx51_esdhc_data_entry(2, 3),
-	imx51_esdhc_data_entry(3, 4),
-};
-#endif /* ifdef CONFIG_ARCH_MX51 */
-
-struct platform_device *__init imx_add_esdhc(
-		const struct imx_esdhc_imx_data *data,
-		const struct esdhc_platform_data *pdata)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_16K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irq,
-			.end = data->irq,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-
-	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
-			ARRAY_SIZE(res), pdata, sizeof(*pdata));
-}
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
new file mode 100644
index 0000000..167cce8
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2010 Pengutronix, Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/esdhc.h>
+
+#define imx_sdhci_esdhc_imx_data_entry_single(soc, _id, hwid) \
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _ESDHC ## hwid ## _BASE_ADDR,	\
+		.irq = soc ## _INT_ESDHC ## hwid,			\
+	}
+
+#define imx_sdhci_esdhc_imx_data_entry(soc, id, hwid)	\
+	[id] = imx_sdhci_esdhc_imx_data_entry_single(soc, id, hwid)
+
+#ifdef CONFIG_SOC_IMX25
+const struct imx_sdhci_esdhc_imx_data
+imx25_sdhci_esdhc_imx_data[] __initconst = {
+#define imx25_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
+	imx_sdhci_esdhc_imx_data_entry(MX25, _id, _hwid)
+	imx25_sdhci_esdhc_imx_data_entry(0, 1),
+	imx25_sdhci_esdhc_imx_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX25 */
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_sdhci_esdhc_imx_data
+imx35_sdhci_esdhc_imx_data[] __initconst = {
+#define imx35_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
+	imx_sdhci_esdhc_imx_data_entry(MX35, _id, _hwid)
+	imx35_sdhci_esdhc_imx_data_entry(0, 1),
+	imx35_sdhci_esdhc_imx_data_entry(1, 2),
+	imx35_sdhci_esdhc_imx_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
+#ifdef CONFIG_ARCH_MX51
+const struct imx_sdhci_esdhc_imx_data
+imx51_sdhci_esdhc_imx_data[] __initconst = {
+#define imx51_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
+	imx_sdhci_esdhc_imx_data_entry(MX51, _id, _hwid)
+	imx51_sdhci_esdhc_imx_data_entry(0, 1),
+	imx51_sdhci_esdhc_imx_data_entry(1, 2),
+	imx51_sdhci_esdhc_imx_data_entry(2, 3),
+	imx51_sdhci_esdhc_imx_data_entry(3, 4),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
+struct platform_device *__init imx_add_sdhci_esdhc_imx(
+		const struct imx_sdhci_esdhc_imx_data *data,
+		const struct esdhc_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
+			ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 5a62dc4..3640eaf 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -242,6 +242,16 @@ struct imx_mxc_w1_data {
 struct platform_device *__init imx_add_mxc_w1(
 		const struct imx_mxc_w1_data *data);
 
+#include <mach/esdhc.h>
+struct imx_sdhci_esdhc_imx_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_sdhci_esdhc_imx(
+		const struct imx_sdhci_esdhc_imx_data *data,
+		const struct esdhc_platform_data *pdata);
+
 #include <mach/spi.h>
 struct imx_spi_imx_data {
 	const char *devid;
@@ -253,13 +263,3 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
-
-#include <mach/esdhc.h>
-struct imx_esdhc_imx_data {
-	int id;
-	resource_size_t iobase;
-	resource_size_t irq;
-};
-struct platform_device *__init imx_add_esdhc(
-		const struct imx_esdhc_imx_data *data,
-		const struct esdhc_platform_data *pdata);
-- 
1.7.2.3
