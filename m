From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 17 Nov 2009 15:09:56 +0100
Subject: [PATCH] imx/eukrea_cpuimx27: use new nand device registration
In-Reply-To: <20091117095613.GB7407@pengutronix.de>
References: <20091117095613.GB7407@pengutronix.de>
Message-ID: <1258466996-13923-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

patches 17-24 now look like below and are updated in my tree[1].

Best regards
Uwe

[1] git://git.pengutronix.de/git/ukl/linux-2.6.git imx

 arch/arm/mach-mx2/eukrea_cpuimx27.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_cpuimx27.c b/arch/arm/mach-mx2/eukrea_cpuimx27.c
index 7b18760..efaea46 100644
--- a/arch/arm/mach-mx2/eukrea_cpuimx27.c
+++ b/arch/arm/mach-mx2/eukrea_cpuimx27.c
@@ -38,7 +38,6 @@
 #include <mach/i2c.h>
 #include <mach/iomux.h>
 #include <mach/imx-uart.h>
-#include <mach/mxc_nand.h>
 
 #include "devices.h"
 
@@ -119,7 +118,7 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
+static const struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -189,7 +188,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 
-	mxc_register_device(&mxc_nand_device, &eukrea_cpuimx27_nand_board_info);
+	imx27_add_mxc_nand(&eukrea_cpuimx27_nand_board_info);
 
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
-- 
1.6.5.2
