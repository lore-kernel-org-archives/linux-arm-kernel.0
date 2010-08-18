From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 18 Aug 2010 18:24:56 +0200
Subject: [PATCH|RESEND 1/2] mx35_3ds: rename usb otg platform data variable
	name
In-Reply-To: <1282147005-4358-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1282147005-4358-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282148696-9312-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Rename the variable holding the usb otg platform data to avoid clash
with usb host platform data variable.

usb_pdata -> usb_otg_pdata

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index b3629e7..ae0f17c 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -108,7 +108,7 @@ static struct pad_desc mx35pdk_pads[] = {
 };
 
 /* OTG config */
-static struct fsl_usb2_platform_data usb_pdata = {
+static struct fsl_usb2_platform_data usb_otg_pdata = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
@@ -124,7 +124,7 @@ static void __init mxc_board_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 
-	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+	mxc_register_device(&mxc_otg_udc_device, &usb_otg_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 }
-- 
1.7.1
