From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 19 Jan 2011 10:27:33 -0200
Subject: [PATCH] ARM: mx5: Use dummy clock for the keypad
Message-ID: <1295440053-9897-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse dummy_clk for the imx-keypad device instead of using a dedicated kpp_clk.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index ce4ffd7..dc2ce0d 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -867,10 +867,6 @@ static struct clk gpt_32k_clk = {
 	.parent = &ckil_clk,
 };
 
-static struct clk kpp_clk = {
-	.id = 0,
-};
-
 static struct clk dummy_clk = {
 	.id = 0,
 };
@@ -1302,7 +1298,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-- 
1.6.0.4
