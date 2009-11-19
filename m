From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 19 Nov 2009 15:23:06 +0100
Subject: [PATCH 5/7] mx31moboard: initialize ipu device for all the boards
In-Reply-To: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1258640588-12705-6-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 20ce5a0..fa306dc 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -40,6 +40,7 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
+#include <mach/ipu.h>
 #include <mach/i2c.h>
 #include <mach/mmc.h>
 #include <mach/spi.h>
@@ -387,6 +388,10 @@ static void mx31moboard_init_sel_gpios(void)
 	}
 }
 
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&mx31moboard_flash,
 	&mx31moboard_leds_device,
@@ -424,6 +429,8 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
 
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+
 	usb_xcvr_reset();
 
 	moboard_usbotg_init();
-- 
1.6.3.3
