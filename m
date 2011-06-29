From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 20:00:17 +0200
Subject: [PATCH 3/5] ASoC: atmel-ssc: dmaengine usage switch depending on cpu
In-Reply-To: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <bb630ee8242145fa926ee0b0147e0851d3e5b34f.1309368631.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/atmel-ssc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 2bab4b4..52b4c20 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -3,6 +3,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/list.h>
+#include <mach/cpu.h>
 
 struct ssc_device {
 	struct list_head	list;
@@ -310,4 +311,6 @@ void ssc_free(struct ssc_device *ssc);
 #define ssc_readl(base, reg)		__raw_readl(base + SSC_##reg)
 #define ssc_writel(base, reg, value)	__raw_writel((value), base + SSC_##reg)
 
+#define ssc_use_dmaengine()	cpu_is_at91sam9x5()
+
 #endif /* __INCLUDE_ATMEL_SSC_H */
-- 
1.7.3
