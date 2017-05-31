From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 1 Jun 2017 02:44:14 +0800
Subject: [PATCH 2/4] hwrng: mtk - add support for MT7622 SoC
In-Reply-To: <cover.1496255334.git.sean.wang@mediatek.com>
References: <cover.1496255334.git.sean.wang@mediatek.com>
Message-ID: <2e2280eb36dbb00d3a7f56062889252f3e25a63d.1496255334.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add "mediatek,generic-rng" allowing most of RNG on MediaTek SoCs to be
compatible with the driver including MT7622 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/char/hw_random/mtk-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index df8eb54..3a1e1f1 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -148,6 +148,7 @@ static int mtk_rng_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_rng_match[] = {
+	{ .compatible = "mediatek,generic-rng" },
 	{ .compatible = "mediatek,mt7623-rng" },
 	{},
 };
-- 
1.9.1
