From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 24 Mar 2010 14:32:17 +0300
Subject: [PATCH 2/3] imx3: Add rtc platform device support
In-Reply-To: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
References: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for build-in RTC device found on
Freescale imx31 and imx35 SoCs.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |   19 +++++++++++++++++++
 arch/arm/mach-mx3/devices.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index f891115..1ffed28 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -588,6 +588,25 @@ struct platform_device imx_wdt_device0 = {
 	.resource       = imx_wdt_resources,
 };
 
+static struct resource imx_rtc_resources[] = {
+	{
+		.start  = MX31_RTC_BASE_ADDR,
+		.end    = MX31_RTC_BASE_ADDR + 0x3fff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = MX31_INT_RTC,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_rtc_device0 = {
+	.name           = "mxc_rtc",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
+	.resource       = imx_rtc_resources,
+};
+
 static int __init mx3_devices_init(void)
 {
 	if (cpu_is_mx31()) {
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 4f77eb5..b1687ad 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -27,3 +27,4 @@ extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_wdt_device0;
+extern struct platform_device imx_rtc_device0;
-- 
1.6.6.1
