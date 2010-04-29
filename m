From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 29 Apr 2010 10:03:21 +0200
Subject: [PATCH 5/6] arm/mx25: add watchdog device
In-Reply-To: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1272528202-24159-6-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3f4b8a0..3a405fa 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -500,3 +500,18 @@ struct platform_device mx25_fb_device = {
 		.coherent_dma_mask = 0xFFFFFFFF,
 	},
 };
+
+static struct resource mxc_wdt_resources[] = {
+	{
+		.start = MX25_WDOG_BASE_ADDR,
+		.end = MX25_WDOG_BASE_ADDR + SZ_16K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device mxc_wdt = {
+	.name = "imx2-wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
+	.resource = mxc_wdt_resources,
+};
-- 
1.7.0
