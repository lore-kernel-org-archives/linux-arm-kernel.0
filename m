From: xerofoify@gmail.com (Nicholas Krause)
Date: Tue,  8 Jul 2014 21:58:39 -0400
Subject: [PATCH] Removes FIXME message in usb.c
Message-ID: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes a fixme message in this file:wq for setting the usb 2
speed on the board to the correct level. We need to depend on the
bootloader for doing this as the wires may be shared for the other
things on the board with the usb chipset.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-omap1/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 4118db5..172245a 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -505,7 +505,7 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
 		omap_cfg_reg(W5_USB2_SE0);
 		if (nwires != 3)
 			omap_cfg_reg(Y5_USB2_RCV);
-		// FIXME omap_cfg_reg(USB2_SPEED);
+		/* Depend on boatloader for USB speed to be stated for board */
 	} else {
 		pr_debug("usb%d cpu unrecognized\n", 1);
 		return 0;
-- 
1.9.1
