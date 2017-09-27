From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 27 Sep 2017 09:34:07 +0200
Subject: [PATCH v6 04/11] net: stmmac: sun8i: Restore the compatibles
In-Reply-To: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
Message-ID: <20170927073414.17361-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch restore compatibles about dwmac-sun8i
This reverts commit ad4540cc5aa3 ("net: stmmac: sun8i: Remove the compatibles")

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 39c2122a4f26..fffd6d5fc907 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -979,6 +979,14 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
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
2.13.5
