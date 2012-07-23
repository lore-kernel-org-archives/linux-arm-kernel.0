From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:15 +0200
Subject: [PATCH 10/25] i2c/mpc: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/i2c/busses/i2c-mpc.c: In function 'fsl_i2c_probe':
	drivers/i2c/busses/i2c-mpc.c:650:31: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index b76731e..775062c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -647,7 +647,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
 	}
 
 	if (match->data) {
-		struct mpc_i2c_data *data = match->data;
+		const struct mpc_i2c_data *data = match->data;
 		data->setup(op->dev.of_node, i2c, clock, data->prescaler);
 	} else {
 		/* Backwards compatibility */
-- 
1.7.10.4
