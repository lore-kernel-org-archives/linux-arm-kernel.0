From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  9 Nov 2018 10:42:07 +0900
Subject: [PATCH 4/4] reset: uniphier-glue: Add AHCI reset control support in
 glue layer
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1541727727-10821-5-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a reset line included in AHCI glue layer to enable AHCI core
implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier-glue.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 1b8ea03..a45923f 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -152,6 +152,18 @@ static const struct of_device_id uniphier_glue_reset_match[] = {
 		.compatible = "socionext,uniphier-pxs3-usb3-reset",
 		.data = &uniphier_pxs2_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pro4-ahci-reset",
+		.data = &uniphier_pro4_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-ahci-reset",
+		.data = &uniphier_pxs2_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-ahci-reset",
+		.data = &uniphier_pxs2_data,
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_glue_reset_match);
-- 
2.7.4
