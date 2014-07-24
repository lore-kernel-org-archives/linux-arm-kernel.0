From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 24 Jul 2014 13:51:03 +0200
Subject: [PATCH v2 6/6] net/macb: enable scatter-gather feature and set DMA
 burst length for sama5d4 gem
In-Reply-To: <cover.1406192657.git.cyrille.pitchen@atmel.com>
References: <cover.1406192657.git.cyrille.pitchen@atmel.com>
Message-ID: <1918ae71a967c7c58ebd3e0a96fdc0aebde54e80.1406192657.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 6836f88..ca5d779 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -2005,6 +2005,11 @@ static struct macb_config sama5d3_config = {
 	.dma_burst_length = 16,
 };
 
+static struct macb_config sama5d4_config = {
+	.caps = 0,
+	.dma_burst_length = 4,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at32ap7000-macb" },
 	{ .compatible = "cdns,at91sam9260-macb" },
@@ -2012,6 +2017,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
 	{ .compatible = "cdns,gem", .data = &pc302gem_config },
 	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
+	{ .compatible = "atmel,sama5d4-gem", .data = &sama5d4_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
-- 
1.8.2.2
