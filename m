From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 23 Mar 2018 21:30:37 +0900
Subject: [PATCH 2/2] net: ethernet: ave: add UniPhier PXs3 support
In-Reply-To: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1521808237-3623-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string and SoC data for ethernet controller on
UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f5c5984..0b3b7a4 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1701,6 +1701,10 @@ static const struct ave_soc_data ave_ld20_data = {
 	.is_desc_64bit = true,
 };
 
+static const struct ave_soc_data ave_pxs3_data = {
+	.is_desc_64bit = false,
+};
+
 static const struct of_device_id of_ave_match[] = {
 	{
 		.compatible = "socionext,uniphier-pro4-ave4",
@@ -1718,6 +1722,10 @@ static const struct of_device_id of_ave_match[] = {
 		.compatible = "socionext,uniphier-ld20-ave4",
 		.data = &ave_ld20_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-ave4",
+		.data = &ave_pxs3_data,
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_ave_match);
-- 
2.7.4
