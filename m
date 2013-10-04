From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  4 Oct 2013 14:44:40 +0200
Subject: [PATCH 2/2] net/ethernet: cpsw: DT read bool dual_emac
In-Reply-To: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
References: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1380890680-30941-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 5df50a9..804846e 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1771,8 +1771,8 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 	}
 	data->mac_control = prop;
 
-	if (!of_property_read_u32(node, "dual_emac", &prop))
-		data->dual_emac = prop;
+	if (of_property_read_bool(node, "dual_emac"))
+		data->dual_emac = 1;
 
 	/*
 	 * Populate all the child nodes here...
-- 
1.8.4.rc3
