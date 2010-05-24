From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:40 +0200
Subject: [PATCH 05/16] arm/mx2/pca100: add #ifdef to fix compiler warning
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/mach-mx2/mach-pca100.c:261: warning: 'otg_pdata' defined but not used
	arch/arm/mach-mx2/mach-pca100.c:273: warning: 'usbh2_pdata' defined but not used

for build having USB_ULPI disabled.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/mach-pca100.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 778fff2..da94279 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -252,6 +252,7 @@ static struct imxmmc_platform_data sdhc_pdata = {
 	.exit = pca100_sdhc2_exit,
 };
 
+#if defined(CONFIG_USB_ULPI)
 static int otg_phy_init(struct platform_device *pdev)
 {
 	gpio_set_value(OTG_PHY_CS_GPIO, 0);
@@ -275,6 +276,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
+#endif
 
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
-- 
1.7.0
