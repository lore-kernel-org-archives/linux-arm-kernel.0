From: chen.zhong@mediatek.com (Chen Zhong)
Date: Wed, 27 Sep 2017 18:44:08 +0800
Subject: [PATCH v5 6/6] mfd: mt6397: Add PMIC keys support to MT6397 driver
In-Reply-To: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Message-ID: <1506509048-19032-7-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds compatible strings and interrupts for pmic keys
which serves as child device of MFD.

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/mfd/mt6397-core.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 6546d7f..77b64bd 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -43,6 +43,16 @@
 	},
 };
 
+static const struct resource mt6323_keys_resources[] = {
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_PWRKEY),
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_FCHRKEY),
+};
+
+static const struct resource mt6397_keys_resources[] = {
+	DEFINE_RES_IRQ(MT6397_IRQ_PWRKEY),
+	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
+};
+
 static const struct mfd_cell mt6323_devs[] = {
 	{
 		.name = "mt6323-regulator",
@@ -50,6 +60,11 @@
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
 
@@ -71,7 +86,12 @@
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
