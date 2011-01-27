From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:22 +0100
Subject: [PATCH 02/13] ARM i.MX35 pcm043: put usbh1 outside CONFIG_USB_ULPI
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usbh1 port of the pcm043 does not use ulpi, so put it outside
the corresponding ifdefs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index a27022d..a515290 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -310,13 +310,13 @@ static struct mxc_usbh_platform_data otg_pdata __initdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
+#endif
 
 static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.portsc	= MXC_EHCI_MODE_SERIAL,
 	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
 		  MXC_EHCI_IPPUE_DOWN,
 };
-#endif
 
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
@@ -382,9 +382,9 @@ static void __init mxc_board_init(void)
 
 		imx35_add_mxc_ehci_otg(&otg_pdata);
 	}
-
-	imx35_add_mxc_ehci_hs(&usbh1_pdata);
 #endif
+	imx35_add_mxc_ehci_hs(&usbh1_pdata);
+
 	if (!otg_mode_host)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
-- 
1.7.2.3
