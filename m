From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 17 May 2010 12:33:42 +0200
Subject: [PATCH V2 5/6] arm/mx25: add watchdog device
In-Reply-To: <20100517094925.GT31199@pengutronix.de>
References: <20100517094925.GT31199@pengutronix.de>
Message-ID: <1274092423-16644-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Juergen Beisert <jbe@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |   15 +++++++++++++++
 arch/arm/mach-mx25/devices.h |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

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
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 39560e1..cee12c0 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -21,3 +21,4 @@ extern struct platform_device mx25_fec_device;
 extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
+extern struct platform_device mxc_wdt;
-- 
1.7.0
