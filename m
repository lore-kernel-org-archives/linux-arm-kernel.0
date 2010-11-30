From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 17:45:43 -0200
Subject: [PATCH v4 3/3] ARM: mx5: fix keypad clock name
In-Reply-To: <1291146343-25808-2-git-send-email-fabio.estevam@freescale.com>
References: <1291146343-25808-1-git-send-email-fabio.estevam@freescale.com>
	<1291146343-25808-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291146343-25808-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving to dynamically registration of the keypad, the keypad clock
name needs to change accordingly.

The reason is that the original mx5 keypad platform_device id was 0, 
now we use id=-1 as per arch/arm/plat-mxc/devices/platform-imx-keypad.c.

Tested keypad successfully on a MX51_3DS board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 344ee8e..57fea05 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1091,7 +1091,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
-	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
 	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-- 
1.6.0.4
