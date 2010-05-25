From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 25 May 2010 16:46:54 +0200
Subject: [PATCH 2/5] ARM: mx3: pxm043: fix compiler warning
In-Reply-To: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
References: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
Message-ID: <1274798817-21805-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For configs without CONFIG_USB_ULPI, the compiler complains about

  CC      arch/arm/mach-mx3/mach-pcm043.o
  arch/arm/mach-mx3/mach-pcm043.c:312: warning: 'otg_pdata' defined but not used
  arch/arm/mach-mx3/mach-pcm043.c:317: warning: 'usbh1_pdata' defined but not used

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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
1.7.1
