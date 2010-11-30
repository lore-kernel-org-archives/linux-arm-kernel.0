From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 15:19:33 -0200
Subject: [PATCH] ARM: mx5: fix keypad clock
Message-ID: <1291137573-8855-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following error during keypad driver probe:

imx-keypad imx-keypad: failed to get keypad clock
imx-keypad: probe of imx-keypad failed with error -2

Register keypad clock the same way as other imx platforms.

Tested keypad succesfully on a MX51_3DS board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 344ee8e..86fa0f4 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1091,7 +1091,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
-	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-- 
1.6.0.4
