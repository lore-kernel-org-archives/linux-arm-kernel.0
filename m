From: chen.zhong@mediatek.com (Chen Zhong)
Date: Wed, 2 Aug 2017 11:17:20 +0800
Subject: [PATCH 4/4] mfd: mt6397: Add PMIC keys support to MT6397 driver
In-Reply-To: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <1501643840-21485-5-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds compatible strings and interrupts for pmic keys
which serves as child device of MFD.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/mfd/mt6397-core.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 04a601f..a3225b6 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -43,6 +43,22 @@
 	},
 };
 
+static const struct resource mt6323_keys_resources[] = {
+	{
+		.start = MT6323_IRQ_STATUS_PWRKEY,
+		.end   = MT6323_IRQ_STATUS_FCHRKEY,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static const struct resource mt6397_keys_resources[] = {
+	{
+		.start = MT6397_IRQ_PWRKEY,
+		.end   = MT6397_IRQ_HOMEKEY,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static const struct mfd_cell mt6323_devs[] = {
 	{
 		.name = "mt6323-regulator",
@@ -50,6 +66,11 @@
 	}, {
 		.name = "mt6323-led",
 		.of_compatible = "mediatek,mt6323-led"
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
+		.resources = mt6323_keys_resources,
+		.of_compatible = "mediatek,mt6323-keys"
 	},
 };
 
@@ -71,7 +92,12 @@
 	}, {
 		.name = "mt6397-pinctrl",
 		.of_compatible = "mediatek,mt6397-pinctrl",
-	},
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
+		.resources = mt6397_keys_resources,
+		.of_compatible = "mediatek,mt6397-keys"
+	}
 };
 
 static void mt6397_irq_lock(struct irq_data *data)
-- 
1.7.9.5
