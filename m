From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 21 May 2010 06:52:06 +0200
Subject: [PATCH] pcm037/pcm043/pca100: fix ULPI-related build warnings
Message-ID: <1274417526-7267-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like this one (if CONFIG_USB_ULPI is not set):

arch/arm/mach-mx3/mach-pcm043.c:312: warning: 'otg_pdata' defined but not used
arch/arm/mach-mx3/mach-pcm043.c:317: warning: 'usbh1_pdata' defined but not used

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/mach-pca100.c |    2 ++
 arch/arm/mach-mx3/mach-pcm037.c |    2 ++
 arch/arm/mach-mx3/mach-pcm043.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index a87422e..7651d0e 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -253,6 +253,7 @@ static struct imxmmc_platform_data sdhc_pdata = {
 	.exit = pca100_sdhc2_exit,
 };
 
+#if defined(CONFIG_USB_ULPI)
 static int otg_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(OTG_PHY_CS_GPIO, 0);
@@ -276,6 +277,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
+#endif
 
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index d19ba54..9f1d27f 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -545,6 +545,7 @@ static struct platform_device pcm970_sja1000 = {
 	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
 };
 
+#if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -554,6 +555,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
+#endif
 
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 78d9185..8071b72 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -309,6 +309,7 @@ static struct mxc_nand_platform_data pcm037_nand_board_info = {
 	.hw_ecc = 1,
 };
 
+#if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_UTMI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -319,6 +320,7 @@ static struct mxc_usbh_platform_data usbh1_pdata = {
 	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
 		  MXC_EHCI_IPPUE_DOWN,
 };
+#endif
 
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
-- 
1.7.0
