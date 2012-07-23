From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:23 +0200
Subject: [PATCH 18/25] can: mpc5xxx_can: make data in mpc5xxx_can_probe const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 5caa572..06adf88 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
 static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
-	struct mpc5xxx_can_data *data;
+	const struct mpc5xxx_can_data *data;
 	struct device_node *np = ofdev->dev.of_node;
 	struct net_device *dev;
 	struct mscan_priv *priv;
-- 
1.7.10.4
