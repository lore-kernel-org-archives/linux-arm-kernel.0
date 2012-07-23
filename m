From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:11 +0200
Subject: [PATCH 06/25] misc/atmel_tc: make atmel_tc.tcb_config member point to
 const data
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/misc/atmel_tclib.c: In function 'tc_probe':
	drivers/misc/atmel_tclib.c:170: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 include/linux/atmel_tc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
index 1d14b1dc..89a931b 100644
--- a/include/linux/atmel_tc.h
+++ b/include/linux/atmel_tc.h
@@ -63,7 +63,7 @@ struct atmel_tc {
 	struct platform_device	*pdev;
 	struct resource		*iomem;
 	void __iomem		*regs;
-	struct atmel_tcb_config	*tcb_config;
+	const struct atmel_tcb_config *tcb_config;
 	int			irq[3];
 	struct clk		*clk[3];
 	struct list_head	node;
-- 
1.7.10.4
