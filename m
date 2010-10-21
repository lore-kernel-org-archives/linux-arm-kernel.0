From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 00:23:44 +0800
Subject: [PATCH 1/2] mx35_3ds: add mmc support
In-Reply-To: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
References: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <1287678225-11066-2-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update mx35_3ds board support to register esdhc device

Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 096fd33..f50b489 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -145,6 +145,7 @@ config MACH_MX35_3DS
 	select ARCH_MX35
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_ESDHC
 	default n
 	help
 	  Include support for MX35PDK platform. This includes specific
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 91bb065..f0277c2 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -108,6 +108,13 @@ static struct pad_desc mx35pdk_pads[] = {
 	/* USBH1 */
 	MX35_PAD_I2C2_CLK__USB_TOP_USBH2_PWR,
 	MX35_PAD_I2C2_DAT__USB_TOP_USBH2_OC,
+	/* SDCARD */
+	MX35_PAD_SD1_CMD__ESDHC1_CMD,
+	MX35_PAD_SD1_CLK__ESDHC1_CLK,
+	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
 /* OTG config */
@@ -140,6 +147,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_usbh1, &usb_host_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
+	imx35_add_esdhc(0, NULL);
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.7.1
