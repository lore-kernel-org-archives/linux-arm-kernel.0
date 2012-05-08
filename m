From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:16 +0200
Subject: [PATCH 01/12] ARM: imx: eukrea_cpuimx25: enable workaround ENGcm09152
Message-ID: <1336461627-30315-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this fix usb device controler behaviour in gadget mode

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 76a97a5..b22fb02 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -106,6 +106,7 @@ static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
 static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_UTMI,
+	.workaround     = FLS_USB2_WORKAROUND_ENGCM09152,
 };
 
 static int otg_mode_host;
-- 
1.7.7.6
