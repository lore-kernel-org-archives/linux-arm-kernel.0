From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:30 +0200
Subject: [PATCH 25/25] can: mpc5xxx_can: make data used as *of_device_id.data
 const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 06adf88..8a8df82 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -380,12 +380,12 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
 }
 #endif
 
-static struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
+static const struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
 	.type = MSCAN_TYPE_MPC5200,
 	.get_clock = mpc52xx_can_get_clock,
 };
 
-static struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
+static const struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
 	.type = MSCAN_TYPE_MPC5121,
 	.get_clock = mpc512x_can_get_clock,
 };
-- 
1.7.10.4
