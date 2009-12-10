From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 19:42:27 +0100
Subject: [PATCH 1/4] MXC: imx31pdk: Add support for on board NAND Flash.
In-Reply-To: <1260470224.2141.37.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
Message-ID: <1260470547.2141.42.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add support for the CPU Board NAND device. Remember to
enable (if using) the RedBoot partition table parsing support
and to pointing it to the right flash page number.

Signed-off-by: Alberto Panizzo <alberto.panizzo@gmail.com>
---
 arch/arm/mach-mx3/mx31pdk.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31pdk.c b/arch/arm/mach-mx3/mx31pdk.c
index 0f7a2f0..ca1fe5d 100644
--- a/arch/arm/mach-mx3/mx31pdk.c
+++ b/arch/arm/mach-mx3/mx31pdk.c
@@ -34,6 +34,7 @@
 #include <mach/board-mx31pdk.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
+#include <mach/mxc_nand.h>
 #include "devices.h"
 
 /*!
@@ -53,6 +54,14 @@ static int mx31pdk_pins[] = {
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
 };
 
+/*
+ * NAND Flash
+ */
+static struct mxc_nand_platform_data imx31pdk_nand_flash_pdata = {
+	.width		= 1,
+	.hw_ecc		= 1,
+};
+
 static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -241,6 +250,7 @@ static void __init mxc_board_init(void)
 				      "mx31pdk");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_nand_device, &imx31pdk_nand_flash_pdata);
 
 	if (!mx31pdk_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
