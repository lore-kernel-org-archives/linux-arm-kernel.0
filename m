From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:01 +0100
Subject: [PATCH 5/9] pcm043: Add NAND support
In-Reply-To: <1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/pcm043.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/pcm043.c b/arch/arm/mach-mx3/pcm043.c
index e18a224..e3aa829 100644
--- a/arch/arm/mach-mx3/pcm043.c
+++ b/arch/arm/mach-mx3/pcm043.c
@@ -43,6 +43,7 @@
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
+#include <mach/mxc_nand.h>
 
 #include "devices.h"
 
@@ -206,6 +207,11 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_ATA_CS0__GPIO2_6,
 };
 
+static struct mxc_nand_platform_data pcm037_nand_board_info = {
+	.width = 1,
+	.hw_ecc = 1,
+};
+
 /*
  * Board specific initialization.
  */
@@ -216,6 +222,7 @@ static void __init mxc_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
 
 	mxc_register_device(&mxc_uart_device1, &uart_pdata);
 
-- 
1.6.5.2
