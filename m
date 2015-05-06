From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 6 May 2015 15:23:40 +0800
Subject: [PATCH v4 1/3] mfd: provide RTC resource in MT6397 MFD
In-Reply-To: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1430897022-63357-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide MT6397 RTC interrupt, base address, and register in
MT6397 MFD.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6397-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 09bc780..4027623 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -21,9 +21,27 @@
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 
+#define MT6397_RTC_BASE		0xe000
+#define MT6397_RTC_SIZE		0x3e
+
+static const struct resource mt6397_rtc_resources[] = {
+	{
+		.start = MT6397_RTC_BASE,
+		.end   = MT6397_RTC_BASE + MT6397_RTC_SIZE,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = MT6397_IRQ_RTC,
+		.end   = MT6397_IRQ_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static const struct mfd_cell mt6397_devs[] = {
 	{
 		.name = "mt6397-rtc",
+		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
+		.resources = mt6397_rtc_resources,
 		.of_compatible = "mediatek,mt6397-rtc",
 	}, {
 		.name = "mt6397-regulator",
-- 
1.8.1.1.dirty
