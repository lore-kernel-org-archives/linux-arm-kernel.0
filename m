From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 24 Oct 2017 19:57:14 +0200
Subject: [PATCH v9 10/10] net: stmmac: sun8i: Restore the compatibles
In-Reply-To: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
Message-ID: <20171024175714.15840-11-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original dwmac-sun8i DT bindings have some issue on how to handle
integrated PHY and was reverted in last RC of 4.13.
But now we have a solution so we need to get back that was reverted.

This patch restore compatibles about dwmac-sun8i
This reverts commit ad4540cc5aa3 ("net: stmmac: sun8i: Remove the compatibles")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b3eb344bb158..e5ff734d4f9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1072,6 +1072,14 @@ return ret;
 }
 
 static const struct of_device_id sun8i_dwmac_match[] = {
+	{ .compatible = "allwinner,sun8i-h3-emac",
+		.data = &emac_variant_h3 },
+	{ .compatible = "allwinner,sun8i-v3s-emac",
+		.data = &emac_variant_v3s },
+	{ .compatible = "allwinner,sun8i-a83t-emac",
+		.data = &emac_variant_a83t },
+	{ .compatible = "allwinner,sun50i-a64-emac",
+		.data = &emac_variant_a64 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);
-- 
2.13.6
