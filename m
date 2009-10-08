From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:19 +0200
Subject: [PATCH 3/6] mx25pdk: remove nand support as it is not present in
	current tree
In-Reply-To: <1254988042-16737-3-git-send-email-s.hauer@pengutronix.de>
References: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1254988042-16737-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/mx25pdk.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index 92aa4fd..e99d7bb 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -23,19 +23,12 @@ static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct mxc_nand_platform_data nand_board_info = {
-	.width = 1,
-	.hw_ecc = 1,
-};
-
 static void __init mx25pdk_init(void)
 {
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_usbh2, NULL);
-	mxc_register_device(&mxc_nand_device, &nand_board_info);
 }
 
-
 static void __init mx25pdk_timer_init(void)
 {
 	mx25_clocks_init(26000000);
-- 
1.6.4.3
