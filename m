From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:34 +0100
Subject: [PATCH 02/19] eukrea_cpuimx25: enable workaround ENGcm09152
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this fix usb device controler behaviour in gadget mode

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index ab8fbcc..33a4c74 100644
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
1.7.6.4
