From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:00 +0200
Subject: [PATCH 04/61] ARM: mx1/scb9328: fix type of uart1_mxc_exit to make
	compiler happy
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/mach-mx1/mach-scb9328.c:120: warning: initialization from incompatible pointer type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/mach-scb9328.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
index 7c6bbe8..ed2ff16 100644
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -108,11 +108,10 @@ static int uart1_mxc_init(struct platform_device *pdev)
 			ARRAY_SIZE(mxc_uart1_pins), "UART1");
 }
 
-static int uart1_mxc_exit(struct platform_device *pdev)
+static void uart1_mxc_exit(struct platform_device *pdev)
 {
 	mxc_gpio_release_multiple_pins(mxc_uart1_pins,
 			ARRAY_SIZE(mxc_uart1_pins));
-	return 0;
 }
 
 static struct imxuart_platform_data uart_pdata = {
-- 
1.7.1
