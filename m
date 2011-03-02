From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 2 Mar 2011 11:26:49 -0300
Subject: [PATCH] ARM: mx3/mx35_3ds: Use MX35 USB OTG Erratum
Message-ID: <1299076009-14253-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 5f35d5c..f2cec07 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -132,6 +132,11 @@ static int mx35_3ds_otg_init(struct platform_device *pdev)
 static const struct fsl_usb2_platform_data usb_otg_pdata __initconst = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
+	.workaround	= FLS_USB2_WORKAROUND_ENGCM09152,
+/*
+ * ENGCM09152 also requires a hardware change.
+ * Please check the MX35 Chip Errata document for details.
+ */
 };
 
 static struct mxc_usbh_platform_data otg_pdata __initdata = {
-- 
1.6.0.4
