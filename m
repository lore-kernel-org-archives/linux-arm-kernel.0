From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 18 Jun 2010 16:19:55 +0200
Subject: [PATCH 2/2] mach-cpuimx27: fix USB_ULPI build warnings
In-Reply-To: <1276870795-21594-1-git-send-email-eric@eukrea.com>
References: <1276870795-21594-1-git-send-email-eric@eukrea.com>
Message-ID: <1276870795-21594-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when CONFIG_USB_ULPI is not defined we actually get :
warning: 'otg_pdata' defined but not used
warning: 'usbh2_pdata' defined but not used

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: s.hauer at pengutronix.de
---
 arch/arm/mach-mx2/mach-cpuimx27.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index dc2dca3..5529178 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -219,6 +219,7 @@ static struct platform_device serial_device = {
 };
 #endif
 
+#if defined(CONFIG_USB_ULPI)
 static struct mxc_usbh_platform_data otg_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
@@ -228,6 +229,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.portsc	= MXC_EHCI_MODE_ULPI,
 	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
 };
+#endif
 
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
-- 
1.6.3.3
